vim.g.mapleader = ";"
-- vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.autowrite   = true
opt.confirm     = true
opt.mouse       = "a"
opt.wrap        = false
opt.autoread    = true
opt.wildmenu    = true
opt.hidden      = true
opt.ttimeout    = true
-- opt.timeoutlen  = 300
opt.ttimeoutlen = 100
opt.updatetime  = 100
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
opt.number         = true
opt.relativenumber = true
opt.ruler          = true
opt.showcmd        = true
opt.showmode       = true
opt.laststatus     = 2
opt.cmdheight      = 2
opt.modelines      = 0
opt.cursorline     = true
opt.cursorcolumn   = true
opt.colorcolumn    = "81"
opt.showmatch      = true
opt.matchtime      = 2
opt.display        = "lastline"
opt.wildmenu       = true
opt.lazyredraw     = true
opt.list           = true
opt.listchars      = "space:·,tab:>>"
opt.pumblend       = 10
opt.pumheight      = 10
opt.scrolloff      = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.sidescrolloff  = 8
opt.signcolumn     = "yes"

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

opt.formatoptions = "jBcroqlnt"
