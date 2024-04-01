return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local vistar_dir = os.getenv("VISTAR_DIR")

    null_ls.setup({
      sources = {
        -- python
        null_ls.builtins.formatting.yapf.with({
          extra_args = {"--style", vistar_dir .. "/tools/pyfmt/.style.yapf"},
        }),
        null_ls.builtins.diagnostics.mypy.with({
          extra_args = {"--config-file", vistar_dir .. "/tools/mypy/mypy.ini"},
        }),
        null_ls.builtins.diagnostics.ruff.with({
          extra_args = {"--config", vistar_dir .. "/tools/lint/ruff.toml"},
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
      end
    })
  end,
}
