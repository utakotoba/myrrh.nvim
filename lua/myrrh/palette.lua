local M = {}

--- Myrrh Raw Color Palette
---
--- The source of all color variants.
--- Named with the feel and touch of each color.
---
--- @class myrrh.palette.Raw
M.raw = {
  --- @nodoc balance
  stanza = '#748176',
  lull = '#97a99a',

  --- @nodoc bloom
  petal = '#e07e7f',
  ardor = '#eb6067',

  --- @nodoc growth
  sprout = '#96bc86',
  grove = '#8fb76a',

  --- @nodoc anchor
  dune = '#e0b38a',
  leather = '#e79d64',

  --- @nodoc vista
  mirage = '#7cb8b9',
  zenith = '#62a4cb',

  --- @nodoc twilight
  solace = '#ac9ac3',
  epilogue = '#a589d3',

  --- @nodoc immersion
  still = '#79bf9a',
  refuge = '#4bb088',

  --- @nodoc whisper
  linen = '#eae9d9',
  halo = '#faf9eb',

  --- @nodoc duality
  nocturne = '#1c1f21',
  remnant = '#d0c4ab',
}

--- Myrrh ANSI 16 Color
---
--- The ANSI map of all raw colors.
---
--- @class myrrh.palette.ANSI
M.ansi = {
  --- @nodoc normal group
  color_0 = M.raw.stanza,
  color_1 = M.raw.petal,
  color_2 = M.raw.sprout,
  color_3 = M.raw.dune,
  color_4 = M.raw.mirage,
  color_5 = M.raw.solace,
  color_6 = M.raw.still,
  color_7 = M.raw.linen,

  --- @nodoc bright group
  color_8 = M.raw.lull,
  color_9 = M.raw.ardor,
  color_10 = M.raw.grove,
  color_11 = M.raw.leather,
  color_12 = M.raw.zenith,
  color_13 = M.raw.epilogue,
  color_14 = M.raw.refuge,
  color_15 = M.raw.halo,

  --- @nodoc base
  background = M.raw.nocturne,
  foreground = M.raw.remnant,
}

return M
