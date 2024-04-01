return {
  "simonmclean/triptych.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "nvim-tree/nvim-web-devicons", -- optional
  },
  config = function()
    require("triptych").setup({
      mappings = {
        quit = "<esc><esc>",
      },
      options = {
        line_numbers = {
          relative = true,
        },
      },
    })
  end,
  keys = {
    { "<leader>ft", "<cmd>Triptych<cr>", desc = "Navigate files (Triptych)" },
  },
}
