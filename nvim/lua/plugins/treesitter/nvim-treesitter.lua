return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "go",
                "php",
                "lua",
                "vim",
                "bash",
                "python",
                "json",
                "yaml",
                "html",
                "javascript",
                "typescript",
                "terraform",
                "dockerfile",
                "markdown",
                "query",
                "regex",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection    = "<A-I>",
                    node_incremental  = "<A-J>",
                    node_decremental  = "<A-K>",
                },
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false
            },
        })
    end,
}
