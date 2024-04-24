local mason = {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  keys = {
    { "<leader>kd", desc = "Go to definition",        vim.lsp.buf.definition },
    { "<leader>ke", desc = "Go to declaration",       vim.lsp.buf.declaration },
    { "<leader>kh", desc = "LSP hover information",   vim.lsp.buf.hover },
    { "<leader>km", desc = "Go to implementation",    vim.lsp.buf.implementation },
    { "<leader>ks", desc = "LSP show signature help", vim.lsp.buf.signature_help },
    { "<leader>kn", desc = "Rename symbol",           vim.lsp.buf.rename },
    { "<leader>kr", desc = "List references",         vim.lsp.buf.references },
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
    {
      "fatih/vim-go",
      config = function()
        vim.cmd(":GoInstallBinaries")
      end,
    },
    "folke/neodev.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local util = lspconfig.util

    require("neodev").setup()

    -- go
    lspconfig.gopls.setup {
      on_new_config = function(config, new_root_dir)
        local gopackagesdriver = new_root_dir .. "/tools/gopackagesdriver.sh"
        if vim.loop.fs_stat(new_root_dir) ~= nil then
          config.cmd_env = {
            GOPACKAGESDRIVER = gopackagesdriver,
            GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
          }
        end
      end,
      settings = {
        gopls = {
          directoryFilters = {
            "-bazel-bin",
            "-bazel-out",
            "-bazel-testlogs",
            "-bazel-" .. require("utils").get_current_dir_name(),
          },
        },
      },
      root_dir = util.root_pattern("WORKSPACE"),
    }

    -- lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globales = { "vim" },
          },
        },
      },
    }

    -- scala
    lspconfig.metals.setup {}

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

-- gopls functionality: "gopls.add_dependency", "gopls.add_import", "gopls.add_telemetry_counters", "gopls.apply_fix", "gopls.change_signature", "gopls.check_upgrades", "gopls.diagnose_files", "gopls.edit_go_directive", "gopls.fetch_vulncheck_result", "gopls.gc_details", "gopls.generate", "gopls.go_get_package", "gopls.list_imports", "gopls.list_known_packages", "gopls.maybe_prompt_for_telemetry", "gopls.mem_stats", "gopls.regenerate_cgo", "gopls.remove_dependency", "gopls.reset_go_mod_diagnostics", "gopls.run_go_work_command", "gopls.run_govulncheck", "gopls.run_tests", "gopls.start_debugging", "gopls.start_profile", "gopls.stop_profile", "gopls.test", "gopls.tidy", "gopls.toggle_gc_details", "gopls.update_go_sum", "gopls.upgrade_dependency", "gopls.vendor", "gopls.views", "gopls.workspace_stats"
-- things to try
-- set goroot. doesn't seem to be set currently
