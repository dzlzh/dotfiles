return {
    "hotoo/pangu.vim",
    ft = "markdown",
    init = function()
        vim.g.pangu_rule_trailing_whitespace = 0
    end,
    config = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("l_pangu", { clear = true }),
            pattern = "*.md",
            callback = function(args)
                if vim.b[args.buf].large_file or vim.bo[args.buf].filetype == "bigfile" then
                    return
                end
                vim.api.nvim_buf_call(args.buf, function()
                    vim.cmd.PanguAll()
                end)
            end,
        })
    end,
}
