local M = {}

local highlight_setting_list = {
  'editor',
}

--- Apply highlights to current neovim session
--- @param highlights table
--- @param ap Myrrh.Palette.ANSI
function M.load(highlights, ap)
  for hl, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, spec)
  end
end

--- Helper function to create highlight group
--- @param theme_palette Myrrh.Theme
--- @param config Myrrh.Config
function M.setup(theme_palette, config)
  local highlights = {}

  for _, name in ipairs(highlight_setting_list) do
    local ok, setting = pcall(require, 'myrrh.highlights.' .. name)
    if ok then
      --- @diagnostic disable-next-line: undefined-field, need-check-nil
      for hl_name, spec in pairs(setting.setup(theme_palette, config)) do
        highlights[hl_name] = spec
      end
    end
  end

  return highlights
end

return M
