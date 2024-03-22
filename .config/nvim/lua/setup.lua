local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    "lazypath",
  })
end
vim.opt.runtimepath:prepend(lazypath)

local theme = require("themes").current_theme

require("lazy").setup("plugins", {
  install = {
    colorscheme = { theme.current_theme },
  },
})
