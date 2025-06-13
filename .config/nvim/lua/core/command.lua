local cmd = vim.api.nvim_create_user_command

cmd('Diff', function(opts)
    vim.cmd('vertical diffsplit ' .. opts.args)
end, { nargs = 1, complete = 'file' })
