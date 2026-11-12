local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
    return vim.api.nvim_create_augroup("l_" .. name, { clear = true })
end

-- Large files are handled by snacks.bigfile (lua/plugins/editor/snacks.lua),
-- which sets `vim.b.large_file`.

local preserve_trailing_whitespace = {
    diff = true,
    gitcommit = true,
    gitrebase = true,
    markdown = true,
    text = true,
}

local function is_normal_file_buffer(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_buf_get_name(buf) ~= ""
        and vim.bo[buf].buftype == ""
        and vim.bo[buf].modifiable
        and not vim.bo[buf].readonly
        and not vim.bo[buf].binary
end

autocmd("BufLeave", {
    group = augroup("autosave"),
    pattern = "*",
    callback = function(args)
        if not is_normal_file_buffer(args.buf) or not vim.bo[args.buf].modified then
            return
        end

        local path = vim.api.nvim_buf_get_name(args.buf)
        local ok, err = pcall(vim.api.nvim_buf_call, args.buf, function()
            vim.cmd.update()
        end)

        if not ok then
            vim.schedule(function()
                vim.notify(
                    ("Autosave failed for %s: %s"):format(path, err),
                    vim.log.levels.ERROR
                )
            end)
        end
    end,
})

autocmd("BufWritePre", {
    group = augroup("trim_whitespace"),
    pattern = "*",
    callback = function(args)
        if not is_normal_file_buffer(args.buf)
            or vim.b[args.buf].large_file
            or vim.bo[args.buf].filetype == "bigfile"
            or preserve_trailing_whitespace[vim.bo[args.buf].filetype]
        then
            return
        end

        vim.api.nvim_buf_call(args.buf, function()
            local view = vim.fn.winsaveview()
            vim.cmd([[keeppatterns %s/\s\+$//e]])
            vim.fn.winrestview(view)
        end)
    end,
})

autocmd("BufReadPost", {
    group = augroup("last_position"),
    pattern = "*",
    callback = function(args)
        local filetype = vim.bo[args.buf].filetype
        if filetype == "gitcommit" or filetype == "gitrebase" then
            return
        end

        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 1
            and mark[1] <= line_count
            and vim.api.nvim_get_current_buf() == args.buf
        then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

autocmd("FileType", {
    group = augroup("indent_settings"),
    pattern = { "yaml", "json", "proto", "tmpl", "html" },
    callback = function(args)
        vim.bo[args.buf].shiftwidth = 2
        vim.bo[args.buf].tabstop = 2
    end,
})

autocmd("FileType", {
    group = augroup("xs_settings"),
    pattern = "xs",
    callback = function()
        vim.wo[0][0].wrap = true
        vim.wo[0][0].number = false
        vim.wo[0][0].relativenumber = false
        vim.wo[0][0].cursorline = false
        vim.wo[0][0].cursorcolumn = false
        vim.wo[0][0].colorcolumn = ""
    end,
})
