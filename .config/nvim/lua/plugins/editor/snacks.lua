local LARGE_FILE_SIZE = 5 * 1024 * 1024

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
    keys = {
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
        picker = {},
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
