local autocmd = vim.api.nvim_create_autocmd

-- 离开当前 Buf 区时自动保存
autocmd("BufLeave", {
    pattern = "*",
    command = "silent! wall",
})

-- 保存时自动删除行尾空格
autocmd("BufWrite", {
    pattern = "*",
    callback = function()
        vim.cmd("normal mz")
        vim.cmd([[%s/\s\+$//ge]])
        vim.cmd("normal `z")
    end,
})

-- 启用每行超过80列的字符提示
autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
        vim.w.m = vim.fn.matchadd("Underlined", "\\%>" .. 80 .. "v.\\+", -1)
    end,
})

--打开文件时恢复上一次光标所在位置
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 1 and line("'\"") <= line("$") then
            vim.cmd("normal g`\"")
        end
    end,
})

local InitFileTypesGroup = vim.api.nvim_create_augroup("InitFileTypesGroup", {
    clear = true,
})

autocmd("FileType", {
    group    = InitFileTypesGroup,
    pattern  = "yaml,json,proto,tmpl,html",
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop    = 2
    end,
})

autocmd("FileType", {
    group   = InitFileTypesGroup,
    pattern = "go",
    callback = function()
        vim.opt.expandtab = false
    end,
})

autocmd("FileType", {
    group   = InitFileTypesGroup,
    pattern = "php",
    command = "setlocal iskeyword+=$",
})

autocmd("FileType", {
    group   = InitFileTypesGroup,
    pattern = "xs",
    callback = function()
        vim.o.wrap           = true
        vim.o.number         = false
        vim.o.relativenumber = false
        vim.o.ruler          = false
        vim.o.cursorline     = false
        vim.o.cursorcolumn   = false
        vim.o.colorcolumn    = ""
        vim.o.laststatus     = 0
        vim.o.cmdheight      = 0
    end,
})
