local M = {}

--- @alias Myrrh.ColorHex string Color RGB Hex string

--- Myrrh Raw Color Palette
---
--- The source of all color variants.
--- Named with the feel and touch of each color.
---
--- @class Myrrh.Palette.Raw
M.raw = {
  --- @nodoc balance
  --- @type Myrrh.ColorHex
  stanza = '#748176',
  --- @type Myrrh.ColorHex
  lull = '#97a99a',

  --- @nodoc bloom
  --- @type Myrrh.ColorHex
  petal = '#e07e7f',
  --- @type Myrrh.ColorHex
  ardor = '#eb6067',

  --- @nodoc growth
  --- @type Myrrh.ColorHex
  sprout = '#96bc86',
  --- @type Myrrh.ColorHex
  grove = '#8fb76a',

  --- @nodoc anchor
  --- @type Myrrh.ColorHex
  dune = '#e0b38a',
  --- @type Myrrh.ColorHex
  leather = '#e79d64',

  --- @nodoc vista
  --- @type Myrrh.ColorHex
  mirage = '#7cb8b9',
  --- @type Myrrh.ColorHex
  zenith = '#62a4cb',

  --- @nodoc twilight
  --- @type Myrrh.ColorHex
  solace = '#ac9ac3',
  --- @type Myrrh.ColorHex
  epilogue = '#a589d3',

  --- @nodoc immersion
  --- @type Myrrh.ColorHex
  still = '#79bf9a',
  --- @type Myrrh.ColorHex
  refuge = '#4bb088',

  --- @nodoc whisper
  --- @type Myrrh.ColorHex
  linen = '#eae9d9',
  --- @type Myrrh.ColorHex
  halo = '#faf9eb',

  --- @nodoc duality
  --- @type Myrrh.ColorHex
  nocturne = '#1c1f21',
  --- @type Myrrh.ColorHex
  remnant = '#d0c4ab',
}

--- Myrrh ANSI 16 Color
---
--- The ANSI map of all raw colors.
---
--- @class Myrrh.Palette.ANSI
--- @field color_0 Myrrh.ColorHex Normal Black
--- @field color_1 Myrrh.ColorHex Normal Red
--- @field color_2 Myrrh.ColorHex Normal Green
--- @field color_3 Myrrh.ColorHex Normal Yellow
--- @field color_4 Myrrh.ColorHex Normal Blue
--- @field color_5 Myrrh.ColorHex Normal Magenta
--- @field color_6 Myrrh.ColorHex Normal Cyan
--- @field color_7 Myrrh.ColorHex Normal White
--- @field color_8 Myrrh.ColorHex Bright Black
--- @field color_9 Myrrh.ColorHex Bright Red
--- @field color_10 Myrrh.ColorHex Bright Green
--- @field color_11 Myrrh.ColorHex Bright Yellow
--- @field color_12 Myrrh.ColorHex Bright Blue
--- @field color_13 Myrrh.ColorHex Bright Magenta
--- @field color_14 Myrrh.ColorHex Bright Cyan
--- @field color_15 Myrrh.ColorHex Bright White

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
    background = source.nocturne,
    foreground = source.remnant,
  }
end

--- Setup colorset, used to override Myrrh colors.
--- @param cfg Myrrh.Config
--- @return Myrrh.Palette.Raw
function M.setup(cfg)
  if cfg.raw_palette_override and next(cfg.raw_palette_override) ~= nil then
    --- @type Myrrh.Palette.Raw
    M.raw = vim.tbl_extend('force', M.raw, cfg.raw_palette_override)
  end

  return M.raw
end

return M
