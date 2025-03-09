local register = require("which-key").register

-- NORMAL MODE --
register({
  ["<esc>"] = { "<cmd>noh<cr>", "Clear highlights" },

  -- buffer operations
  ["<leader>x"] = {
    function()
      require("utils").close_buffer_keep_window()
    end,
    "Delete buffer",
  },
  ["<tab>"] = { "<cmd>bnext<cr>", "Next buffer" },
  ["<S-tab>"] = { "<cmd>bprev<cr>", "Previous buffer" },
  ["<leader>bb"] = { "<cmd>b#<cr>", "Last visited buffer" },

  -- window operations
  ["<C-h>"] = { "<C-w>h", "Move to left window" },
  ["<C-l>"] = { "<C-w>l", "Move to right window" },
  ["<C-j>"] = { "<C-w>j", "Move to bottom window" },
  ["<C-k>"] = { "<C-w>k", "Move to top window" },
  ["<leader>wc"] = { "<C-w>c", "Close window" },

  ["<leader>sp"] = { "<cmd>echo expand('%')<cr>", "Show path" },
  ["<leader>cp"] = { "<cmd>let @+=expand('%')<cr>", "Copy path" },
  ["<"] = { "<S-v><", "Decrease indent" }, -- TODO: speed up
  [">"] = { "<S-v>>", "Increase indent" }, -- TODO: speed up
}, {
  mode = "n",
  noremap = true,
})

vim.api.nvim_set_keymap("n", "<leader>b", ":lua require('utils').switch_to_buffer()<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>kq", ":lua open_diagnostics_in_qf()<CR>",
  { noremap = true, silent = true })

-- INSERT MODE --
register({
  ["<C-h>"] = { "<Left>", "Move Left" },
  ["<C-l>"] = { "<Right>", "Move Right" },
  ["<C-j>"] = { "<Down>", "Move Down" },
  ["<C-k>"] = { "<Up>", "Move Up" },
}, {
  mode = "i",
  noremap = true,
})

-- TERMINAL MODE --
register({
  ["<esc>"] = { "<C-\\><C-n>", "Return to normal mode" },
}, {
  mode = "t",
  noremap = true,
})

-- VISUAL MODE --
register({
  ["<"] = { "<gv", "Decrease indent" },
  [">"] = { ">gv", "Increase indent" },
}, {
  mode = "v",
  noremap = true,
})

-- FILETYPE MAPPINGS --
-- Define a keymap for BUILD files and .bzl files
vim.api.nvim_create_augroup("BazelFiles", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "BazelFiles",
  pattern = { "BUILD", "*.bzl" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>kd', ':lua <cmd>call GoToBazelDefinition()<CR><esc>',
      { desc = "Go to Bazel definition", noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>kt', ':lua <cmd>call GoToBazelTarget()<CR>',
      { desc = "Go to Bazel target", noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>kl', ':<cmd>call GetLabel()<CR>',
      { desc = "Get label", noremap = true, silent = true })
  end,
})
