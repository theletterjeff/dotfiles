local mason = {
  "williamboman/mason.nvim",
  dependencies = {
    "pmizio/typescript-tools.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
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
      "jsonnet_ls",
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

    -- -- go
    -- lspconfig.gopls.setup {
    --   on_new_config = function(config, new_root_dir)
    --     local gopackagesdriver = new_root_dir .. "/tools/gopackagesdriver.sh"
    --     if vim.loop.fs_stat(new_root_dir) ~= nil then
    --       config.cmd_env = {
    --         GOPACKAGESDRIVER = gopackagesdriver,
    --         GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
    --       }
    --     end
    --   end,
    --   settings = {
    --     gopls = {
    --       directoryFilters = {
    --         "-bazel-app",
    --         "-bazel-bin",
    --         "-bazel-out",
    --         "-bazel-testlogs",
    --         "-bazel-vistar",
    --       },
    --     },
    --   },
    -- }

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

    -- python
    lspconfig.basedpyright.setup {
      flags = { debounce_text_changes = 300 },
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "off",
            inlayHints = {
              functionReturnTypes = false,
              genericTypes = false,
              variableTypes = false,
            },
            diagnosticMode = "openFilesOnly",
          },
        },
        exclude = {
          "bazel-bin",
          "bazel-out",
          "bazel-app",
          "bazel-vistar",
        },
      },
    }

    lspconfig.vtsls.setup {
      settings = {
        complete_function_calls = true,
        typescript = {
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
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
