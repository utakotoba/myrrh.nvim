--- @diagnostic disable: need-check-nil

--[[
Modified HSLuv implementation with some color adjustment functions
Original HSLuv: http://www.hsluv.org/
Copyright (C) 2019 Alexei Boronine (HSLuv core)
]]

local color_utils = {}

-- Performance optimization: cache math functions
local floor, sqrt, abs, sin, cos, atan2, min, max =
  math.floor,
  math.sqrt,
  math.abs,
  math.sin,
  math.cos,
  math.atan2,
  math.min,
  math.max
local PI = math.pi

-- Constants
local HEX_CHARS = '0123456789abcdef'
local M = {
  { 3.240969941904521, -1.537383177570093, -0.498610760293 },
  { -0.96924363628087, 1.87596750150772, 0.041555057407175 },
  { 0.055630079696993, -0.20397695888897, 1.056971514242878 },
}
local MINV = {
  { 0.41239079926595, 0.35758433938387, 0.18048078840183 },
  { 0.21263900587151, 0.71516867876775, 0.072192315360733 },
  { 0.019330818715591, 0.11919477979462, 0.95053215224966 },
}
local REF_Y = 1.0
local REF_U = 0.19783000664283
local REF_V = 0.46831999493879
local KAPPA = 903.2962962
local EPSILON = 0.0088564516

-- Helper functions
local function length_of_ray_until_intersect(theta, line)
  return line.intercept / (sin(theta) - line.slope * cos(theta))
end

local function dot_product(a, b)
  return a[1] * b[1] + a[2] * b[2] + a[3] * b[3]
end

local function from_linear(c)
  if c <= 0.0031308 then
    return 12.92 * c
  else
    return 1.055 * (c ^ 0.416666666666666685) - 0.055
  end
end

local function to_linear(c)
  if c > 0.04045 then
    return ((c + 0.055) / 1.055) ^ 2.4
  else
    return c / 12.92
  end
end

-- Core HSLuv functions
local function get_bounds(l)
  local result = {}
  local sub_1 = ((l + 16) ^ 3) / 1560896
  local sub_2 = sub_1 > EPSILON and sub_1 or l / KAPPA

  for i = 1, 3 do
    local m_1, m_2, m_3 = M[i][1], M[i][2], M[i][3]

    for t = 0, 1 do
      local top_1 = (284517 * m_1 - 94839 * m_3) * sub_2
      local top_2 = (838422 * m_3 + 769860 * m_2 + 731718 * m_1) * l * sub_2
        - 769860 * t * l
      local bottom = (632260 * m_3 - 126452 * m_2) * sub_2 + 126452 * t
      result[#result + 1] = {
        slope = top_1 / bottom,
        intercept = top_2 / bottom,
      }
    end
  end
  return result
end

local function max_safe_chroma_for_lh(l, h)
  local h_rad = h / 360 * PI * 2
  local bounds = get_bounds(l)
  local min_dist = 1.7976931348623157e+308

  for i = 1, 6 do
    local length = length_of_ray_until_intersect(h_rad, bounds[i])
    if length >= 0 then
      min_dist = min(min_dist, length)
    end
  end
  return min_dist
end

local function xyz_to_rgb(tuple)
  return {
    from_linear(dot_product(M[1], tuple)),
    from_linear(dot_product(M[2], tuple)),
    from_linear(dot_product(M[3], tuple)),
  }
end

local function rgb_to_xyz(tuple)
  local rgbl = { to_linear(tuple[1]), to_linear(tuple[2]), to_linear(tuple[3]) }
  return {
    dot_product(MINV[1], rgbl),
    dot_product(MINV[2], rgbl),
    dot_product(MINV[3], rgbl),
  }
end

local function y_to_l(y)
  if y <= EPSILON then
    return y / REF_Y * KAPPA
  else
    return 116 * ((y / REF_Y) ^ 0.333333333333333315) - 16
  end
end

local function l_to_y(l)
  if l <= 8 then
    return REF_Y * l / KAPPA
  else
    return REF_Y * (((l + 16) / 116) ^ 3)
  end
end

local function xyz_to_luv(tuple)
  local x, y, z = tuple[1], tuple[2], tuple[3]
  local divider = x + 15 * y + 3 * z
  local var_u, var_v = 4 * x, 9 * y

  if divider ~= 0 then
    var_u = var_u / divider
    var_v = var_v / divider
  else
    var_u, var_v = 0, 0
  end

  local l = y_to_l(y)
  if l == 0 then
    return { 0, 0, 0 }
  end
  return { l, 13 * l * (var_u - REF_U), 13 * l * (var_v - REF_V) }
end

local function luv_to_xyz(tuple)
  local l, u, v = tuple[1], tuple[2], tuple[3]
  if l == 0 then
    return { 0, 0, 0 }
  end

  local var_u = u / (13 * l) + REF_U
  local var_v = v / (13 * l) + REF_V
  local y = l_to_y(l)
  local x = 0 - (9 * y * var_u) / (((var_u - 4) * var_v) - var_u * var_v)
  return { x, y, (9 * y - 15 * var_v * y - var_v * x) / (3 * var_v) }
end

local function luv_to_lch(tuple)
  local l, u, v = tuple[1], tuple[2], tuple[3]
  local c = sqrt(u * u + v * v)
  local h

  if c < 0.00000001 then
    h = 0
  else
    h = atan2(v, u) * 180.0 / PI
    if h < 0 then
      h = 360 + h
    end
  end
  return { l, c, h }
end

local function lch_to_luv(tuple)
  local l, c, h = tuple[1], tuple[2], tuple[3]
  local h_rad = h / 360.0 * 2 * PI
  return { l, cos(h_rad) * c, sin(h_rad) * c }
end

local function hsluv_to_lch(tuple)
  local h, s, l = tuple[1], tuple[2], tuple[3]
  if l > 99.9999999 then
    return { 100, 0, h }
  end
  if l < 0.00000001 then
    return { 0, 0, h }
  end
  return { l, max_safe_chroma_for_lh(l, h) / 100 * s, h }
end

local function lch_to_hsluv(tuple)
  local l, c, h = tuple[1], tuple[2], tuple[3]
  local max_chroma = max_safe_chroma_for_lh(l, h)

  if l > 99.9999999 then
    return { h, 0, 100 }
  end
  if l < 0.00000001 then
    return { h, 0, 0 }
  end
  return { h, c / max_chroma * 100, l }
end

--- Converts RGB to hex
--- @param tuple table RGB values 0-1
--- @return string Hex color
local function rgb_to_hex(tuple)
  local h = '#'
  for i = 1, 3 do
    local c = floor(tuple[i] * 255 + 0.5)
    local digit_2 = c % 16
    local digit_1 = floor((c - digit_2) / 16)
    h = h
      .. HEX_CHARS:sub(digit_1 + 1, digit_1 + 1)
      .. HEX_CHARS:sub(digit_2 + 1, digit_2 + 1)
  end
  return h
end

--- Converts hex to RGB
--- @param hex string Hex color
--- @return table RGB values 0-1
local function hex_to_rgb(hex)
  hex = hex:lower():gsub('#', '')
  local ret = {}
  for i = 0, 2 do
    local char_1 = hex:sub(i * 2 + 1, i * 2 + 1)
    local char_2 = hex:sub(i * 2 + 2, i * 2 + 2)
    local digit_1 = HEX_CHARS:find(char_1, 1, true) - 1
    local digit_2 = HEX_CHARS:find(char_2, 1, true) - 1
    ret[i + 1] = (digit_1 * 16 + digit_2) / 255.0
  end
  return ret
end

local function lch_to_rgb(tuple)
  return xyz_to_rgb(luv_to_xyz(lch_to_luv(tuple)))
end

local function rgb_to_lch(tuple)
  return luv_to_lch(xyz_to_luv(rgb_to_xyz(tuple)))
end

local function hsluv_to_rgb(tuple)
  return lch_to_rgb(hsluv_to_lch(tuple))
end

local function rgb_to_hsluv(tuple)
  return lch_to_hsluv(rgb_to_lch(tuple))
end

--- Converts hex to HSLuv
--- @param s string Hex color
--- @return table HSLuv values {H, S, L}
local function hex_to_hsluv(s)
  return rgb_to_hsluv(hex_to_rgb(s))
end

--- Converts HSLuv to hex
--- @param tuple table HSLuv values {H, S, L}
--- @return string Hex color
local function hsluv_to_hex(tuple)
  return rgb_to_hex(hsluv_to_rgb(tuple))
end

-- Color adjustment functions

--- Lightens a hex color by increasing lightness
--- @param hex string Hex color string
--- @param amount number Amount to lighten 0-100
--- @return string Lightened hex color
function color_utils.lighten(hex, amount)
  local hsl = hex_to_hsluv(hex)
  --- @diagnostic disable-next-line: assign-type-mismatch
  hsl[3] = min(100, hsl[3] + amount)
  return hsluv_to_hex(hsl)
end

--- Darkens a hex color by decreasing lightness
--- @param hex string Hex color string
--- @param amount number Amount to darken 0-100
--- @return string Darkened hex color
function color_utils.darken(hex, amount)
  local hsl = hex_to_hsluv(hex)
  --- @diagnostic disable-next-line: assign-type-mismatch
  hsl[3] = max(0, hsl[3] - amount)
  return hsluv_to_hex(hsl)
end

--- Saturates a hex color by increasing saturation
--- @param hex string Hex color string
--- @param amount number Amount to saturate 0-100
--- @return string Saturated hex color
function color_utils.saturate(hex, amount)
  local hsl = hex_to_hsluv(hex)
  --- @diagnostic disable-next-line: assign-type-mismatch
  hsl[2] = min(100, hsl[2] + amount)
  return hsluv_to_hex(hsl)
end

--- Desaturates a hex color by decreasing saturation
--- @param hex string Hex color string
--- @param amount number Amount to desaturate 0-100
--- @return string Desaturated hex color
function color_utils.desaturate(hex, amount)
  local hsl = hex_to_hsluv(hex)
  --- @diagnostic disable-next-line: assign-type-mismatch
  hsl[2] = max(0, hsl[2] - amount)
  return hsluv_to_hex(hsl)
end

--- Darkens and desaturates a hex color together
--- @param hex string Hex color string
--- @param darken_amount number Amount to darken 0-100
--- @param desaturate_amount number Amount to desaturate 0-100
--- @return string Darkened hex color
function color_utils.darken_and_desaturate(
  hex,
  darken_amount,
  desaturate_amount
)
  local hsl = hex_to_hsluv(hex)
  --- @diagnostic disable-next-line: assign-type-mismatch
  hsl[3] = max(0, hsl[3] - darken_amount)
  --- @diagnostic disable-next-line: assign-type-mismatch
  hsl[2] = max(0, hsl[2] - desaturate_amount)
  return hsluv_to_hex(hsl)
end

--- Blends two hex colors together
--- @param hex_1 string First hex color
--- @param hex_2 string Second hex color
--- @param ratio number Blend ratio 0-1
--- @return string Blended hex color
function color_utils.blend(hex_1, hex_2, ratio)
  ratio = max(0, min(1, ratio))
  local hsl_1 = hex_to_hsluv(hex_1)
  local hsl_2 = hex_to_hsluv(hex_2)

  -- Handle hue wrapping for shortest path
  local h_1, h_2 = hsl_1[1], hsl_2[1]
  local h_diff = h_2 - h_1
  if h_diff > 180 then
    h_1 = h_1 + 360
  elseif h_diff < -180 then
    h_2 = h_2 + 360
  end

  local blended = {
    (h_1 * (1 - ratio) + h_2 * ratio) % 360,
    hsl_1[2] * (1 - ratio) + hsl_2[2] * ratio,
    hsl_1[3] * (1 - ratio) + hsl_2[3] * ratio,
  }
  return hsluv_to_hex(blended)
end

color_utils.hex_to_hsluv = hex_to_hsluv
color_utils.hsluv_to_hex = hsluv_to_hex
color_utils.hex_to_rgb = hex_to_rgb
color_utils.rgb_to_hex = rgb_to_hex

return color_utils
