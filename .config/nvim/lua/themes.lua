local M = {}

local current_theme = "tokyonight"

M.themes = {
  tokyonight = {
    package = "folke/tokyonight.nvim",
    package_name = "tokyonight.nvim",
    name = "tokyonight",
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
	catppuccin = {
		package = "catppuccin/nvim",
		package_name = "catppuccin",
		name = "catppuccin",
		config = function(palette)
			require("catppuccin").setup({
				flavour = palette or "mocha",
				custom_highlights = function(colors)
					return {
						cjsxElement = { link = "@constructor" },
						cjsxAttribProperty = { link = "@tag.attribute" },
						MatchParenCur = { fg = colors.yellow, style = { "bold" } },
						MatchParen = { bg = colors.base, fg = colors.yellow, style = { "bold" } },
						LspInlayHint = { link = "Comment" },
					}
				end,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

M.current_theme = M.themes[current_theme]
if M.current_theme == M.themes["catppuccin"] then
  M.current_theme.palette = "mocha"
end

return M
