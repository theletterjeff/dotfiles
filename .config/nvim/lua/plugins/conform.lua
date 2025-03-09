return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    -- take a bazel formatter target and optional args and return a table that
    -- can be passed to a formatter key
    local formatter_config = function(bazel_target, ...)
      local unpack = unpack or table.unpack
      local args = (
        ... and { "run", bazel_target, unpack({ ... }) }
      ) or { "run", bazel_target }

      return {
        command = "bazel",
        args = args,
        stdin = true,
        cwd = util.root_file("WORKSPACE"),
        require_cwd = true,
      }
    end

    conform.setup({
      formatters_by_ft = {
        bzl = { "buildifier" },
        -- go = { "gofmt" },
        json = { "jq" },
        lua = { "stylua" },
        python = { "pyfmt" },
        scala = { "scalafmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        pyfmt = formatter_config("//tools/pyfmt"),
        -- gofmt = formatter_config("//:gofmt", "--", "$PWD/$FILENAME"),
        scalamft = formatter_config("//tools/scalafmt", "--", "$PWD/$FILENAME"),
      },
      format_on_save = {
        lsp_fallback = true,
      },
      notify_on_error = true,
    })
  end,
}
