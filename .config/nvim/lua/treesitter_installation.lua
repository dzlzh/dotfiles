local M = {}

local function missing(required, installed)
    local available = {}
    for _, asset in ipairs(installed) do
        available[asset] = true
    end

    local absent = {}
    for _, parser in ipairs(required) do
        if not available[parser] then
            table.insert(absent, parser)
        end
    end
    return absent
end

function M.missing_assets(required, installed_parsers, installed_queries)
    return {
        parser_binaries = missing(required, installed_parsers),
        queries = missing(required, installed_queries),
    }
end

return M
