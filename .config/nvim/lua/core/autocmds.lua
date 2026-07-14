local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
    return vim.api.nvim_create_augroup("l_" .. name, { clear = true })
end

local LARGE_FILE_SIZE = 5 * 1024 * 1024
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

local function enable_large_file_buffer_policy(buf)
    if not vim.b[buf].large_file_policy_active then
        local completion = vim.b[buf].completion
        vim.b[buf].large_file_policy_active = true
        vim.b[buf].large_file_completion_was_set = completion ~= nil
        if completion ~= nil then
            vim.b[buf].large_file_saved_completion = completion
        end
        vim.b[buf].large_file_saved_swapfile = vim.bo[buf].swapfile
    end

    vim.b[buf].large_file = true
    vim.b[buf].completion = false
    vim.bo[buf].swapfile = false
end

local function enable_large_file_syntax_policy(buf)
    if not vim.b[buf].large_file_syntax_saved then
        vim.b[buf].large_file_syntax_saved = true
        vim.b[buf].large_file_saved_syntax = vim.bo[buf].syntax
    end

    vim.bo[buf].syntax = ""
end

local function restore_large_file_buffer_policy(buf)
    if vim.b[buf].large_file_policy_active then
        if vim.b[buf].completion == false then
            if vim.b[buf].large_file_completion_was_set then
                vim.b[buf].completion = vim.b[buf].large_file_saved_completion
            else
                vim.b[buf].completion = nil
            end
        end

        if vim.bo[buf].swapfile == false then
            vim.bo[buf].swapfile = vim.b[buf].large_file_saved_swapfile
        end

        if vim.b[buf].large_file_syntax_saved and vim.bo[buf].syntax == "" then
            vim.bo[buf].syntax = vim.b[buf].large_file_saved_syntax
        end
    end

    vim.b[buf].large_file = nil
    vim.b[buf].large_file_policy_active = nil
    vim.b[buf].large_file_completion_was_set = nil
    vim.b[buf].large_file_saved_completion = nil
    vim.b[buf].large_file_saved_swapfile = nil
    vim.b[buf].large_file_syntax_saved = nil
    vim.b[buf].large_file_saved_syntax = nil
end

local function disable_large_file_window_options(win)
    if not vim.w[win].large_file_policy_active then
        vim.w[win].large_file_policy_active = true
        vim.w[win].large_file_saved_cursorcolumn = vim.wo[win].cursorcolumn
        vim.w[win].large_file_saved_foldenable = vim.wo[win].foldenable
    end

    vim.wo[win].cursorcolumn = false
    vim.wo[win].foldenable = false
end

local function restore_large_file_window_options(win)
    if not vim.api.nvim_win_is_valid(win) or not vim.w[win].large_file_policy_active then
        return
    end

    if vim.wo[win].cursorcolumn == false then
        vim.wo[win].cursorcolumn = vim.w[win].large_file_saved_cursorcolumn
    end
    if vim.wo[win].foldenable == false then
        vim.wo[win].foldenable = vim.w[win].large_file_saved_foldenable
    end

    vim.w[win].large_file_policy_active = nil
    vim.w[win].large_file_saved_cursorcolumn = nil
    vim.w[win].large_file_saved_foldenable = nil
end

local pending_large_file_window_handoff
local large_file_window_handoff_group = augroup("large_file_window_handoff")

local function capture_large_file_window_handoff()
    pending_large_file_window_handoff = nil

    local source_win = vim.api.nvim_get_current_win()
    if not vim.api.nvim_win_is_valid(source_win)
        or not vim.w[source_win].large_file_policy_active
    then
        return
    end

    pending_large_file_window_handoff = {
        buf = vim.api.nvim_win_get_buf(source_win),
        cursorcolumn = vim.w[source_win].large_file_saved_cursorcolumn,
        foldenable = vim.w[source_win].large_file_saved_foldenable,
    }
end

local function consume_large_file_window_handoff()
    local handoff = pending_large_file_window_handoff
    pending_large_file_window_handoff = nil
    if not handoff then
        return
    end

    local win = vim.api.nvim_get_current_win()
    if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= handoff.buf then
        return
    end

    vim.w[win].large_file_policy_active = true
    vim.w[win].large_file_saved_cursorcolumn = handoff.cursorcolumn
    vim.w[win].large_file_saved_foldenable = handoff.foldenable
end

autocmd("WinNewPre", {
    group = large_file_window_handoff_group,
    pattern = "*",
    callback = capture_large_file_window_handoff,
})

autocmd("WinNew", {
    group = large_file_window_handoff_group,
    pattern = "*",
    callback = consume_large_file_window_handoff,
})

autocmd("TabLeave", {
    group = large_file_window_handoff_group,
    pattern = "*",
    callback = capture_large_file_window_handoff,
})

autocmd("TabNew", {
    group = large_file_window_handoff_group,
    pattern = "*",
    callback = consume_large_file_window_handoff,
})

autocmd("TabEnter", {
    group = large_file_window_handoff_group,
    pattern = "*",
    callback = function()
        pending_large_file_window_handoff = nil
    end,
})

autocmd("BufReadPre", {
    group = augroup("large_file"),
    pattern = "*",
    callback = function(args)
        local path = vim.fn.fnamemodify(args.file, ":p")
        local stat = path ~= "" and vim.uv.fs_stat(path) or nil
        if not stat or stat.type ~= "file" or stat.size <= LARGE_FILE_SIZE then
            restore_large_file_buffer_policy(args.buf)
            return
        end

        enable_large_file_buffer_policy(args.buf)
    end,
})

autocmd({ "BufReadPost", "BufWinEnter", "WinEnter" }, {
    group = augroup("large_file_window"),
    pattern = "*",
    callback = function(args)
        local wins
        if args.event == "BufReadPost" then
            wins = vim.fn.win_findbuf(args.buf)
        else
            wins = { vim.api.nvim_get_current_win() }
        end

        if vim.b[args.buf].large_file then
            enable_large_file_syntax_policy(args.buf)
        end

        for _, win in ipairs(wins) do
            if vim.api.nvim_win_is_valid(win)
                and vim.api.nvim_win_get_buf(win) == args.buf
            then
                if vim.b[args.buf].large_file then
                    disable_large_file_window_options(win)
                else
                    restore_large_file_window_options(win)
                end
            end
        end
    end,
})

autocmd("BufWinLeave", {
    group = augroup("large_file_window_restore"),
    pattern = "*",
    callback = function(args)
        local win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == args.buf then
            restore_large_file_window_options(win)
        end
    end,
})

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
    group = augroup("go_settings"),
    pattern = "go",
    callback = function(args)
        vim.bo[args.buf].expandtab = false
    end,
})

autocmd("FileType", {
    group = augroup("php_settings"),
    pattern = "php",
    callback = function(args)
        vim.api.nvim_buf_call(args.buf, function()
            vim.opt_local.iskeyword:append("$")
        end)
    end,
})

autocmd("FileType", {
    group = augroup("xs_settings"),
    pattern = "xs",
    callback = function()
        vim.wo.wrap = true
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.cursorline = false
        vim.wo.cursorcolumn = false
        vim.wo.colorcolumn = ""
    end,
})
