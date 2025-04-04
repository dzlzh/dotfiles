local ok, err = pcall(function()
    require('core')
    require('plugins')
end)

if not ok then
    vim.notify('ERROR: ' .. err, vim.log.levels.ERROR)
end
