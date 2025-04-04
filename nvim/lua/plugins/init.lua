if vim.uv == nil then
    vim.uv = vim.loop
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { import = "plugins.theme" },
    { import = "plugins.ui" },
    { import = "plugins.treesitter" },
    { import = "plugins.common" },
    { import = "plugins.git" },
    -- { import = "plugins.tmux" },
    { import = "plugins.lsp" },
},{
    defaults = {
        lazy = true,
        version = false,
    },
    checker = {
        enabled = false,
    },
})
