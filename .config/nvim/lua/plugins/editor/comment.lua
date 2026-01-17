return {
    'numToStr/Comment.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local ft = require('Comment.ft')
        ft.set('php', { '//%s', '/*%s*/' })

        require('Comment').setup({
            mappings = {
                basic = false,
                extra = false,
            },
        })

        local api = require("Comment.api")
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.keymap.set("n", "<leader>cc", api.toggle.linewise.current, { desc = "Toggle Comment" })
        vim.keymap.set("n", "<leader>cu", api.uncomment.linewise.current, { desc = "Uncomment Line" })
        vim.keymap.set("x", "<leader>cc", function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.linewise(vim.fn.visualmode())
        end, { desc = "Toggle Comment Selection" })
        vim.keymap.set("x", "<leader>cu", function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.uncomment.linewise(vim.fn.visualmode())
        end, { desc = "Uncomment Selection" })
        vim.keymap.set("n", "<leader>cb", api.toggle.blockwise.current, { desc = "Toggle Block Comment" })
        vim.keymap.set("x", "<leader>cb", function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.blockwise(vim.fn.visualmode())
        end, { desc = "Toggle Block Selection" })
    end,
}
