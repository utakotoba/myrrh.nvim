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
    Constant = { fg = tp.accent.immersion.base },

    -- String constant literal
    String = { fg = tp.accent.immersion.base },

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
    Identifier = { fg = tp.accent.vista.base },

    -- Any function name
    Function = { fg = tp.accent.growth.base, italic = cfg.italic },

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
    StorageClass = {
      fg = tp.accent.twilight.base,
      underdashed = cfg.undertext,
    },

    -- Structure
    Structure = { fg = tp.accent.anchor.base, italic = cfg.italic },

    -- Typedef (itself)
    TypeDef = { fg = tp.accent.bloom.base },

    -- Any special symbol (parent group, fallback used)
    Special = { fg = tp.accent.twilight.base },

    -- Special character in constants
    SpecialChar = {
      fg = tp.accent.anchor.alt,
      underline = cfg.undertext,
    },

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

    -- Tree-sitter -------------------------------------------------

    -- Comments
    ['@comment'] = { link = 'Comment' },
    ['@comment.documentation'] = {
      fg = tp.accent.balance.alt,
      italic = cfg.italic,
    },
    ['@comment.warning'] = {
      fg = tp.accent.anchor.base,
      bg = tp.accent.anchor.tint,
      bold = true,
      italic = cfg.italic,
    },
    ['@comment.error'] = {
      fg = tp.accent.bloom.base,
      bg = tp.accent.bloom.tint,
      bold = true,
      italic = cfg.italic,
    },
    ['@comment.note'] = {
      fg = tp.accent.growth.base,
      bg = tp.accent.growth.tint,
      italic = cfg.italic,
    },
    ['@comment.todo'] = {
      fg = tp.accent.vista.base,
      bg = tp.accent.vista.tint,
      bold = true,
      italic = cfg.italic,
    },

    -- Constants
    ['@constant'] = { link = 'Constant' },
    ['@constant.macro'] = {
      fg = tp.accent.growth.base,
      italic = cfg.italic,
    },
    ['@constant.builtin'] = {
      fg = tp.accent.twilight.base,
      italic = cfg.italic,
    },

    -- Strings & Characters
    ['@string'] = { link = 'String' },
    ['@string.documentation'] = { link = '@comment.documentation' },
    ['@string.regex'] = {
      fg = tp.accent.immersion.base,
      underdotted = cfg.undertext,
    },
    ['@string.escape'] = {
      fg = tp.accent.anchor.base,
      bg = tp.accent.anchor.tint,
      underline = cfg.undertext,
    },
    ['@string.special'] = { fg = tp.accent.twilight.base },
    ['@string.special.symbol'] = {
      fg = tp.accent.twilight.base,
      italic = cfg.italic,
    },
    ['@string.special.url'] = {
      fg = tp.accent.vista.base,
      italic = cfg.italic,
    },
    ['@string.special.path'] = {
      fg = tp.accent.immersion.base,
      underline = cfg.undertext,
    },
    ['@character'] = { fg = tp.accent.growth.base, bold = true },
    ['@character.special'] = { fg = tp.accent.twilight.base, bold = true },

    -- Numbers
    ['@number'] = { fg = tp.accent.twilight.base },
    ['@number.float'] = { link = '@number' },

    -- Booleans
    ['@boolean'] = { fg = tp.accent.bloom.base },

    -- Variables
    ['@variable'] = { fg = tp.fg.primary },
    ['@variable.builtin'] = {
      fg = tp.accent.twilight.base,
      italic = cfg.italic,
    },
    ['@variable.parameter'] = {
      fg = tp.fg.primary,
      underdotted = cfg.undertext,
    },
    ['@variable.parameter.builtin'] = { fg = tp.fg.secondary },
    ['@variable.member'] = {
      fg = tp.accent.vista.base,
      underline = false,
    },

    -- Functions
    ['@function'] = { fg = tp.accent.growth.base },
    ['@function.builin'] = {
      fg = tp.accent.growth.base,
      italic = cfg.italic,
    },
    ['@function.call'] = {
      fg = tp.accent.growth.base,
      italic = cfg.italic,
    },
    ['@function.macro'] = { fg = tp.accent.immersion.base },
    ['@function.method'] = { fg = tp.accent.growth.base },
    ['@function.method.call'] = {
      fg = tp.accent.growth.base,
      italic = cfg.italic,
    },
    ['@constructor'] = { fg = tp.accent.twilight.base },

    -- Keywords
    ['@keyword'] = { link = 'Keyword' },
    ['@keyword.coroutine'] = {
      fg = tp.accent.bloom.base,
      italic = cfg.italic,
    },
    ['@keyword.function'] = { link = 'Keyword' },
    ['@keyword.operator'] = {
      fg = tp.accent.bloom.base,
      italic = cfg.italic,
    },
    ['@keyword.import'] = {
      fg = tp.accent.bloom.base,
      italic = cfg.italic,
    },
    ['@keyword.exception'] = { fg = tp.accent.bloom.alt },

    -- Operators
    ['@operator'] = { fg = tp.accent.anchor.base },
    ['@opeartor.type'] = { fg = tp.accent.bloom.base },

    -- Punctuation
    ['@punctuation.delimiter'] = { fg = tp.fg.secondary },
    ['@punctuation.bracket'] = { fg = tp.fg.primary },
    ['@punctuation.special'] = { link = '@punctuation.bracket' },

    -- Type
    ['@type'] = {
      fg = tp.accent.anchor.base,
      italic = cfg.italic,
      underdotted = cfg.undertext,
    },
    ['@type.builtin'] = { fg = tp.accent.anchor.base },
    ['@type.definition'] = {
      fg = tp.accent.anchor.base,
      underdotted = cfg.undertext,
    },
    ['@type.qualifier'] = {
      fg = tp.accent.twilight.base,
      italic = cfg.italic,
    },

    -- Attributes
    ['@attribute'] = {
      fg = tp.accent.twilight.base,
      italic = cfg.italic,
      underdotted = cfg.undertext,
    },
    ['@attribute.builtin'] = {
      fg = tp.accent.twilight.base,
      italic = cfg.italic,
    },

    -- Properties
    ['@property'] = { fg = tp.accent.vista.base },

    -- Label
    ['@label'] = { fg = tp.accent.immersion.base },

    -- Modules
    ['@module'] = { fg = tp.fg.secondary },
    ['@module'] = { link = '@module' },

    -- Markups
    ['@markup.strong'] = { bold = true },
    ['@markup.emphasis'] = { italic = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.strikethrough'] = { strikethrough = true },
    ['@markup.heading'] = { fg = tp.accent.immersion.base },
    ['@markup.heading.1'] = {
      fg = tp.accent.immersion.base,
      bg = tp.accent.immersion.tint,
      bold = true,
    },
    ['@markup.heading.2'] = {
      fg = tp.accent.immersion.base,
      bg = tp.accent.immersion.tint,
      bold = true,
    },
    ['@markup.heading.3'] = {
      fg = tp.accent.immersion.base,
      bg = tp.accent.immersion.tint,
      bold = true,
    },
    ['@markup.heading.4'] = {
      fg = tp.accent.immersion.base,
      bg = tp.accent.immersion.tint,
    },
    ['@markup.heading.5'] = {
      fg = tp.accent.immersion.base,
    },
    ['@markup.heading.6'] = {
      fg = tp.accent.immersion.base,
    },
    ['@markup.quote'] = { fg = tp.fg.secondary },
    ['@markup.math'] = { fg = tp.accent.twilight.base },
    ['@markup.environment'] = { fg = tp.accent.twilight.base },
    ['@markup.link'] = { fg = tp.fg.primary },
    ['@markup.link.label'] = { fg = tp.accent.anchor.base },
    ['@markup.link.url'] = { fg = tp.accent.vista.base },
    ['@markup.raw'] = { fg = tp.accent.growth.base },
    ['@markup.raw.block'] = { fg = tp.accent.growth.base },
    ['@markup.list'] = { fg = tp.fg.primary },
    ['@markup.list.checked'] = { fg = tp.fg.primary },
    ['@markup.list.unchecked'] = {
      fg = tp.fg.muted,
      strikethrough = true,
    },

    -- Tags
    ['@tag'] = { fg = tp.accent.bloom.base },
    ['@tag.builtin'] = { fg = tp.accent.bloom.base },
    ['@tag.attribute'] = {
      fg = tp.accent.growth.base,
      italic = cfg.italic,
    },
    ['@tag.delimiter'] = { fg = tp.fg.secondary },

    -- Special
    ['@none'] = { fg = tp.fg.primary },
    ['@conceal'] = { fg = tp.fg.muted },

    -- Diff
    ['@diff.plus'] = { link = 'DiffAdd' },
    ['@diff.minus'] = { link = 'DiffDelete' },
    ['@diff.delta'] = { link = 'DiffChange' },
  }

  return hls
end

return M
