local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "debugpy",
        "gopls",
        "mypy",
        "pyright",
        "ruff",
        "yapf",
      },
    },
  },

  -- debugging
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = {"go", "python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
    build = function()
      vim.cmd("GoInstallBinaries")
    end,
    config = function()
      vim.g.go_fmt_command = "gofmt"
      vim.g.go_fmt_options = "-s"
      vim.g.go_imports_command = "goimports"
      vim.g.go_imports_autosave = 0
    end,
  },


  -- git
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    'rmagatti/igs.nvim',
    config = function()
      require('igs').setup {}
    end,
  },

  -- text editing
  {
    "tpope/vim-surround",
    lazy = false,
  },

  -- file navigation
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },

	-- nvchad terminal
	{
		"NvChad/nvterm",
		opts = {
			behavior = {
				auto_insert = false,
			},
		},
	},

	-- ui
	{
		"luochen1990/rainbow",
		lazy = false,
	},
}

return plugins
