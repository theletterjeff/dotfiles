local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- globals -----------------------------------------
g.toggle_theme_icon = "   "

-------------------------------------- options -----------------------------------------
o.shell = "/usr/bin/bash -i"
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both"
o.colorcolumn = "80"
g.rainbow = 1

-- indents
local function set_indent(file_pattern, tab_size, expand_tab)
  expand_tab = expand_tab or true
  vim.api.nvim_create_autocmd("FileType", {
    pattern = file_pattern,
    callback = function()
      vim.bo.tabstop = tab_size
      vim.bo.shiftwidth = tab_size
      vim.bo.expandtab = expand_tab
    end,
  })
end

vim.o.expandtab = true -- use spaces instead of tabs

set_indent("bzl", 4)
set_indent("confg", 4)
set_indent("go", 4, false)
set_indent("lua", 2)
set_indent("markdown", 4)
set_indent("proto", 2)
set_indent("scala", 2)
set_indent("sh", 4)
set_indent("sql", 4)
set_indent("typescript", 2)
set_indent("typescriptreact", 2)

-- python indent is os-specific
-- (vistar/linux is 2, personal/mac is 4)
local os_name = os.getenv("OSTYPE") or io.popen("uname"):read("*l")
if os_name:lower():find("darwin") then
  set_indent("python", 4)
elseif os_name:lower():find("linux") then
  set_indent("python", 2)
else
  print("Unknown OS")
end

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
vim.g["loaded_node_provider"] = 0
vim.g["loaded_python3_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
