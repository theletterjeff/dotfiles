return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    sections = {
      lualine_a = {},
      lualine_b = { {"buffers", mode = 4} },
      lualine_c = {},
      lualine_x = { {"filename", path = 1} },
      lualine_y = {"progress", "location"},
      lualine_z = { {"datetime", style = "%I:%M:%S %p"} },
    },
    options = {
      component_separators = "|",
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
