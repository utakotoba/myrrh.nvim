local utils = require 'myrrh.color_utils'

local M = {}

--- Color Theme Tokens
---
--- @class Myrrh.Theme
--- @field bg Myrrh.Theme.Background Background color tokens
--- @field fg Myrrh.Theme.Foreground Foreground color tokens
--- @field stateful Myrrh.Theme.Stateful Stateful color tokens
--- @field raw Myrrh.Palette.Raw
--- @field ansi Myrrh.Palette.ANSI

--- Background Color Tokens
---
--- @class Myrrh.Theme.Background
--- @field dim Myrrh.HexColor Farthest background, used in editor basic
--- @field base Myrrh.HexColor Default content background, alias to dim
--- @field surface Myrrh.HexColor Slightly raised areas background (stl, popup, etc.)
--- @field layer Myrrh.HexColor Elevated background (floatings, menus, etc.)
--- @field active Myrrh.HexColor Hovered or active items background
--- @field overlay Myrrh.HexColor Transient layer background

--- Foreground Color Tokens
---
--- @class Myrrh.Theme.Foreground
--- @field primary Myrrh.HexColor Default text color
--- @field secondary Myrrh.HexColor Subdued text color
--- @field muted Myrrh.HexColor Dim or disabled text color
--- @field inverse Myrrh.HexColor Text color on colored surface

--- Stateful Color Tokens
---
--- @class Myrrh.Theme.Stateful
--- @field success Myrrh.HexColor Success state accent color
--- @field warning Myrrh.HexColor Warning state accent color
--- @field error Myrrh.HexColor Error state accent color
--- @field info Myrrh.HexColor Info state accent color
--- @field hint Myrrh.HexColor Hint state accent color

--- Helper function setup theme colors
--- @param rp Myrrh.Palette.Raw
--- @param ap Myrrh.Palette.ANSI
--- @return Myrrh.Theme
function M.setup(rp, ap)
  --- @type Myrrh.Theme
  local resolved = {
    bg = {
      dim = rp.nocturne,
      base = rp.nocturne,
      surface = utils.lighten(rp.nocturne, 8),
      layer = utils.lighten(rp.nocturne, 16),
      active = utils.lighten(rp.nocturne, 20),
      overlay = utils.lighten(rp.nocturne, 24),
    },
    fg = {
      primary = rp.remnant,
      secondary = utils.darken(rp.remnant, 16),
      muted = utils.darken(rp.remnant, 32),
      inverse = utils.lighten(rp.nocturne, 36),
    },
    stateful = {
      success = rp.sprout,
      warning = rp.dune,
      error = rp.petal,
      info = rp.stanza,
      hint = rp.solace,
    },
    raw = rp,
    ansi = ap,
  }

  return resolved
end

return M
