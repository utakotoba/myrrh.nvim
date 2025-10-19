local M = {}

--- @param tp Myrrh.Theme
--- @param cfg Myrrh.Config
function M.setup(tp, cfg)
  --- @type table<string, vim.api.keyset.highlight>
  local hls = {
    -- Variables ---------------------------------------------------
    ['@variable'] = { fg = tp.fg.primary, underline = cfg.undertext },
    ['@variable.builtin'] = { fg = tp.raw.solace, italic = true, bold = true },
    ['@variable.parameter'] = {
      fg = tp.raw.sprout,
      underdashed = cfg.undertext,
    },
    ['@variable.member'] = { fg = tp.raw.dune, underdashed = cfg.undertext },

    -- Strings -----------------------------------------------------
    ['@string'] = { fg = tp.raw.sprout },
    ['@string.regexp'] = { fg = tp.raw.grove },
    ['@string.escape'] = { fg = tp.raw.sprout, underline = cfg.undertext },
    ['@string.special.symbol'] = { fg = tp.raw.dune },
    ['@string.special.url'] = { fg = tp.raw.mirage, underline = true },

    -- Attributes --------------------------------------------------
    ['@Attribute'] = { link = 'Constant' },

    -- Constructors ------------------------------------------------
    ['@constructor'] = { fg = tp.raw.solace },
    ['@constructor.lua'] = { fg = tp.raw.petal },

    -- Operators & Keywords ----------------------------------------
    ['@operator'] = { link = 'Operator' },
    ['@keyword'] = { fg = tp.raw.petal, italic = true },
    ['@keyword.operator'] = { fg = tp.raw.dune, bold = true },

    -- Punctuation -------------------------------------------------
    -- ['@punctuation.delimiter'] = { fg = theme.syn.punct },
    -- ['@punctuation.bracket'] = { fg = theme.syn.punct },
    -- ['@punctuation.special'] = { fg = theme.syn.special1 },

    -- Comments ----------------------------------------------------
    ['@comment'] = { fg = tp.raw.stanza, italic = cfg.italic },

    -- Markup ------------------------------------------------------
    ['@markup.strong'] = { bold = true },
    ['@markup.italic'] = { italic = true },
    ['@markup.strikethrough'] = { strikethrough = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.heading'] = { link = 'Function' },
    ['@markup.quote'] = { link = '@variable.parameter' },
    ['@markup.math'] = { link = 'Constant' },
    ['@markup.environment'] = { link = 'Keyword' },
    ['@markup.link.url'] = { link = '@string.special.url' },
    ['@markup.raw'] = { link = 'String' },

    -- Diff --------------------------------------------------------
    ['@diff.plus'] = { fg = tp.raw.still },
    ['@diff.minus'] = { fg = tp.raw.petal },
    ['@diff.delta'] = { fg = tp.raw.dune },
  }

  return hls
end

return M
