-- ui 
vim.o.number = true
vim.opt.colorcolumn = "80"
vim.o.statusline = "%f"
vim.o.relativenumber = true

-- search
vim.o.ignorecase = false

-- indents
local function set_indent(fileType, tabSize, expand_tab)
	expand_tab = expand_tab or false
  vim.api.nvim_create_autocmd("FileType", {
    pattern = fileType,
    callback = function()
      vim.opt_local.tabstop = tabSize
      vim.opt_local.shiftwidth = tabSize
			vim.opt_local.expandtab = expand_tab
    end,
  })
end

vim.o.expandtab = false -- use spaces instead of tabs

set_indent("go", 4)
set_indent("lua", 2)
set_indent("proto", 2, true)
set_indent("sh", 4)
set_indent("sql", 4)
set_indent("starlark", 4)
set_indent("tsx", 2)
set_indent("typescript", 2)

-- stop entering insert mode automatically in terminal windows
vim.api.nvim_create_autocmd("WinEnter", {
	pattern = "term://*",
	command = "stopinsert",
})

local os_name = os.getenv("OSTYPE") or io.popen("uname"):read("*l")

if os_name:lower():find("darwin") then
  set_indent("python", 4)

elseif os_name:lower():find("linux") then
  set_indent("python", 2)

else
  print("Unknown OS")

end
