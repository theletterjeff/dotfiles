vim.o.number = true
vim.opt.colorcolumn = "80"
vim.o.statusline = vim.o.statusline .. "%f"

-- indents
vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true -- Use spaces instead of tabs
    end,
})
