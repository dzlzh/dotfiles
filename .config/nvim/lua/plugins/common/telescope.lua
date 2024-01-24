return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Grep" },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                n = {
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                },
            }
        },
    },
}
