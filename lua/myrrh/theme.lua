local utils = require 'myrrh.color_utils'

local M = {}

--- Color Theme Tokens
---
--- @class Myrrh.Theme
--- @field bg Myrrh.Theme.Background Background color tokens
--- @field fg Myrrh.Theme.Foreground Foreground color tokens
--- @field stateful Myrrh.Theme.Stateful Stateful color tokens
--- @field accent Myrrh.Theme.Accent Accent color tokens

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

--- Accent Color Tokens
---
--- @class Myrrh.Theme.Accent
--- @field balance Myrrh.Theme.AccentUnit
--- @field bloom Myrrh.Theme.AccentUnit
--- @field growth Myrrh.Theme.AccentUnit
--- @field anchor Myrrh.Theme.AccentUnit
--- @field vista Myrrh.Theme.AccentUnit
--- @field twilight Myrrh.Theme.AccentUnit
--- @field immersion Myrrh.Theme.AccentUnit
--- @field whisper Myrrh.Theme.AccentUnit

--- Accent Color Unit
---
--- @class Myrrh.Theme.AccentUnit
--- @field base Myrrh.HexColor
--- @field alt Myrrh.HexColor
--- @field tint Myrrh.HexColor

--- Helper function setup theme colors
--- @param rp Myrrh.Palette.Raw
--- @return Myrrh.Theme
function M.setup(rp)
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
    accent = {
      balance = {
        base = rp.stanza,
        alt = rp.lull,
        tint = utils.darken_and_desaturate(rp.stanza, 44, 4),
      },
      bloom = {
        base = rp.petal,
        alt = rp.ardor,
        tint = utils.darken_and_desaturate(rp.petal, 44, 24),
      },
      growth = {
        base = rp.sprout,
        alt = rp.grove,
        tint = utils.darken_and_desaturate(rp.sprout, 48, 16),
      },
      anchor = {
        base = rp.dune,
        alt = rp.leather,
        tint = utils.darken_and_desaturate(rp.dune, 46, 16),
      },
      vista = {
        base = rp.mirage,
        alt = rp.zenith,
        tint = utils.darken_and_desaturate(rp.mirage, 46, 24),
      },
      twilight = {
        base = rp.solace,
        alt = rp.epilogue,
        tint = utils.darken_and_desaturate(rp.solace, 44, 24),
      },
      immersion = {
        base = rp.still,
        alt = rp.refuge,
        tint = utils.darken_and_desaturate(rp.still, 46, 20),
      },
      whisper = {
        base = rp.linen,
        alt = rp.halo,
        tint = utils.darken_and_desaturate(rp.linen, 56, 8),
      },
    },
  }

  return resolved
end

return M
