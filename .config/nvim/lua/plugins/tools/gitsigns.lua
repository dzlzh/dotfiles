return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            if vim.b[bufnr].large_file then
                return false
            end

            local gitsigns = require("gitsigns")

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end

            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next hunk")
            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Previous hunk")
            map("n", "<Leader>hs", gitsigns.stage_hunk, "Stage hunk")
            map("n", "<Leader>hr", gitsigns.reset_hunk, "Reset hunk")
            map("x", "<Leader>hs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage selected lines")
            map("x", "<Leader>hr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset selected lines")
            map("n", "<Leader>hp", gitsigns.preview_hunk, "Preview hunk")
            map("n", "<Leader>hb", function()
                gitsigns.blame_line({ full = true })
            end, "Blame line")
        end,
    },
}
