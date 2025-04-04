vim.g.mapleader = ";"
vim.g.maplocalleader = ","

local opts = { noremap = true, silent = true }
local map  = vim.keymap.set

-- 系统复制/粘贴
map("v", "<Leader>y", "\"+y",  opts)
map("n", "<Leader>y", "\"+yy", opts)
map("n", "<Leader>p", "\"+p",  opts)

-- 快速浏览和操作Buffer
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-l>", "<c-w>l", opts)

-- 设置切换Buffer快捷键
map("n", "<c-n>", ":bn<CR>", opts)
map("n", "<c-p>", ":bp<CR>", opts)

-- 插入模式下光标向上移动
map("i", "<c-h>", "<Left>",  opts)
map("i", "<c-j>", "<Down>",  opts)
map("i", "<c-k>", "<Up>",    opts)
map("i", "<c-l>", "<Right>", opts)

-- 常规模式下文件格式转成 Unix
map("n", "<Leader>U", function()
    vim.cmd("set fileformat=unix")
    vim.cmd("set fileencoding=utf-8")
end, opts)

-- 用空格来开关折叠
map("n", "<space>", function()
    if vim.fn.foldclosed(vim.fn.line(".")) < 0 then
        vim.cmd("normal zc")
    else
        vim.cmd("normal zo")
    end
end, opts)

-- 打开终端
-- map("n", "<Leader>sh", function()
--     vim.cmd("botright split term://zsh")
--     vim.cmd("resize 10")
-- end, opts)
-- map("t", "<Esc>", "<c-\\><c-n>", opts)
