local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup("l_" .. name, { clear = true })
end

-- 离开当前 Buf 区时自动保存
autocmd("BufLeave", {
    group = augroup("autosave"),
    pattern = {"*"},
    command = "silent! w",
})

-- 保存时自动删除行尾空格
autocmd("BufWrite", {
    group = augroup("trim_whitespace"),
    pattern = {"*"},
    callback = function()
        local cursor_pos = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//ge]])
        vim.fn.setpos(".", cursor_pos)
    end,
})

--打开文件时恢复上一次光标所在位置
autocmd("BufReadPost", {
    group = augroup("last_position"),
    pattern = {"*"},
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 1 and line("'\"") <= line("$") then
            vim.cmd("normal g`\"")
        end
    end,
})

--打开大文件时
autocmd("BufReadPre", {
    group = augroup("large_file"),
    pattern = "*",
    callback = function()
        local threshold = 5 * 1024 * 1024
        local file_size = vim.fn.getfsize(vim.fn.expand("%:p"))
        if file_size > threshold then
            vim.opt_local.syntax = "off"
            vim.opt_local.foldenable = false
            vim.opt_local.swapfile = false
        end
    end,
})

-- 启用每行超过80列的字符提示
-- autocmd("BufWinEnter", {
--     -- pattern = {"*"},
--     pattern = {"*.php", "*.go"},
--     callback = function()
--         vim.w.m = vim.fn.matchadd("Underlined", "\\%>" .. 80 .. "v.\\+", -1)
--     end,
-- })

autocmd("FileType", {
    group    = augroup("indent_settings"),
    pattern  = {"yaml","json","proto","tmpl","html"},
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop    = 2
    end,
})

autocmd("FileType", {
    group = augroup("go_settings"),
    pattern = {"go"},
    callback = function()
        vim.opt.expandtab = false
    end,
})

autocmd("FileType", {
    group = augroup("php_settings"),
    pattern = {"php"},
    callback = function()
        vim.cmd("setlocal iskeyword+=$")
    end,
})

autocmd("FileType", {
    group = augroup("xs_settings"),
    pattern = {"xs"},
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
