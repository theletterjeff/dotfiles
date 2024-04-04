return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")

    -- main
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "buffer",   group_index = 2 },
        { name = "luasnip",  group_index = 3 },
      },
      matching = {
        disallow_fuzzy_matching = true,
        disallow_partial_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_prefix_unmatching = true,
        disallow_symbol_nonprefix_matching = true,
      },
      completion = {
        keyword_length = 3,
      },
      enabled = function()
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
        end
      end
    })

    -- cmd line search
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer', group_index = 1 },
      }
    })

    -- cmd line command
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'path',    group_index = 1 },
        { name = 'cmdline', group_index = 2 },
      }
    })
  end,
}
