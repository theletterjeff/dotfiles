return {
  'nvim-telescope/telescope.nvim',
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    {
      "<leader>fa",
      "<cmd>Telescope find_files follow=true hidden=true<CR>",
      desc = "Find files (all)"
    },
    {
      "<leader>fg",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Live grep (args)",
    },
    {
      "<leader>fu",
      function()
        require("telescope.builtin").live_grep({ grep_open_files = true })
      end,
      desc = "Live grep open buffers",
    },
    { "<leader>fw", "<cmd>Telescope live_grep<CR>",  desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find file in buffers" },
    {
      "<leader>fd",
      "<cmd>lua require'telescope.builtin'.live_grep({ grep_open_files = true })<CR>",
      desc = "Grep open buffers",
    },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find recent file" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = { ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist },
          n = {},
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "ignore_case",
        },
      },
    })
  end,
}
