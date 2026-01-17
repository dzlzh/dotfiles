return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "sql", "vim", "bash",
                "go", "gomod", "gosum", "gowork",
                "php", "rust", "python",
                "json", "yaml", "toml", "ini",
                "html", "javascript", "typescript", "vue",
                "dockerfile", "markdown", "query", "regex",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
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
