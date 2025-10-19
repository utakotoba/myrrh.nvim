local palette = require 'myrrh.palette'
local config = require 'myrrh.config'
local theme = require 'myrrh.theme'
local highlights = require 'myrrh.highlights'

--- @class Myrrh
local M = {}

M.setup = config.setup

--- Load colorscheme based on current configs
function M.load()
  local rp, ap = palette.setup(config.cfg)
  local tp = theme.setup(rp)
  local hl = highlights.setup(tp, config.cfg)

  -- load colorscheme
  vim.cmd [[hi clear]]
  vim.g.colors_name = 'myrrh'
  vim.o.termguicolors = true
  highlights.load(hl, ap)
end

return M
