local opts = {
    indent = {
        char = "¦",
        tab_char = "¦",
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
    },
}

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = opts,
    config = function(_, config)
        local ibl = require("ibl")
        local hooks = require("ibl.hooks")

        hooks.register(hooks.type.ACTIVE, function(bufnr)
            return not vim.b[bufnr].large_file
        end)
        ibl.setup(config)

        local group = vim.api.nvim_create_augroup("l_ibl_large_file", { clear = true })
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
            group = group,
            callback = function(args)
                ibl.debounced_refresh(args.buf)
            end,
        })

        ibl.debounced_refresh(vim.api.nvim_get_current_buf())
    end,
}
