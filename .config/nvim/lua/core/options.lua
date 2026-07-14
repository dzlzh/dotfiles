vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.confirm   = true
opt.mouse     = "a"
opt.wrap      = false
opt.autoread  = true

opt.ttimeout    = true
opt.ttimeoutlen = 50
opt.updatetime  = 100
opt.timeoutlen  = 300

opt.spelllang   = { "en" }
opt.completeopt = "menu,menuone,noselect"
opt.wildmode    = "longest:full,full"

opt.autoindent  = true
opt.smartindent = true
opt.expandtab   = true
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.smarttab    = true
opt.backspace   = "indent,eol,start"
opt.shiftround  = true

opt.fileencoding = "utf-8"
opt.fileformat   = "unix"

opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.termguicolors  = true
opt.winborder      = "rounded"
opt.number         = true
opt.relativenumber = true
opt.ruler          = true
opt.showcmd        = true
opt.showmode       = false
opt.laststatus     = 2
opt.cmdheight      = 1
opt.modelines      = 0
opt.cursorline     = true
opt.cursorcolumn   = true
opt.colorcolumn    = "81"
opt.showmatch      = true
opt.matchtime      = 2

opt.display        = "lastline"
opt.list           = true
opt.pumblend       = 10
opt.pumheight      = 10
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.signcolumn     = "yes"

-- opt.listchars      = "space:·,tab:>-,eol:↵"
-- opt.ambiwidth      = "double"
opt.listchars      = {
    tab = '¦ ',
    eol = '¬',
    trail = '␣',
    nbsp = '+',
    extends = '>',
    precedes = '<',
}

opt.hlsearch   = true
opt.incsearch  = true
opt.ignorecase = true
opt.smartcase  = true
opt.inccommand = "nosplit"

opt.foldenable     = true
opt.foldmethod     = "indent"
opt.foldlevelstart = 99

opt.backup     = false
opt.swapfile   = false
opt.undofile   = true
opt.undolevels = 10000

opt.formatoptions = "jcroqlnt"

opt.sessionoptions = {
    "buffers",
    "curdir",
    "tabpages",
    "winsize",
    "help",
    "globals",
    "skiprtp",
    "folds"
}
