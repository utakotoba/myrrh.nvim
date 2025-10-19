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
      fg = tp.fg.secondary,
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

    -- Character displayed at the end of buffer
    EndOfBuffer = { fg = tp.fg.muted },

    -- Characters that are not part of the file's text
    NonText = { fg = tp.fg.muted },

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
    DiffAdd = { bg = tp.stateful.success },
    DiffChange = { bg = tp.stateful.warning },
    DiffDelete = { fg = tp.stateful.error, bg = tp.bg.surface },
    DiffText = { bg = tp.stateful.info },

    diffAdded = { fg = tp.stateful.success },
    diffRemoved = { fg = tp.stateful.error },
    diffDeleted = { fg = tp.stateful.error },
    diffChanged = { fg = tp.stateful.warning },
    diffOldFile = { fg = tp.stateful.error },
    diffNewFile = { fg = tp.stateful.success },

    -- Diagnostics / LSP -----------------------------------------------------
    DiagnosticError = { fg = tp.stateful.error },
    DiagnosticWarn = { fg = tp.stateful.warning },
    DiagnosticInfo = { fg = tp.stateful.info },
    DiagnosticHint = { fg = tp.stateful.hint },
    DiagnosticOk = { fg = tp.stateful.success },

    DiagnosticUnderlineError = {
      undercurl = true,
      sp = tp.stateful.error,
    },
    DiagnosticUnderlineWarn = {
      undercurl = true,
      sp = tp.stateful.warning,
    },
    DiagnosticUnderlineInfo = {
      undercurl = true,
      sp = tp.stateful.info,
    },
    DiagnosticUnderlineHint = {
      undercurl = true,
      sp = tp.stateful.hint,
    },

    LspReferenceText = { bg = tp.bg.active },
    LspReferenceRead = { link = 'LspReferenceText' },
    LspReferenceWrite = { bg = tp.bg.active, underline = true },
    LspSignatureActiveParameter = { fg = tp.stateful.warning },
    LspCodeLens = { fg = tp.fg.muted },

    -- Line Numbers / Signs / Fold / Status ----------------------------------
    SignColumn = { fg = tp.fg.secondary, bg = tp.bg.layer },
    LineNr = { fg = tp.fg.muted, bg = tp.bg.layer },
    CursorLineNr = { fg = tp.stateful.warning, bg = tp.bg.layer, bold = true },
    FoldColumn = { fg = tp.fg.muted, bg = tp.bg.layer },
    Folded = { fg = tp.fg.secondary, bg = tp.bg.surface },

    StatusLine = { fg = tp.fg.secondary, bg = tp.bg.layer },
    StatusLineNC = { fg = tp.fg.muted, bg = tp.bg.layer },
    WinSeparator = { fg = tp.bg.overlay, bg = tp.bg.layer },
    VertSplit = { link = 'WinSeparator' },

    -- Tabs / WinBar ---------------------------------------------------------
    TabLine = { fg = tp.fg.secondary, bg = tp.bg.layer },
    TabLineSel = { fg = tp.fg.primary, bg = tp.bg.active, bold = true },
    TabLineFill = { bg = tp.bg.dim },

    WinBar = { fg = tp.fg.secondary, bg = 'NONE' },
    WinBarNC = { fg = tp.fg.muted, bg = tp.bg.dim },

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
