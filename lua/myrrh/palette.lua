local M = {}

--- @alias Myrrh.HexColor string Color RGB Hex string

--- Myrrh Raw Color Palette
---
--- The source of all color variants.
--- Named with the feel and touch of each color.
---
--- @class Myrrh.Palette.Raw
M.raw = {
  --- @nodoc balance
  --- @type Myrrh.HexColor
  stanza = '#879389',
  --- @type Myrrh.HexColor
  lull = '#B3BDB5',

  --- @nodoc bloom
  --- @type Myrrh.HexColor
  petal = '#E37F80',
  --- @type Myrrh.HexColor
  ardor = '#EC6765',

  --- @nodoc growth
  --- @type Myrrh.HexColor
  sprout = '#9BC28B',
  --- @type Myrrh.HexColor
  grove = '#95C481',

  --- @nodoc anchor
  --- @type Myrrh.HexColor
  dune = '#E0B38A',
  --- @type Myrrh.HexColor
  leather = '#E9A364',

  --- @nodoc vista
  --- @type Myrrh.HexColor
  mirage = '#75B9BA',
  --- @type Myrrh.HexColor
  zenith = '#62A4CB',

  --- @nodoc twilight
  --- @type Myrrh.HexColor
  solace = '#B7A3D2',
  --- @type Myrrh.HexColor
  epilogue = '#C29CF2',

  --- @nodoc immersion
  --- @type Myrrh.HexColor
  still = '#79BF9A',
  --- @type Myrrh.HexColor
  refuge = '#4BB088',

  --- @nodoc whisper
  --- @type Myrrh.HexColor
  linen = '#eae9d9',
  --- @type Myrrh.HexColor
  halo = '#faf9eb',

  --- @nodoc duality
  --- @type Myrrh.HexColor
  nocturne = '#1c1f21',
  --- @type Myrrh.HexColor
  remnant = '#d0c4ab',
}

--- Myrrh ANSI 16 Color
---
--- The ANSI map of all raw colors.
---
--- @class Myrrh.Palette.ANSI
--- @field color_0 Myrrh.HexColor Normal Black
--- @field color_1 Myrrh.HexColor Normal Red
--- @field color_2 Myrrh.HexColor Normal Green
--- @field color_3 Myrrh.HexColor Normal Yellow
--- @field color_4 Myrrh.HexColor Normal Blue
--- @field color_5 Myrrh.HexColor Normal Magenta
--- @field color_6 Myrrh.HexColor Normal Cyan
--- @field color_7 Myrrh.HexColor Normal White
--- @field color_8 Myrrh.HexColor Bright Black
--- @field color_9 Myrrh.HexColor Bright Red
--- @field color_10 Myrrh.HexColor Bright Green
--- @field color_11 Myrrh.HexColor Bright Yellow
--- @field color_12 Myrrh.HexColor Bright Blue
--- @field color_13 Myrrh.HexColor Bright Magenta
--- @field color_14 Myrrh.HexColor Bright Cyan
--- @field color_15 Myrrh.HexColor Bright White

--- Helper function to get ANSI color palette
--- based on current raw color palette.
--- @param source Myrrh.Palette.Raw
--- @return Myrrh.Palette.ANSI
function M.get_ansi_palette(source)
  return {
    color_0 = source.stanza,
    color_1 = source.petal,
    color_2 = source.sprout,
    color_3 = source.dune,
    color_4 = source.mirage,
    color_5 = source.solace,
    color_6 = source.still,
    color_7 = source.linen,
    color_8 = source.lull,
    color_9 = source.ardor,
    color_10 = source.grove,
    color_11 = source.leather,
    color_12 = source.zenith,
    color_13 = source.epilogue,
    color_14 = source.refuge,
    color_15 = source.halo,
  }
end

--- Setup colorset, used to override Myrrh colors.
--- @param cfg Myrrh.Config
--- @return Myrrh.Palette.Raw, Myrrh.Palette.ANSI
function M.setup(cfg)
  if cfg.raw_palette_override and next(cfg.raw_palette_override) ~= nil then
    --- @type Myrrh.Palette.Raw
    M.raw = vim.tbl_extend('force', M.raw, cfg.raw_palette_override)
  end

  return M.raw, M.get_ansi_palette(M.raw)
end

return M
