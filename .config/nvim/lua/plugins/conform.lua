return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		local util = require("conform.util")

		conform.setup({
			formatters_by_ft = {
				bzl = { "buildifier" },
        go = { "gofmt" },
				json = { "jq" },
				lua = { "stylua" },
				python = { { "pyfmt", "black" } },
        scala = { "scalafmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				lsp_fallback = true,
			},
			notify_on_error = true,
			formatters = {
				pyfmt = {
					command = "bazel",
					args = { "run", "//tools/pyfmt" },
					stdin = true,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
				scalamft = {
					command = "bazel",
					args = { "run", "//tools/scalafmt" },
					stdin = true,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
				gofmt = {
					command = "bazel",
					args = { "run", "//:gofmt", "--", "-w" },
					stdin = true,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
			},
		})
	end,
}
