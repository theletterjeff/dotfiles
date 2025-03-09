return {
  "simonmclean/triptych.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",       -- required
    "nvim-tree/nvim-web-devicons", -- optional
  },
  config = function()
    require("triptych").setup({
      mappings = {
        quit = "<esc><esc>",
      },
      extension_mappings = {
        ['<leader>fw'] = {
          mode = 'n',
          fn = function(target)
            require 'telescope.builtin'.live_grep {
              search_dirs = { target.path:match("(.*/)") }
            }
          end
        }
      },
      options = {
        line_numbers = {
          relative = true,
        },
        show_hidden = true,
      },
    })
  end,
  keys = {
    { "<leader>ft", "<cmd>Triptych<cr>", desc = "Navigate files (Triptych)" },
  },
}
