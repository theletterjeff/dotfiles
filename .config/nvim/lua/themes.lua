local M = {}

M.themes = {
  tokyonight = {
    package = "folke/tokyonight.nvim",
    package_name = "tokyonight.nvim",
    name = "tokyonight",
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
}

M.current_theme = M.themes["tokyonight"]

return M
