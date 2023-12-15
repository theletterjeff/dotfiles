local configs = require("plugins.configs.lspconfig")
local lspconfig = require("lspconfig")
local utils = require("custom.utils")

-- use in `add_hook_before` call to create the `cmd_end` key
local gopls_hook = function(config)
  local is_gopls = config.name == "gopls"
  local is_readable = vim.fn.filereadable(utils.cwd() .. "/WORKSPACE") ~= 1
	if is_gopls and is_readable then
		config.settings.cmd_env = {}
	end
end

lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, gopls_hook)

lspconfig.gopls.setup({
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
	on_new_config = function(config, new_root_dir)
		local gopackagesdriver = new_root_dir .. "/tools/gopackagesdriver.sh"
		if utils.fs_stat(gopackagesdriver) ~= nil then
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
				"-bazel-vistar",
				"-bazel-app",
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        composites = false, -- vistar uses unkeyed structs liberally
        unusedparams = true,
        unusedvariable = true,
      },
			["ui.semanticTokens"] = true,
		},
	},
	flags = {
		debounce_text_changes = 150,
  },
})

lspconfig.pyright.setup({
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  filetypes = {"python"},
})
