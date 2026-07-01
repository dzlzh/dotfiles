local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup("l_" .. name, { clear = true })
end

local function is_normal_file_buffer(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_buf_get_name(buf) ~= ""
        and vim.bo[buf].buftype == ""
        and vim.bo[buf].modifiable
        and not vim.bo[buf].readonly
        and not vim.bo[buf].binary
end

-- 离开当前 Buf 区时自动保存
autocmd("BufLeave", {
    group = augroup("autosave"),
    pattern = {"*"},
    callback = function(args)
        if not is_normal_file_buffer(args.buf) then
            return
        end

        vim.api.nvim_buf_call(args.buf, function()
            vim.cmd("silent! write")
        end)
    end,
})

-- 保存时自动删除行尾空格
autocmd("BufWritePre", {
    group = augroup("trim_whitespace"),
    pattern = {"*"},
    callback = function(args)
        if not is_normal_file_buffer(args.buf) then
            return
        end

        local view = vim.fn.winsaveview()
        vim.api.nvim_buf_call(args.buf, function()
            vim.cmd([[keeppatterns %s/\s\+$//e]])
        end)
        vim.fn.winrestview(view)
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
    callback = function(args)
        vim.bo[args.buf].shiftwidth = 2
        vim.bo[args.buf].tabstop    = 2
    end,
})

autocmd("FileType", {
    group = augroup("go_settings"),
    pattern = {"go"},
    callback = function(args)
        vim.bo[args.buf].expandtab = false
    end,
})

autocmd("FileType", {
    group = augroup("php_settings"),
    pattern = {"php"},
    callback = function(args)
        vim.bo[args.buf].iskeyword = vim.bo[args.buf].iskeyword .. ",$"
    end,
})

autocmd("FileType", {
    group = augroup("line_comment_settings"),
    pattern = {
        "php",
        "go",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "c",
        "cpp",
        "java",
        "rust",
    },
    callback = function(args)
        vim.bo[args.buf].commentstring = "// %s"
    end,
})

autocmd("FileType", {
    group = augroup("xs_settings"),
    pattern = {"xs"},
    callback = function()
        vim.o.laststatus      = 0
        vim.o.cmdheight       = 0
        vim.wo.wrap           = true
        vim.wo.number         = false
        vim.wo.relativenumber = false
        vim.wo.cursorline     = false
        vim.wo.cursorcolumn   = false
        vim.wo.colorcolumn    = ""
    end,
})
