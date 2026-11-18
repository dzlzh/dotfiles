return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "Gclog", "Gvdiffsplit" },
    init = function()
        vim.g.fugitive_git_executable = { "git", "-c", "core.bigFileThreshold=1m" }
    end,
}
