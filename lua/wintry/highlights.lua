local M = {}

--- Build the full highlight table.
---@param c table palette
---@param opts table config options
---@return table<string, table>
function M.get(c, opts)
  local styles = opts.styles
  local bg = opts.transparent and "NONE" or c.bg
  local bg_alt = opts.transparent and "NONE" or c.bg_alt
  local bg_float = opts.transparent and "NONE" or c.bg

  local hl = {}

  local function set(groups)
    for name, spec in pairs(groups) do
      hl[name] = spec
    end
  end

  local function style(base, extra)
    return vim.tbl_extend("force", base, extra or {})
  end

  -- ── editor ──────────────────────────────────────────────────────────
  set({
    Normal = { fg = c.fg, bg = bg },
    NormalNC = { fg = c.fg, bg = opts.dim_inactive and c.bg_alt or bg },
    NormalFloat = { fg = c.fg, bg = bg_float },
    FloatBorder = { fg = c.border_light, bg = bg_float },
    FloatTitle = { fg = c.blue, bg = bg_float, bold = true },
    FloatFooter = { fg = c.fg_dim, bg = bg_float },

    Cursor = { fg = c.bg, bg = c.pink },
    lCursor = { fg = c.bg, bg = c.pink },
    CursorIM = { fg = c.bg, bg = c.pink },
    TermCursor = { fg = c.bg, bg = c.pink },
    TermCursorNC = { fg = c.bg, bg = c.fg_dim },
    CursorLine = { bg = opts.transparent and "NONE" or c.bg_line },
    CursorColumn = { bg = c.bg_line },
    ColorColumn = { bg = c.bg_line },
    CursorLineNr = { fg = c.gutter_active, bold = true },
    LineNr = { fg = c.gutter },
    LineNrAbove = { fg = c.gutter },
    LineNrBelow = { fg = c.gutter },
    SignColumn = { bg = bg },
    FoldColumn = { fg = c.gutter, bg = bg },
    Folded = { fg = c.fg_dim, bg = c.bg_line },

    Visual = { bg = c.bg_sel },
    VisualNOS = { bg = c.bg_sel_dim },
    Search = { fg = c.fg, bg = c.bg_search },
    IncSearch = { fg = c.fg, bg = c.bg_search_cur },
    CurSearch = { fg = c.fg, bg = c.bg_search_cur },
    Substitute = { fg = c.bg, bg = c.pink },
    MatchParen = { fg = c.pink, bg = c.gutter, bold = true },

    Conceal = { fg = c.fg_dark },
    NonText = { fg = c.gutter },
    Whitespace = { fg = c.gutter },
    SpecialKey = { fg = c.gutter },
    EndOfBuffer = { fg = bg == "NONE" and c.bg or bg },

    Directory = { fg = c.blue },
    Title = { fg = c.purple, bold = true },
    Question = { fg = c.blue },
    MoreMsg = { fg = c.blue },
    ModeMsg = { fg = c.fg, bold = true },
    MsgArea = { fg = c.fg_dim },
    MsgSeparator = { fg = c.border, bg = c.bg_alt },
    ErrorMsg = { fg = c.red_bright },
    WarningMsg = { fg = c.orange },

    StatusLine = { fg = c.fg_dim, bg = bg_alt },
    StatusLineNC = { fg = c.fg_darker, bg = bg_alt },
    WinBar = { fg = c.fg_dim, bg = bg },
    WinBarNC = { fg = c.fg_darker, bg = bg },
    WinSeparator = { fg = c.border, bg = bg },
    VertSplit = { fg = c.border, bg = bg },

    TabLine = { fg = c.fg_dim, bg = c.bg_alt },
    TabLineFill = { bg = c.bg_alt },
    TabLineSel = { fg = c.fg, bg = c.bg },

    Pmenu = { fg = c.fg_dim, bg = opts.transparent and "NONE" or c.bg },
    PmenuSel = { fg = c.fg, bg = c.bg_line },
    PmenuKind = { fg = c.blue, bg = opts.transparent and "NONE" or c.bg },
    PmenuKindSel = { fg = c.blue, bg = c.bg_line },
    PmenuExtra = { fg = c.fg_dark, bg = opts.transparent and "NONE" or c.bg },
    PmenuExtraSel = { fg = c.fg_dark, bg = c.bg_line },
    PmenuSbar = { bg = c.bg_alt },
    PmenuThumb = { bg = c.gutter_active },
    PmenuMatch = { fg = c.pink, bold = true },
    PmenuMatchSel = { fg = c.pink, bg = c.bg_line, bold = true },
    WildMenu = { fg = c.fg, bg = c.bg_sel },

    QuickFixLine = { bg = c.bg_line, bold = true },
    debugPC = { bg = c.bg_change },
    debugBreakpoint = { fg = c.red_bright, bg = bg },

    SpellBad = { sp = c.red_bright, undercurl = true },
    SpellCap = { sp = c.orange, undercurl = true },
    SpellLocal = { sp = c.blue, undercurl = true },
    SpellRare = { sp = c.purple, undercurl = true },

    DiffAdd = { bg = c.bg_add },
    DiffChange = { bg = c.bg_change },
    DiffDelete = { bg = c.bg_delete },
    DiffText = { bg = c.bg_text },
    diffAdded = { fg = c.green },
    diffChanged = { fg = c.blue_soft },
    diffRemoved = { fg = c.red },
    diffFile = { fg = c.blue },
    diffLine = { fg = c.comment },
    diffIndexLine = { fg = c.magenta },
    diffOldFile = { fg = c.red },
    diffNewFile = { fg = c.green },
  })

  -- ── legacy syntax ───────────────────────────────────────────────────
  set({
    Comment = style({ fg = c.comment }, styles.comments),
    Constant = { fg = c.pink_dark },
    String = style({ fg = c.purple }, styles.strings),
    Character = { fg = c.mint },
    Number = { fg = c.pink_dark },
    Float = { fg = c.pink_dark },
    Boolean = style({ fg = c.pink_dark }, styles.booleans),

    Identifier = style({ fg = c.fg }, styles.variables),
    Function = style({ fg = c.cyan_pale }, styles.functions),

    Statement = style({ fg = c.purple }, styles.keywords),
    Conditional = style({ fg = c.purple }, styles.keywords),
    Repeat = style({ fg = c.purple }, styles.keywords),
    Label = style({ fg = c.purple }, styles.keywords),
    Operator = { fg = c.orange },
    Keyword = style({ fg = c.purple }, styles.keywords),
    Exception = style({ fg = c.purple }, styles.keywords),

    PreProc = { fg = c.purple },
    Include = { fg = c.purple },
    Define = { fg = c.purple },
    Macro = { fg = c.salmon },
    PreCondit = { fg = c.purple },

    Type = { fg = c.blue_light },
    StorageClass = { fg = c.purple },
    Structure = { fg = c.blue_light },
    Typedef = { fg = c.blue_light },

    Special = { fg = c.orange },
    SpecialChar = { fg = c.mint },
    Tag = { fg = c.blue },
    Delimiter = { fg = c.punctuation },
    SpecialComment = { fg = c.fg_dim, italic = true },
    Debug = { fg = c.orange },

    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.fg_dark },
    Error = { fg = c.red_bright },
    Todo = { fg = c.bg, bg = c.pink, bold = true },
    Added = { fg = c.green },
    Changed = { fg = c.blue_soft },
    Removed = { fg = c.red },
  })

  -- ── treesitter ──────────────────────────────────────────────────────
  set({
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },
    ["@comment.error"] = { fg = c.red_bright },
    ["@comment.warning"] = { fg = c.orange },
    ["@comment.todo"] = { fg = c.bg, bg = c.pink, bold = true },
    ["@comment.note"] = { fg = c.bg, bg = c.blue, bold = true },

    ["@string"] = { link = "String" },
    ["@string.documentation"] = { fg = c.comment, italic = true },
    ["@string.regexp"] = { fg = c.mint },
    ["@string.escape"] = { fg = c.mint },
    ["@string.special"] = { fg = c.mint },
    ["@string.special.url"] = { fg = c.blue, underline = true },
    ["@string.special.path"] = { fg = c.blue },
    ["@string.special.symbol"] = { fg = c.purple },
    ["@character"] = { fg = c.mint },
    ["@character.special"] = { fg = c.mint },

    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Number" },
    ["@boolean"] = { link = "Boolean" },
    ["@constant"] = { fg = c.pink_dark },
    ["@constant.builtin"] = { fg = c.pink_dark },
    ["@constant.macro"] = { fg = c.orange, italic = true },

    ["@variable"] = style({ fg = c.fg }, styles.variables),
    ["@variable.builtin"] = { fg = c.blue },
    ["@variable.parameter"] = { fg = c.purple_light },
    ["@variable.parameter.builtin"] = { fg = c.purple_light },
    ["@variable.member"] = { fg = c.salmon },

    ["@module"] = { fg = c.purple },
    ["@module.builtin"] = { fg = c.purple },
    ["@namespace"] = { fg = c.purple },

    ["@function"] = style({ fg = c.cyan_pale }, styles.functions),
    ["@function.builtin"] = { fg = c.salmon },
    ["@function.call"] = { fg = c.cyan },
    ["@function.macro"] = { fg = c.salmon },
    ["@function.method"] = style({ fg = c.cyan_pale }, styles.functions),
    ["@function.method.call"] = { fg = c.cyan },
    ["@constructor"] = { fg = c.blue_light },

    ["@keyword"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.function"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.operator"] = { fg = c.orange },
    ["@keyword.return"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.import"] = { fg = c.purple },
    ["@keyword.export"] = { fg = c.purple },
    ["@keyword.conditional"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.repeat"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.exception"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.coroutine"] = style({ fg = c.purple }, styles.keywords),
    ["@keyword.debug"] = { fg = c.orange },
    ["@keyword.directive"] = { fg = c.purple },
    ["@keyword.directive.define"] = { fg = c.purple },
    ["@keyword.type"] = { fg = c.purple },
    ["@keyword.modifier"] = { fg = c.purple },

    ["@type"] = { fg = c.blue_light },
    ["@type.builtin"] = { fg = c.blue },
    ["@type.definition"] = { fg = c.blue_light },
    ["@type.qualifier"] = { fg = c.purple },
    ["@attribute"] = { fg = c.cream },
    ["@attribute.builtin"] = { fg = c.cream },
    ["@property"] = { fg = c.salmon },
    ["@field"] = { fg = c.salmon },
    ["@label"] = { fg = c.blue },

    ["@operator"] = { fg = c.orange },
    ["@punctuation.delimiter"] = { fg = c.punctuation },
    ["@punctuation.bracket"] = { fg = c.fg },
    ["@punctuation.special"] = { fg = c.orange },

    ["@tag"] = { fg = c.blue },
    ["@tag.builtin"] = { fg = c.blue },
    ["@tag.attribute"] = { fg = c.cyan_light },
    ["@tag.delimiter"] = { fg = c.blue_dim },

    ["@markup.heading"] = { fg = c.purple, bold = true },
    ["@markup.heading.1"] = { fg = c.purple, bold = true },
    ["@markup.heading.2"] = { fg = c.blue, bold = true },
    ["@markup.heading.3"] = { fg = c.cyan, bold = true },
    ["@markup.heading.4"] = { fg = c.cyan_light, bold = true },
    ["@markup.heading.5"] = { fg = c.mint, bold = true },
    ["@markup.heading.6"] = { fg = c.fg_dim, bold = true },
    ["@markup.strong"] = { fg = c.salmon, bold = true },
    ["@markup.italic"] = { fg = c.salmon, italic = true },
    ["@markup.strikethrough"] = { fg = c.cream, strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.quote"] = { fg = c.mint, italic = true },
    ["@markup.math"] = { fg = c.cyan_light },
    ["@markup.link"] = { fg = c.blue },
    ["@markup.link.label"] = { fg = c.blue },
    ["@markup.link.url"] = { fg = c.blue, underline = true },
    ["@markup.raw"] = { fg = c.orange },
    ["@markup.raw.block"] = { fg = c.fg_dim },
    ["@markup.list"] = { fg = c.cyan_light },
    ["@markup.list.checked"] = { fg = c.green },
    ["@markup.list.unchecked"] = { fg = c.fg_dim },

    ["@diff.plus"] = { fg = c.green },
    ["@diff.minus"] = { fg = c.red },
    ["@diff.delta"] = { fg = c.blue_soft },

    ["@none"] = {},
    ["@conceal"] = { fg = c.fg_dark },
    ["@text.reference"] = { fg = c.blue },

    -- language tweaks mirroring the VS Code scope fixes
    ["@variable.member.ruby"] = { fg = c.cyan_light },
    ["@type.css"] = { fg = c.blue_light },
    ["@property.css"] = { fg = c.blue },
    ["@tag.css"] = { fg = c.blue_light },
    ["@type.builtin.c"] = { fg = c.blue_light },
    ["@type.builtin.go"] = { fg = c.blue },
    ["@function.builtin.go"] = { fg = c.cyan },
    ["@type.builtin.java"] = { fg = c.blue },
  })

  -- ── lsp semantic tokens ─────────────────────────────────────────────
  set({
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = {},
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { fg = c.blue },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { fg = c.blue_light },
    ["@lsp.type.variable"] = { link = "@variable" },
    ["@lsp.typemod.function.declaration"] = { link = "@function" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
    ["@lsp.typemod.keyword.documentation"] = { link = "@keyword" },
    ["@lsp.mod.deprecated"] = { strikethrough = true },

    LspReferenceText = { bg = c.bg_word },
    LspReferenceRead = { bg = c.bg_word },
    LspReferenceWrite = { bg = c.bg_word, underline = true },
    LspReferenceTarget = {},
    LspInlayHint = { fg = c.hint, bg = c.bg_line },
    LspCodeLens = { fg = c.comment },
    LspCodeLensSeparator = { fg = c.gutter },
    LspSignatureActiveParameter = { fg = c.pink, bold = true },
    LspInfoBorder = { fg = c.border_light, bg = bg_float },
  })

  -- ── diagnostics ─────────────────────────────────────────────────────
  set({
    DiagnosticError = { fg = c.red_bright },
    DiagnosticWarn = { fg = c.orange },
    DiagnosticInfo = { fg = c.blue },
    DiagnosticHint = { fg = c.cyan_light },
    DiagnosticOk = { fg = c.green },

    DiagnosticVirtualTextError = { fg = c.red_bright, bg = c.bg_delete },
    DiagnosticVirtualTextWarn = { fg = c.orange, bg = c.bg_delete },
    DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.bg_change },
    DiagnosticVirtualTextHint = { fg = c.cyan_light, bg = c.bg_change },
    DiagnosticVirtualTextOk = { fg = c.green, bg = c.bg_add },

    DiagnosticUnderlineError = { sp = c.red_bright, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.orange, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.cyan_light, undercurl = true },
    DiagnosticUnderlineOk = { sp = c.green, undercurl = true },

    DiagnosticFloatingError = { fg = c.red_bright },
    DiagnosticFloatingWarn = { fg = c.orange },
    DiagnosticFloatingInfo = { fg = c.blue },
    DiagnosticFloatingHint = { fg = c.cyan_light },
    DiagnosticFloatingOk = { fg = c.green },

    DiagnosticSignError = { fg = c.red_bright },
    DiagnosticSignWarn = { fg = c.orange },
    DiagnosticSignInfo = { fg = c.blue },
    DiagnosticSignHint = { fg = c.cyan_light },
    DiagnosticSignOk = { fg = c.green },

    DiagnosticDeprecated = { sp = c.fg_dark, strikethrough = true },
    DiagnosticUnnecessary = { fg = c.comment },
  })

  -- ── plugins ─────────────────────────────────────────────────────────
  set({
    -- gitsigns
    GitSignsAdd = { fg = c.green },
    GitSignsChange = { fg = c.blue_soft },
    GitSignsDelete = { fg = c.red },
    GitSignsAddInline = { bg = c.bg_add },
    GitSignsChangeInline = { bg = c.bg_change },
    GitSignsDeleteInline = { bg = c.bg_delete },
    GitSignsCurrentLineBlame = { fg = c.fg_dark },

    -- telescope
    TelescopeNormal = { fg = c.fg_dim, bg = bg_float },
    TelescopeBorder = { fg = c.border_light, bg = bg_float },
    TelescopeTitle = { fg = c.bg, bg = c.pink, bold = true },
    TelescopePromptNormal = { fg = c.fg, bg = c.bg_alt },
    TelescopePromptBorder = { fg = c.border_light, bg = c.bg_alt },
    TelescopePromptTitle = { fg = c.bg, bg = c.pink, bold = true },
    TelescopePromptPrefix = { fg = c.pink },
    TelescopePromptCounter = { fg = c.fg_dark },
    TelescopeResultsTitle = { fg = c.bg, bg = c.blue, bold = true },
    TelescopePreviewTitle = { fg = c.bg, bg = c.cyan, bold = true },
    TelescopeSelection = { fg = c.fg, bg = c.bg_line },
    TelescopeSelectionCaret = { fg = c.pink, bg = c.bg_line },
    TelescopeMultiSelection = { fg = c.purple_light },
    TelescopeMatching = { fg = c.pink, bold = true },

    -- fzf-lua
    FzfLuaNormal = { fg = c.fg_dim, bg = bg_float },
    FzfLuaBorder = { fg = c.border_light, bg = bg_float },
    FzfLuaTitle = { fg = c.bg, bg = c.pink, bold = true },
    FzfLuaCursorLine = { fg = c.fg, bg = c.bg_line },
    FzfLuaFzfMatch = { fg = c.pink },
    FzfLuaHeaderText = { fg = c.blue },
    FzfLuaPathLineNr = { fg = c.comment },

    -- nvim-cmp / blink.cmp
    CmpItemAbbr = { fg = c.fg_dim },
    CmpItemAbbrDeprecated = { fg = c.fg_dark, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.pink, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.pink },
    CmpItemMenu = { fg = c.fg_dark },
    CmpItemKindText = { fg = c.fg_dim },
    CmpItemKindMethod = { fg = c.cyan_pale },
    CmpItemKindFunction = { fg = c.cyan_pale },
    CmpItemKindConstructor = { fg = c.blue_light },
    CmpItemKindField = { fg = c.salmon },
    CmpItemKindProperty = { fg = c.salmon },
    CmpItemKindVariable = { fg = c.fg },
    CmpItemKindClass = { fg = c.blue_light },
    CmpItemKindInterface = { fg = c.blue },
    CmpItemKindModule = { fg = c.purple },
    CmpItemKindUnit = { fg = c.mint },
    CmpItemKindValue = { fg = c.pink_dark },
    CmpItemKindEnum = { fg = c.blue_light },
    CmpItemKindEnumMember = { fg = c.pink_dark },
    CmpItemKindKeyword = { fg = c.purple },
    CmpItemKindSnippet = { fg = c.cream },
    CmpItemKindColor = { fg = c.pink },
    CmpItemKindFile = { fg = c.blue },
    CmpItemKindReference = { fg = c.blue },
    CmpItemKindFolder = { fg = c.blue },
    CmpItemKindConstant = { fg = c.pink_dark },
    CmpItemKindStruct = { fg = c.blue_light },
    CmpItemKindEvent = { fg = c.cream },
    CmpItemKindOperator = { fg = c.orange },
    CmpItemKindTypeParameter = { fg = c.blue_light },

    BlinkCmpMenu = { fg = c.fg_dim, bg = bg_float },
    BlinkCmpMenuBorder = { fg = c.border_light, bg = bg_float },
    BlinkCmpMenuSelection = { fg = c.fg, bg = c.bg_line },
    BlinkCmpLabelMatch = { fg = c.pink, bold = true },
    BlinkCmpLabelDeprecated = { fg = c.fg_dark, strikethrough = true },
    BlinkCmpKind = { fg = c.blue },
    BlinkCmpDoc = { fg = c.fg_dim, bg = bg_float },
    BlinkCmpDocBorder = { fg = c.border_light, bg = bg_float },
    BlinkCmpSignatureHelp = { fg = c.fg_dim, bg = bg_float },
    BlinkCmpSignatureHelpActiveParameter = { fg = c.pink, bold = true },

    -- nvim-tree
    NvimTreeNormal = { fg = c.fg_dim, bg = bg_alt },
    NvimTreeNormalNC = { fg = c.fg_dim, bg = bg_alt },
    NvimTreeWinSeparator = { fg = c.border, bg = bg_alt },
    NvimTreeRootFolder = { fg = c.blue, bold = true },
    NvimTreeFolderName = { fg = c.fg_dim },
    NvimTreeFolderIcon = { fg = c.blue },
    NvimTreeOpenedFolderName = { fg = c.fg, bold = true },
    NvimTreeEmptyFolderName = { fg = c.fg_dark },
    NvimTreeOpenedFile = { fg = c.fg },
    NvimTreeSpecialFile = { fg = c.pink },
    NvimTreeExecFile = { fg = c.green },
    NvimTreeSymlink = { fg = c.cyan },
    NvimTreeIndentMarker = { fg = c.gutter },
    NvimTreeCursorLine = { bg = c.bg_line },
    NvimTreeGitNew = { fg = c.green },
    NvimTreeGitDirty = { fg = c.blue },
    NvimTreeGitDeleted = { fg = c.red },
    NvimTreeGitStaged = { fg = c.green },
    NvimTreeGitMerge = { fg = c.pink },
    NvimTreeGitRenamed = { fg = c.purple_light },
    NvimTreeGitIgnored = { fg = c.fg_dark },

    -- neo-tree
    NeoTreeNormal = { fg = c.fg_dim, bg = bg_alt },
    NeoTreeNormalNC = { fg = c.fg_dim, bg = bg_alt },
    NeoTreeWinSeparator = { fg = c.border, bg = bg_alt },
    NeoTreeRootName = { fg = c.blue, bold = true },
    NeoTreeDirectoryIcon = { fg = c.blue },
    NeoTreeDirectoryName = { fg = c.fg_dim },
    NeoTreeFileNameOpened = { fg = c.fg },
    NeoTreeIndentMarker = { fg = c.gutter },
    NeoTreeCursorLine = { bg = c.bg_line },
    NeoTreeGitAdded = { fg = c.green },
    NeoTreeGitModified = { fg = c.blue },
    NeoTreeGitDeleted = { fg = c.red },
    NeoTreeGitConflict = { fg = c.pink },
    NeoTreeGitUntracked = { fg = c.green },
    NeoTreeGitIgnored = { fg = c.fg_dark },
    NeoTreeTabActive = { fg = c.fg, bg = c.bg },
    NeoTreeTabInactive = { fg = c.fg_dark, bg = c.bg_alt },
    NeoTreeTabSeparatorActive = { fg = c.bg, bg = c.bg },
    NeoTreeTabSeparatorInactive = { fg = c.border, bg = c.bg_alt },

    -- oil
    OilDir = { fg = c.blue },
    OilDirIcon = { fg = c.blue },
    OilLink = { fg = c.cyan },
    OilFile = { fg = c.fg_dim },

    -- bufferline
    BufferLineFill = { bg = c.bg_alt },
    BufferLineBackground = { fg = c.fg_dim, bg = c.bg_alt },
    BufferLineBufferSelected = { fg = c.fg, bg = c.bg, bold = true },
    BufferLineBufferVisible = { fg = c.fg_dim, bg = c.bg_alt },
    BufferLineIndicatorSelected = { fg = c.pink, bg = c.bg },
    BufferLineSeparator = { fg = c.border, bg = c.bg_alt },
    BufferLineSeparatorSelected = { fg = c.border, bg = c.bg },
    BufferLineModified = { fg = c.blue_soft, bg = c.bg_alt },
    BufferLineModifiedSelected = { fg = c.blue_soft, bg = c.bg },

    -- indent guides
    IndentBlanklineChar = { fg = c.gutter },
    IndentBlanklineContextChar = { fg = c.gutter_active },
    IblIndent = { fg = c.gutter },
    IblScope = { fg = c.gutter_active },
    IblWhitespace = { fg = c.gutter },
    MiniIndentscopeSymbol = { fg = c.gutter_active },

    -- which-key
    WhichKey = { fg = c.pink },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.fg_dim },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyFloat = { bg = bg_float },
    WhichKeyBorder = { fg = c.border_light, bg = bg_float },
    WhichKeyTitle = { fg = c.blue, bold = true },

    -- notify / noice
    NotifyERRORBorder = { fg = c.red_bright },
    NotifyWARNBorder = { fg = c.orange },
    NotifyINFOBorder = { fg = c.blue },
    NotifyDEBUGBorder = { fg = c.fg_dark },
    NotifyTRACEBorder = { fg = c.purple },
    NotifyERRORIcon = { fg = c.red_bright },
    NotifyWARNIcon = { fg = c.orange },
    NotifyINFOIcon = { fg = c.blue },
    NotifyDEBUGIcon = { fg = c.fg_dark },
    NotifyTRACEIcon = { fg = c.purple },
    NotifyERRORTitle = { fg = c.red_bright },
    NotifyWARNTitle = { fg = c.orange },
    NotifyINFOTitle = { fg = c.blue },
    NotifyDEBUGTitle = { fg = c.fg_dark },
    NotifyTRACETitle = { fg = c.purple },
    NoiceCmdlinePopupBorder = { fg = c.border_light },
    NoiceCmdlineIcon = { fg = c.pink },
    NoiceConfirmBorder = { fg = c.border_light },

    -- mini.nvim
    MiniStatuslineModeNormal = { fg = c.bg, bg = c.pink, bold = true },
    MiniStatuslineModeInsert = { fg = c.bg, bg = c.blue, bold = true },
    MiniStatuslineModeVisual = { fg = c.bg, bg = c.purple, bold = true },
    MiniStatuslineModeReplace = { fg = c.bg, bg = c.red, bold = true },
    MiniStatuslineModeCommand = { fg = c.bg, bg = c.cyan, bold = true },
    MiniStatuslineModeOther = { fg = c.bg, bg = c.mint, bold = true },
    MiniStatuslineDevinfo = { fg = c.fg_dim, bg = c.bg_line },
    MiniStatuslineFilename = { fg = c.fg_dim, bg = c.bg_alt },
    MiniStatuslineInactive = { fg = c.fg_darker, bg = c.bg_alt },
    MiniCursorword = { bg = c.bg_word },
    MiniCursorwordCurrent = { bg = c.bg_word },
    MiniPickPrompt = { fg = c.pink, bg = bg_float },
    MiniPickMatchCurrent = { bg = c.bg_line },
    MiniPickBorder = { fg = c.border_light, bg = bg_float },

    -- flash / hop / leap
    FlashLabel = { fg = c.bg, bg = c.pink, bold = true },
    FlashMatch = { fg = c.fg, bg = c.bg_search },
    FlashBackdrop = { fg = c.fg_dark },
    HopNextKey = { fg = c.pink, bold = true },
    HopNextKey1 = { fg = c.blue, bold = true },
    HopNextKey2 = { fg = c.blue_soft },
    HopUnmatched = { fg = c.fg_dark },
    LeapLabelPrimary = { fg = c.bg, bg = c.pink, bold = true },
    LeapLabelSecondary = { fg = c.bg, bg = c.blue, bold = true },
    LeapBackdrop = { fg = c.fg_dark },

    -- dashboard / alpha
    DashboardHeader = { fg = c.purple },
    DashboardFooter = { fg = c.comment },
    DashboardDesc = { fg = c.fg_dim },
    DashboardKey = { fg = c.pink },
    DashboardIcon = { fg = c.blue },
    AlphaHeader = { fg = c.purple },
    AlphaButtons = { fg = c.fg_dim },
    AlphaShortcut = { fg = c.pink },
    AlphaFooter = { fg = c.comment },

    -- dap
    DapUIVariable = { fg = c.fg },
    DapUIScope = { fg = c.blue },
    DapUIType = { fg = c.blue_light },
    DapUIValue = { fg = c.purple },
    DapUIModifiedValue = { fg = c.pink, bold = true },
    DapUIDecoration = { fg = c.border_light },
    DapUIThread = { fg = c.green },
    DapUIStoppedThread = { fg = c.blue },
    DapUISource = { fg = c.purple_light },
    DapUILineNumber = { fg = c.gutter_active },
    DapUIFloatBorder = { fg = c.border_light },
    DapUIWatchesEmpty = { fg = c.red },
    DapUIWatchesValue = { fg = c.green },
    DapUIWatchesError = { fg = c.red_bright },
    DapUIBreakpointsPath = { fg = c.blue },
    DapUIBreakpointsInfo = { fg = c.green },
    DapUIBreakpointsCurrentLine = { fg = c.green, bold = true },
    DapStoppedLine = { bg = c.bg_change },

    -- misc
    RainbowDelimiterRed = { fg = c.pink },
    RainbowDelimiterYellow = { fg = c.yellow },
    RainbowDelimiterBlue = { fg = c.blue },
    RainbowDelimiterOrange = { fg = c.orange },
    RainbowDelimiterGreen = { fg = c.green },
    RainbowDelimiterViolet = { fg = c.purple },
    RainbowDelimiterCyan = { fg = c.cyan },

    TreesitterContext = { bg = c.bg_line },
    TreesitterContextLineNumber = { fg = c.gutter_active, bg = c.bg_line },
    TroubleNormal = { fg = c.fg_dim, bg = bg_alt },
    TroubleText = { fg = c.fg_dim },
    TroubleCount = { fg = c.pink, bg = c.bg_badge },
    TodoBgTODO = { fg = c.bg, bg = c.blue, bold = true },
    TodoFgTODO = { fg = c.blue },
    TodoBgFIX = { fg = c.bg, bg = c.red_bright, bold = true },
    TodoFgFIX = { fg = c.red_bright },
    TodoBgHACK = { fg = c.bg, bg = c.yellow, bold = true },
    TodoFgHACK = { fg = c.yellow },
    TodoBgWARN = { fg = c.bg, bg = c.orange, bold = true },
    TodoFgWARN = { fg = c.orange },
    TodoBgNOTE = { fg = c.bg, bg = c.green, bold = true },
    TodoFgNOTE = { fg = c.green },
    TodoBgPERF = { fg = c.bg, bg = c.purple, bold = true },
    TodoFgPERF = { fg = c.purple },
    TodoSignTODO = { fg = c.blue },

    -- markdown / help files
    markdownH1 = { fg = c.purple, bold = true },
    markdownH2 = { fg = c.blue, bold = true },
    markdownH3 = { fg = c.cyan, bold = true },
    markdownCode = { fg = c.orange },
    markdownCodeBlock = { fg = c.fg_dim },
    markdownLinkText = { fg = c.blue, underline = true },
    markdownUrl = { fg = c.blue },
    markdownListMarker = { fg = c.cyan_light },
    markdownRule = { fg = c.comment, bold = true },
    markdownBlockquote = { fg = c.mint, italic = true },
    helpHyperTextEntry = { fg = c.pink },
    helpHyperTextJump = { fg = c.blue },
    helpHeadline = { fg = c.purple, bold = true },
    helpSectionDelim = { fg = c.comment },

    -- netrw
    netrwDir = { fg = c.blue },
    netrwClassify = { fg = c.blue },
    netrwLink = { fg = c.cyan },
    netrwExe = { fg = c.green },
    netrwTreeBar = { fg = c.gutter },
  })

  if type(opts.on_highlights) == "function" then
    opts.on_highlights(hl, c)
  elseif type(opts.on_highlights) == "table" then
    for name, spec in pairs(opts.on_highlights) do
      hl[name] = spec
    end
  end

  return hl
end

return M
