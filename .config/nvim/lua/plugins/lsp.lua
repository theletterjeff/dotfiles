local mason = {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	keys = {
		{ "<leader>li", desc = "Open mason", "<cmd>Mason<cr>" },
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
