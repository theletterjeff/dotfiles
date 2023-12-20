-- Use Neovim as a language server to inject LSP diagnostics, code actions, and
-- more via Lua.

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
  --   -- go
  --   null_ls.builtins.formatting.gofmt.with({
		-- 	extra_args = { "-s" },
		-- }),
  --   null_ls.builtins.formatting.goimports_reviser,
  --   null_ls.builtins.formatting.golines,

    -- python
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.yapf.with({
      extra_args = { "--style", vim.fn.expand("~/vistar/tools/pyfmt/.style.yapf") }
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
return opts
