local M = {}

--- @param tp Myrrh.Theme
--- @param cfg Myrrh.Config
function M.setup(tp, cfg)
  --- @type table<string, vim.api.keyset.highlight>
  local hls = {
    -- Built-in Syntax -------------------------------------------------------

    -- Any code comment
    Comment = { fg = tp.accent.balance.base, italic = cfg.italic },

    -- Any constant (parent group, fallback used)
    Constant = { fg = tp.accent.vista.base },

    -- String constant literal
    String = { fg = tp.accent.growth.base, underdashed = cfg.undertext },

    -- Character constant literal
    Character = { fg = tp.accent.growth.base, bold = true },

    -- Number constant literal
    Number = { fg = tp.accent.twilight.base },

    -- Float constant literal
    Float = { fg = tp.accent.twilight.base },

    -- Boolean constant literal
    Boolean = { fg = tp.accent.twilight.base, bold = true },

    -- Any identifier / variable name, built-in syntax could not tell the
    -- differences between identifier (variables, parameters, etc.)
    Identifier = { fg = tp.accent.vista.base, underline = cfg.undertext },

    -- Any function name
    Function = { fg = tp.accent.immersion.base, italic = cfg.italic },

    -- Any statement (parent group, fallback used)
    Statement = { fg = tp.accent.bloom.base },

    -- Conditional related statements
    Conditional = { fg = tp.accent.bloom.base },

    -- Repeat related statements
    Repeat = { fg = tp.accent.bloom.base },

    -- Label statements
    Label = { fg = tp.accent.anchor.base },

    -- Operator statements
    Operator = { fg = tp.accent.anchor.base },

    -- Any other keyword
    Keyword = { fg = tp.accent.bloom.base },

    -- Exception
    Exception = { fg = tp.accent.bloom.alt },

    -- Any pre-proccessor (parent group, fallback used)
    PreProc = { fg = tp.accent.growth.base },

    -- Include pre-proccessor
    Include = { fg = tp.accent.growth.base },

    -- Define pre-proccessor
    Define = { fg = tp.accent.growth.base },

    -- Macro
    Macro = { fg = tp.accent.twilight.base },

    -- PreCondit
    PreCondit = { fg = tp.accent.growth.base },

    -- Any tupe (parent group)
    Type = { fg = tp.accent.anchor.base, italic = cfg.italic },

    -- Storage attributes
    StorageClass = { fg = tp.accent.twilight.base, underdashed = cfg.undertext },

    -- Structure
    Structure = { fg = tp.accent.anchor.base, italic = cfg.italic },

    -- Typedef (itself)
    TypeDef = { fg = tp.accent.bloom.base },

    -- Any special symbol (parent group, fallback used)
    Special = { fg = tp.accent.twilight.base },

    -- Special character in constants
    SpecialChar = { fg = tp.accent.anchor.alt, underline = cfg.undertext },

    -- Tag element
    Tag = { fg = tp.accent.anchor.base, italic = cfg.italic },

    -- Delimiter characters
    Delimiter = { fg = tp.fg.primary },

    -- Special comments
    SpecialComment = {
      fg = tp.accent.twilight.alt,
      bg = tp.accent.twilight.tint,
    },

    -- Underlined elements
    Underlined = { underline = true },

    -- Ignore elements
    Ignore = { fg = tp.fg.muted },

    -- Error syntax
    Error = { fg = tp.accent.bloom.base },

    -- Todo
    Todo = { link = 'SpecialComment' },
  }

  return hls
end

return M
