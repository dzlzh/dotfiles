local M = {}

local required_packages = {
    ["vue-language-server"] = true,
    vtsls = true,
}

local active_registry
local install_handler
local enabled = false

local function packages_installed(registry)
    for name in pairs(required_packages) do
        if not registry.is_installed(name) then
            return false
        end
    end
    return true
end

function M.setup(opts)
    opts = opts or {}

    if active_registry and install_handler then
        active_registry:off("package:install:success", install_handler)
    end

    active_registry = opts.registry or require("mason-registry")
    local enable = opts.enable or vim.lsp.enable
    local schedule_wrap = opts.schedule_wrap or vim.schedule_wrap

    local function enable_if_ready()
        if enabled or not packages_installed(active_registry) then
            return
        end

        enable("vue_ls")
        enabled = true
    end

    install_handler = schedule_wrap(function(package)
        if required_packages[package.name] then
            enable_if_ready()
        end
    end)

    active_registry:on("package:install:success", install_handler)
    enable_if_ready()
end

return M
