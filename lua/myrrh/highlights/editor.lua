local M = {}

--- @param tp Myrrh.Theme
--- @param cfg Myrrh.Config
function M.setup(tp, cfg)
  --- @type table<string, vim.api.keyset.highlight>
  local hls = {
    -- Core UI ---------------------------------------------------------------

    -- Default background and foreground for the main editor window
    Normal = {
      fg = tp.fg.primary,
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },

    -- Default background and foreground for a non-current editor window
    NormalNC = {
      fg = tp.fg.primary,
      -- use the same background color as normal
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },

    -- Background and foreground for normal text in floating windows
    NormalFloat = { fg = tp.fg.primary, bg = tp.bg.surface },

    -- Border around floating windows
    FloatBorder = { fg = tp.fg.muted, bg = tp.bg.surface },

    -- Title text in floating windows
    FloatTitle = { fg = tp.fg.secondary, bg = tp.bg.surface, bold = true },

    -- Footer text in floating windows
    FloatFooter = { fg = tp.fg.muted, bg = tp.bg.surface },

    -- Column color to the right of set width
    ColorColumn = { bg = tp.bg.base },

    -- Entire line where the cursor is currently positioned
    CursorLine = { bg = tp.bg.surface },
    CursorColumn = { link = 'CursorLine' },

    -- Terminal
    Terminal = {
      fg = tp.fg.primary,
      bg = not cfg.transparent and tp.bg.surface or 'NONE',
    },

    -- Toolbar line at the bottom of the screen
    ToolbarLine = {
      fg = tp.fg.primary,
      bg = not cfg.transparent and tp.bg.surface or 'NONE',
    },

    -- Character displayed at the end of buffer
    EndOfBuffer = { fg = tp.bg.surface },

    -- Characters that are not part of the file's text
    NonText = { fg = tp.bg.surface },

    -- Cursor / Search / Match ----------------------------------------------

    -- The cursor in the normal editor window
    Cursor = { fg = 'NONE', bg = 'NONE', reverse = true },
    lCursor = { link = 'Cursor' },
    CursorIM = { link = 'Cursor' },

    -- Current search result item
    CurSearch = {
      fg = tp.accent.twilight.base,
      bg = tp.accent.twilight.tint,
      bold = true,
      underline = cfg.undertext,
    },

    -- Incremental search highlight
    IncSearch = {
      fg = tp.accent.anchor.base,
      bg = tp.accent.anchor.tint,
      bold = true,
      underdotted = cfg.undertext,
    },

    -- Non-current matches when searching
    Search = {
      fg = tp.accent.growth.base,
      bg = tp.accent.growth.tint,
      underdotted = cfg.undertext,
    },

    -- Matching parenthesis to the one under the cursor
    MatchParen = { fg = tp.accent.anchor.base, bold = true },

    -- Diff / VCS ------------------------------------------------------------

    -- Added lines in diff mode
    DiffAdd = { fg = tp.accent.growth.base, bg = tp.accent.growth.tint },

    -- Changed lines in diff mode
    DiffChange = { fg = tp.accent.twilight.base, bg = tp.accent.twilight.tint },

    -- Deleted lines in diff mode
    DiffDelete = {
      fg = tp.accent.bloom.base,
      bg = tp.accent.bloom.tint,
      sp = tp.fg.muted,
      strikethrough = true,
    },

    -- Changed text within a changed line in diff mode
    DiffText = {
      fg = tp.accent.twilight.alt,
      bg = tp.accent.twilight.tint,
      bold = true,
      underdotted = cfg.undertext,
    },

    -- Line Numbers / Signs / Fold / Status ----------------------------------

    -- Buffer side columns
    SignColumn = {
      fg = tp.fg.secondary,
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },
    LineNr = { fg = tp.fg.muted, bg = 'NONE' },
    CursorLineNr = { fg = tp.fg.primary, bg = 'NONE', bold = true },

    -- Folded columns
    FoldColumn = {
      fg = tp.fg.muted,
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },
    Folded = {
      fg = tp.fg.secondary,
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },

    -- Line indents (may need to work with some plugins)
    IndentLine = { fg = tp.bg.surface },
    IndentLineCurrent = { fg = tp.bg.active },

    -- Status line at the bottom of the screen
    StatusLine = {
      fg = tp.fg.secondary,
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },
    StatusLineNC = {
      fg = tp.fg.muted,
      bg = not cfg.transparent and tp.bg.base or 'NONE',
    },

    -- Separator
    WinSeparator = { fg = tp.fg.muted, bg = 'NONE' },
    VertSplit = { link = 'WinSeparator' },

    -- Tabs / WinBar ---------------------------------------------------------

    -- Tabline visuals
    TabLine = { fg = tp.accent.growth.base, bg = tp.accent.growth.tint },
    TabLineSel = {
      fg = tp.accent.growth.alt,
      bg = tp.accent.growth.tint,
      bold = true,
    },
    TabLineFill = {
      bg = not cfg.transparent and tp.bg.surface or 'NONE',
    },

    -- Window bar visuals
    WinBar = { fg = tp.fg.secondary, bg = 'NONE' },
    WinBarNC = { fg = tp.fg.muted, bg = 'NONE' },

    -- Popups / Menus --------------------------------------------------------
    Pmenu = { fg = tp.fg.secondary, bg = tp.bg.surface },
    PmenuSel = { fg = tp.fg.primary, bg = tp.bg.active },
    PmenuKind = { fg = tp.fg.muted, bg = tp.bg.surface },
    PmenuKindSel = { fg = tp.fg.secondary, bg = tp.bg.active },
    PmenuExtra = { fg = tp.fg.secondary, bg = tp.bg.surface },
    PmenuExtraSel = { fg = tp.fg.secondary, bg = tp.bg.active },
    PmenuSbar = { bg = tp.bg.overlay },
    PmenuThumb = { bg = tp.bg.active },

    -- Messages / Prompts ----------------------------------------------------
    MsgArea = { fg = tp.fg.secondary, bg = tp.bg.base },
    MsgSeparator = { fg = tp.bg.overlay, bg = tp.bg.base },
    ModeMsg = { fg = tp.stateful.warning, bold = true },
    MoreMsg = { fg = tp.stateful.info },
    Question = { fg = tp.stateful.hint },
    WarningMsg = { fg = tp.stateful.warning },
    ErrorMsg = { fg = tp.stateful.error },

    -- Visual / Selections ---------------------------------------------------
    Visual = { bg = tp.bg.active },
    VisualNOS = { link = 'Visual' },
    QuickFixLine = { bg = tp.bg.surface },
    Whitespace = { fg = tp.fg.muted },
    WildMenu = { link = 'Pmenu' },

    -- Spell Checking --------------------------------------------------------
    SpellBad = {
      undercurl = true,
      sp = tp.stateful.error,
    },
    SpellCap = {
      undercurl = true,
      sp = tp.stateful.warning,
    },
    SpellLocal = {
      undercurl = true,
      sp = tp.stateful.info,
    },
    SpellRare = {
      undercurl = true,
      sp = tp.stateful.hint,
    },

    -- Misc / Debug ----------------------------------------------------------
    debugPC = { bg = tp.stateful.error },
    debugBreakpoint = { fg = tp.stateful.warning, bg = tp.bg.layer },

    -- UI accents ------------------------------------------------------------
    Directory = { fg = tp.stateful.info },
    Title = { fg = tp.fg.primary, bold = true },
    Conceal = { fg = tp.fg.secondary, bold = true },
  }

  return hls
end

return M
