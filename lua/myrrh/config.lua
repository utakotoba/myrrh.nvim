local M = {}

--- Override some colors of the raw palette to
--- make foundation changes to colot tone.
---
--- @class Myrrh.Config.PartialRawPalette
--- @field stanza? string
--- @field lull? string
--- @field petal? string
--- @field ardor? string
--- @field sprout? string
--- @field grove? string
--- @field dune? string
--- @field leather? string
--- @field mirage? string
--- @field zenith? string
--- @field solace? string
--- @field epilogue? string
--- @field still? string
--- @field refuge? string
--- @field linen? string
--- @field halo? string
--- @field nocturne? string
--- @field remnant? string

--- @class Myrrh.Config
--- @field undertext? boolean Enable under* in highlighting
--- @field italic? boolean Enable italic text in highlighting
--- @field transparent? boolean Enable transparency
--- @field raw_palette_override? Myrrh.Config.PartialRawPalette

--- @type Myrrh.Config
M.defaults = {
  undertext = false,
  italic = false,
  transparent = false,
  raw_palette_override = {},
}

--- @type Myrrh.Config
M.cfg = nil

--- Helper function to setup Myrrh colorscheme
--- @param cfg Myrrh.Config
function M.setup(cfg)
  M.cfg = vim.tbl_deep_extend('force', M.defaults, cfg or {})
end

return M
