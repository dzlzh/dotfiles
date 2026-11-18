return {
    "neovim/nvim-lspconfig",
    cmd = { "LspInstall", "LspUninstall" },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("l_lsp_load", { clear = true }),
            callback = function(ev)
                local buf = ev.buf
                local name = vim.api.nvim_buf_get_name(buf)
                local filetype = vim.bo[buf].filetype
                if
                    vim.bo[buf].buftype ~= ""
                    or name == ""
                    or filetype == ""
                    or filetype == "bigfile"
                    or vim.b[buf].large_file
                    or vim.fn.isdirectory(name) == 1
                then
                    return
                end
                require("lazy").load({ plugins = { "nvim-lspconfig" } })
                return true
            end,
        })
    end,
    dependencies = {
        "saghen/blink.cmp",
        {
            "mason-org/mason.nvim",
            cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
            init = function()
                -- Terminals and formatters need Mason's executables before the first LSP buffer.
                vim.env.MASON = vim.fs.joinpath(vim.fn.stdpath("data"), "mason")
                local bin = vim.fs.joinpath(vim.env.MASON, "bin")
                local separator = vim.fn.has("win32") == 1 and ";" or ":"
                local paths = vim.split(vim.env.PATH or "", separator, { plain = true })
                paths = vim.tbl_filter(function(path)
                    return path ~= bin
                end, paths)
                table.insert(paths, 1, bin)
                vim.env.PATH = table.concat(paths, separator)
            end,
            opts = { PATH = "skip" },
        },
        "mason-org/mason-lspconfig.nvim",
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            dependencies = { "mason-org/mason.nvim" },
            cmd = {
                "MasonToolsInstall",
                "MasonToolsInstallSync",
                "MasonToolsUpdate",
                "MasonToolsUpdateSync",
                "MasonToolsClean",
            },
            opts = {
                ensure_installed = {
                    "stylua",
                    "goimports",
                    "gofumpt",
                },
                auto_update = false,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 24,
                integrations = {
                    ["mason-lspconfig"] = false,
                },
            },
            config = function(_, opts)
                local installer = require("mason-tool-installer")
                installer.setup(opts)
                if vim.v.vim_did_enter == 1 then
                    installer.run_on_start()
                end
            end,
        },
    },
    config = function()
        require("plugins.coding.lsp.diagnostics").setup()
        require("plugins.coding.lsp.keymaps").setup()

        local servers = require("plugins.coding.lsp.servers")
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        servers.setup({ capabilities = capabilities })

        require("mason-lspconfig").setup({
            ensure_installed = servers.names(),
            -- Vue waits for vtsls; keep alternative TS/Vue providers out of the same buffers.
            automatic_enable = { exclude = { "vue_ls", "ts_ls", "vuels" } },
        })
        require("plugins.coding.lsp.vue_install_gate").setup()
    end,
}
