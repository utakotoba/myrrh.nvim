local palette = require 'myrrh.palette'
local config = require 'myrrh.config'

--- @class Myrrh
local M = {}

M.setup = config.setup

--- Get color palette based on current config,
--- useful to access color sources in runtime.
--- @return {
---   raw: Myrrh.Palette.Raw,
---   ansi: Myrrh.Palette.ANSI,
--- }
function M.get_palette()
  return {
    raw = palette.raw,
    ansi = palette.get_ansi_palette(palette.raw),
  }
end

--- Load colorscheme based on current configs
function M.load()
  local raw_palette = palette.setup(config.cfg)
end

return M
