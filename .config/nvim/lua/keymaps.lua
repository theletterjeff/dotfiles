local register = require("which-key").register

-- NORMAL MODE --
register({
  ["<esc>"] = { "<cmd>noh<cr>", "Clear highlights" },

  -- buffer operations
  ["<leader>x"] = { "<cmd>bd!<cr>", "Delete buffer" },
  ["<tab>"] = { "<cmd>bnext<cr>", "Next buffer" },
  ["<S-tab>"] = { "<cmd>bprev<cr>", "Previous buffer" },

  -- window operations
  ["<C-h>"] = { "<C-w>h", "Move to left window" },
  ["<C-l>"] = { "<C-w>l", "Move to right window" },
  ["<C-j>"] = { "<C-w>j", "Move to bottom window" },
  ["<C-k>"] = { "<C-w>k", "Move to top window" },
  ["<leader>wc"] = { "<C-w>c", "Close window" },

  -- lsp
  ["<leader>kd"] = {
    function()
      vim.lsp.buf.definition()
    end,
    "Go to definition",
  },
  ["<leader>ke"] = {
    function()
      vim.lsp.buf.declaration()
    end,
    "Go to declaration",
  },
  ["<leader>kh"] = {
    function()
      vim.lsp.buf.hover()
    end,
    "LSP hover information",
  },
  ["<leader>ki"] = {
    function()
      vim.lsp.buf.implementation()
    end,
    "Go to implementation",
  },
  ["<leader>ks"] = {
    function()
      vim.lsp.buf.signature_help()
    end,
    "LSP show signature help",
  },
}, {
  mode = "n",
  noremap = true,
})

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
