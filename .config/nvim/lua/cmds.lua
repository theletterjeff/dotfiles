vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "txt" },
  desc = "Wrap text and spell check for markdown and text files",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit" },
  desc = "Wrap text and spell check for git commit messages",
  callback = function()
    vim.opt_local.textwidth = 70
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
