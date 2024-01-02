local M = {}

M.general = {
  n = {
    ["<leader>wc"] = { "<C-w>c", "Close window" },

		-- vim-fugitive mappings outside of fugitive buffers
		-- stash
		["<leader>czz"] = {
			':<C-U>Git stash push <C-R>=v:count > 1 ? " --all" : v:count ? " --include-untracked" : ""<CR><CR>',
			"Push stash",
		},
		["<leader>czp"] = {
			':<C-U>Git stash pop --quiet --index stash@{<C-R>=v:count<CR>}<CR>',
			"Pop stash",
		},
		["<leader>cza"] = {
			':<C-U>Git stash apply --quiet --index stash@{<C-R>=v:count<CR>}<CR>',
			"Apply stash",
		},
	-- interactive rebase
  	["<leader>rr"] = {
  		':<C-U>Git rebase --continue<CR>',
  		"Continue rebase",
  	},
  	["<leader>ra"] = {
  		':<C-U>Git rebase --abort<CR>',
  		"Abort rebase",
  	},
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>" },
  },
}

M.go = {
  n = {
    ["<leader>gd"] = { "<Plug>(go-def-split)", "GoToDefinition" },
    ["<leader>gr"] = { "<Plug>(go-referrers)", "GoReferrers" },
    ["<leader>gi"] = { "<Plug>(go-implements)", "GoImplements" },
    ["<leader>gn"] = { "<Plug>(go-rename)", "GoRename" },
    ["<leader>gx"] = { "<Plug>(go-extract)", "GoExtract" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug last go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

M.telescope = {
  plugin = true,
  n = {
    ["<leader>fg"] = {
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      "Live Grep (Args)",
    }
  }
}

M.triptych = {
  n = {
    ["<leader>ft"] = { ":Triptych<CR>", "Triptych" },
  }
}

return M
