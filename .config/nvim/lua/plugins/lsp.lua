local mason = {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	keys = {
    { "<leader>kd", desc = "Go to definition", vim.lsp.buf.definition },
    { "<leader>ke", desc = "Go to declaration", vim.lsp.buf.declaration },
    { "<leader>kh", desc = "LSP hover information", vim.lsp.buf.hover },
    { "<leader>km", desc = "Go to implementation", vim.lsp.buf.implementation },
    { "<leader>ks", desc = "LSP show signature help", vim.lsp.buf.signature_help },
    { "<leader>kn", desc = "Rename symbol", vim.lsp.buf.rename },
    { "<leader>kr", desc = "List references", vim.lsp.buf.references },
	},
	config = function()
		require("mason").setup()
	end,
}

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "gopls",
      "lua_ls",
      "pyright",
    },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end,
}

local lspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    require("neodev").setup()

    -- go
    lspconfig.gopls.setup {
      settings = {
        gopls = {
          env = {
            GOPACKAGESDRIVER = os.getenv("VISTAR_DIR") .. "/tools/gopackagesdriver.sh",
            GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
          },
          directoryFilters = {
            "-bazel-bin",
            "-bazel-out",
            "-bazel-testlogs",
            "-bazel-vistar",
          },
        },
      },
    }

    -- lua
    lspconfig.lua_ls.setup {}

    -- python
    lspconfig.pyright.setup {
      flags = { debounce_text_changes = 300 },
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            extra_paths = { vim.loop.cwd() },
          },
        },
      },
    }

  end,
}

return {
  mason,
  mason_lspconfig,
  lspconfig,
}
