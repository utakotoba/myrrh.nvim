local M = {}

--- @param tp Myrrh.Theme
--- @param cfg Myrrh.Config
function M.setup(tp, cfg)
  --- @type table<string, vim.api.keyset.highlight>
  local hls = {
    -- Comment ---------------------------------------------------------------
    Comment = { fg = tp.raw.stanza, italic = cfg.italic },

    -- Constant --------------------------------------------------------------
    Constant = { fg = tp.raw.refuge, underline = cfg.undertext, bold = true },
    String = { fg = tp.raw.sprout },
    Character = { link = 'String' },
    Number = { fg = tp.raw.mirage },
    Float = { link = 'Number' },
    Boolean = { fg = tp.raw.solace },

    -- Identifier ------------------------------------------------------------
    Identifier = { fg = tp.raw.dune, underdashed = cfg.undertext },
    Function = { fg = tp.raw.zenith },

    -- Statement -------------------------------------------------------------
    Statement = { fg = tp.raw.petal },
    Operator = { fg = tp.raw.dune },
    Keyword = { fg = tp.raw.petal, italic = cfg.italic },
    Exception = { fg = tp.raw.ardor },

    -- PreProc ---------------------------------------------------------------
    PreProc = { fg = tp.raw.epilogue },

    -- Type ------------------------------------------------------------------
    Type = { fg = tp.raw.leather, underdotted = cfg.undertext },

    -- Special ---------------------------------------------------------------
    Special = { fg = tp.raw.solace },
    Delimiter = { fg = tp.raw.lull },

    -- Decoration ------------------------------------------------------------
    Underlined = { fg = tp.raw.linen, undercurl = true },
    Bold = { bold = true },
    Italic = { italic = true },

    -- Ignore ---------------------------------------------------------------
    Ignore = { link = 'NonText' },

    -- Error ----------------------------------------------------------------
    Error = { fg = tp.raw.ardor },

    -- Todo -----------------------------------------------------------------
    Todo = { fg = tp.fg.inverse, bg = tp.raw.sprout, bold = true },

    -- Quickfix ---------------------------------------------------------------
    qfLineNr = { link = 'LineNr' },
    qfFileName = { link = 'Directory' },

    -- Markdown ---------------------------------------------------------------
    markdownCode = { fg = tp.raw.sprout },
    markdownCodeBlock = { fg = tp.raw.sprout },
    markdownEscape = { fg = 'NONE' },
  }

  return hls
end

return M
