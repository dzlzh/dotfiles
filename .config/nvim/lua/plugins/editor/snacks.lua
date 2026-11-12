local LARGE_FILE_SIZE = 5 * 1024 * 1024

local function open_directory(args)
    if args.file == "" or vim.fn.isdirectory(args.file) ~= 1 then
        return
    end

    local cwd = vim.fs.normalize(vim.fn.fnamemodify(args.file, ":p"))
    local picker = Snacks.picker.get({ source = "explorer" })[1]
    -- Snacks.explorer() toggles an existing picker off; directory entries
    -- should instead reuse it and display the requested directory.
    if picker then
        picker.input:set("", "")
        picker.list:set_selected()
        picker:set_cwd(cwd)
        picker:find()
        picker:focus()
    else
        picker = Snacks.explorer({ cwd = cwd })
    end

    if vim.v.vim_did_enter == 0 then
        vim.api.nvim_buf_set_name(args.buf, "")
        picker:show()
        local ref = picker:ref()
        vim.api.nvim_create_autocmd("UIEnter", {
            group = args.group,
            once = true,
            callback = function()
                local current = ref()
                if current and not current.closed then
                    current:focus()
                end
            end,
        })
    else
        Snacks.bufdelete.delete(args.buf)
    end
end

local function toggle_shell_terminal()
    -- Pin count so a stray count prefix does not open a second terminal.
    Snacks.terminal.toggle(nil, {
        count = 1,
        win = { position = "float", border = "rounded" },
    })
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("l_explorer_directory", { clear = true }),
            callback = open_directory,
        })
    end,
    keys = {
        {
            "<Leader>ee",
            function()
                Snacks.explorer({ cwd = vim.fn.getcwd() })
            end,
            desc = "Toggle File Explorer",
        },
        {
            "<Leader>eg",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        {
            "<Leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<Leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Find Grep",
        },
        {
            "<Leader>fh",
            function()
                Snacks.picker.recent()
            end,
            desc = "Find History",
        },
        {
            "<Leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Find Buffers",
        },
        { "<Leader>sh", toggle_shell_terminal, desc = "Toggle Terminal" },
        -- Terminal mode must not map the printable leader (";"): every ";"
        -- typed in the shell would wait for timeoutlen.
        { "<M-t>", toggle_shell_terminal, mode = { "n", "t" }, desc = "Toggle Terminal" },
    },
    -- Only the modules listed here are enabled; everything else stays off.
    opts = {
        explorer = { replace_netrw = false },
        picker = {
            sources = {
                explorer = {
                    layout = { preset = "sidebar", preview = false, layout = { position = "left", width = 40 } },
                    auto_close = false,
                    jump = { close = false },
                    follow_file = true,
                    hidden = false,
                    ignored = false,
                },
            },
        },
        terminal = {},
        indent = {
            indent = { char = "¦" },
            scope = { char = "¦" },
            animate = { enabled = false },
            filter = function(buf)
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and not vim.b[buf].large_file
            end,
        },
        bigfile = {
            size = LARGE_FILE_SIZE,
            -- The buffer gets filetype "bigfile", so LSP, Tree-sitter and
            -- syntax never start. `large_file` is the flag the rest of the
            -- config (conform, gitsigns, LspAttach, indent) checks.
            setup = function(ctx)
                vim.b[ctx.buf].large_file = true
                vim.b[ctx.buf].completion = false
                vim.bo[ctx.buf].swapfile = false
                Snacks.util.wo(0, { foldmethod = "manual", cursorcolumn = false, conceallevel = 0 })
            end,
        },
    },
}
