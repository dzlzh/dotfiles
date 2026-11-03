-- Inkstone Xuanmo / 玄墨. Palette: ../inkstone-xuanmo.json
-- Install in ~/.config/nvim/colors/, then :colorscheme inkstone-xuanmo
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "inkstone-xuanmo"

local p = {
  bg = "#14131a", panel = "#1a1922", raised = "#22212c", high = "#2b2a36",
  fg = "#d4cec4", muted = "#ada599", faint = "#6f6979", border = "#343240",
  selection = "#332f46", comment = "#85809e", red = "#da5761",
  blue = "#619ac3", green = "#2bae85", orange = "#f28e16", yellow = "#d6a01d",
  purple = "#c08eaf", cyan = "#57c3c2", operator = "#9a94a4", punct = "#8f899e",
  error = "#e35c3d", error_bg = "#291a1d", warning_bg = "#2a1f1a",
  info_bg = "#1c212b", added_bg = "#162325", removed_bg = "#281a21",
  removed = "#db5c66", changed = "#51bd9b", rule = "#4a4557",
}

local function hi(name, spec)
  vim.api.nvim_set_hl(0, name, spec)
end

local groups = {
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.fg, bg = p.panel },
  FloatBorder = { fg = p.border, bg = p.panel },
  FloatTitle = { fg = p.blue, bg = p.panel, bold = true },
  ColorColumn = { bg = p.panel },
  CursorLine = { bg = p.panel },
  CursorColumn = { bg = p.panel },
  Cursor = { fg = p.bg, bg = p.fg },
  lCursor = { link = "Cursor" },
  TermCursor = { link = "Cursor" },
  LineNr = { fg = p.faint },
  CursorLineNr = { fg = p.yellow, bold = true },
  SignColumn = { fg = p.muted, bg = p.bg },
  FoldColumn = { fg = p.faint, bg = p.bg },
  Folded = { fg = p.comment, bg = p.panel },
  EndOfBuffer = { fg = p.border },
  NonText = { fg = p.border },
  Whitespace = { fg = p.border },
  SpecialKey = { fg = p.faint },
  WinSeparator = { fg = p.border },
  VertSplit = { link = "WinSeparator" },
  Visual = { bg = p.selection },
  VisualNOS = { link = "Visual" },
  Search = { fg = p.yellow, bg = p.high },
  IncSearch = { fg = p.bg, bg = p.orange },
  CurSearch = { link = "IncSearch" },
  Substitute = { fg = p.bg, bg = p.red },
  MatchParen = { fg = p.blue, bg = p.selection, bold = true },
  Pmenu = { fg = p.fg, bg = p.panel },
  PmenuSel = { fg = p.bg, bg = p.blue },
  PmenuSbar = { bg = p.raised },
  PmenuThumb = { bg = p.rule },
  StatusLine = { fg = p.fg, bg = p.raised },
  StatusLineNC = { fg = p.faint, bg = p.panel },
  WinBar = { fg = p.fg, bg = p.bg },
  WinBarNC = { fg = p.muted, bg = p.bg },
  TabLine = { fg = p.muted, bg = p.panel },
  TabLineSel = { fg = p.bg, bg = p.blue, bold = true },
  TabLineFill = { bg = p.panel },
  Title = { fg = p.red, bold = true },
  Directory = { fg = p.blue },
  Question = { fg = p.green },
  MoreMsg = { fg = p.green },
  ModeMsg = { fg = p.blue, bold = true },
  ErrorMsg = { fg = p.error },
  WarningMsg = { fg = p.orange },
  Conceal = { fg = p.faint },
  QuickFixLine = { bg = p.selection },
  SpellBad = { sp = p.error, undercurl = true },
  SpellCap = { sp = p.orange, undercurl = true },
  SpellLocal = { sp = p.cyan, undercurl = true },
  SpellRare = { sp = p.purple, undercurl = true },

  Comment = { fg = p.comment, italic = true },
  Constant = { fg = p.orange },
  String = { fg = p.green },
  Character = { link = "String" },
  Number = { fg = p.orange },
  Boolean = { fg = p.orange },
  Float = { link = "Number" },
  Identifier = { fg = p.fg },
  Function = { fg = p.blue },
  Statement = { fg = p.red },
  Conditional = { link = "Statement" },
  Repeat = { link = "Statement" },
  Label = { link = "Statement" },
  Operator = { fg = p.operator },
  Keyword = { fg = p.red },
  Exception = { link = "Statement" },
  PreProc = { fg = p.red },
  Include = { link = "PreProc" },
  Define = { link = "PreProc" },
  Macro = { link = "PreProc" },
  PreCondit = { link = "PreProc" },
  Type = { fg = p.yellow },
  StorageClass = { link = "Keyword" },
  Structure = { link = "Type" },
  Typedef = { link = "Type" },
  Special = { fg = p.cyan },
  SpecialChar = { fg = p.cyan },
  Tag = { fg = p.blue },
  Delimiter = { fg = p.punct },
  SpecialComment = { link = "Comment" },
  Debug = { fg = p.red },
  Underlined = { fg = p.blue, underline = true },
  Ignore = { fg = p.faint },
  Error = { fg = p.error, bg = p.error_bg },
  Todo = { fg = p.yellow, bg = p.raised, bold = true },

  DiffAdd = { bg = p.added_bg },
  DiffDelete = { fg = p.removed, bg = p.removed_bg },
  DiffChange = { bg = p.info_bg },
  DiffText = { fg = p.changed, bg = p.added_bg, bold = true },
  diffAdded = { fg = p.green },
  diffRemoved = { fg = p.removed },
  diffChanged = { fg = p.blue },
  diffLine = { fg = p.blue },
  GitSignsAdd = { fg = p.green },
  GitSignsChange = { fg = p.blue },
  GitSignsDelete = { fg = p.removed },

  markdownHeadingDelimiter = { fg = p.red, bold = true },
  markdownBold = { fg = p.orange, bold = true },
  markdownItalic = { fg = p.yellow, italic = true },
  markdownCode = { fg = p.green },
  markdownCodeBlock = { fg = p.fg },
  markdownCodeDelimiter = { fg = p.green },
  markdownBlockquote = { fg = p.yellow },
  markdownListMarker = { fg = p.blue },
  markdownOrderedListMarker = { fg = p.orange },
  markdownRule = { fg = p.rule },
  markdownLinkText = { fg = p.blue },
  markdownUrl = { fg = p.blue, underline = true },
  ["@markup.heading"] = { fg = p.red, bold = true },
  ["@markup.strong"] = { link = "markdownBold" },
  ["@markup.italic"] = { link = "markdownItalic" },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.raw"] = { fg = p.green },
  ["@markup.raw.block"] = { fg = p.fg },
  ["@markup.quote"] = { fg = p.yellow },
  ["@markup.link"] = { fg = p.blue },
  ["@markup.link.label"] = { fg = p.blue },
  ["@markup.link.url"] = { link = "markdownUrl" },
  ["@markup.list"] = { fg = p.blue },
}

for name, spec in pairs(groups) do
  hi(name, spec)
end

-- Treesitter captures; more specific captures inherit their parent colour.
local links = {
  ["@comment"] = "Comment", ["@constant"] = "Constant",
  ["@string"] = "String", ["@string.escape"] = "SpecialChar",
  ["@character"] = "Character", ["@number"] = "Number", ["@boolean"] = "Boolean",
  ["@variable"] = "Identifier", ["@variable.builtin"] = "Special",
  ["@function"] = "Function", ["@function.macro"] = "Macro",
  ["@constructor"] = "Type", ["@keyword"] = "Keyword", ["@operator"] = "Operator",
  ["@type"] = "Type", ["@module"] = "Type", ["@property"] = "Identifier",
  ["@attribute"] = "PreProc", ["@label"] = "Label",
  ["@punctuation"] = "Delimiter", ["@tag"] = "Tag",
  ["@tag.attribute"] = "Identifier", ["@tag.delimiter"] = "Delimiter",
  ["@diff.plus"] = "diffAdded", ["@diff.minus"] = "diffRemoved",
  ["@diff.delta"] = "diffChanged",
  ["@lsp.type.variable"] = "Identifier", ["@lsp.type.parameter"] = "Identifier",
  ["@lsp.type.property"] = "Identifier", ["@lsp.type.function"] = "Function",
  ["@lsp.type.method"] = "Function", ["@lsp.type.type"] = "Type",
  ["@lsp.type.class"] = "Type", ["@lsp.type.interface"] = "Type",
  ["@lsp.type.struct"] = "Type", ["@lsp.type.enum"] = "Type",
  ["@lsp.type.enumMember"] = "Constant", ["@lsp.type.namespace"] = "Type",
  ["@lsp.type.typeParameter"] = "Type", ["@lsp.type.macro"] = "Macro",
  ["@lsp.type.keyword"] = "Keyword", ["@lsp.type.comment"] = "Comment",
}
for name, target in pairs(links) do
  hi(name, { link = target })
end
for level = 1, 6 do
  hi("markdownH" .. level, { link = "Title" })
end

local diagnostics = {
  Error = { p.error, p.error_bg }, Warn = { p.orange, p.warning_bg },
  Info = { p.blue, p.info_bg }, Hint = { p.cyan, p.panel },
  Ok = { p.green, p.added_bg },
}
for severity, colors in pairs(diagnostics) do
  hi("Diagnostic" .. severity, { fg = colors[1] })
  hi("DiagnosticSign" .. severity, { fg = colors[1] })
  hi("DiagnosticFloating" .. severity, { fg = colors[1] })
  hi("DiagnosticVirtualText" .. severity, { fg = colors[1], bg = colors[2] })
  hi("DiagnosticUnderline" .. severity, { sp = colors[1], undercurl = true })
end

-- ANSI palette for Neovim's embedded terminal (normal, then bright).
local terminal = {
  p.panel, p.red, p.green, p.yellow, p.blue, p.purple, p.cyan, p.fg,
  p.faint, "#e17981", "#55be9d", "#deb34a", "#81aecf", "#cda5bf", "#79cfce", "#cbc8d0",
}
for index, color in ipairs(terminal) do
  vim.g["terminal_color_" .. (index - 1)] = color
end
