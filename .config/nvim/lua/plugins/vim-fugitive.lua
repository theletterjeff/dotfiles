return {
  "tpope/vim-fugitive",
  lazy = false,
  keys = {
    {
      "<esc><esc>",
      ":<C-U>if bufnr('$') == 1<Bar>quit<Bar>else<Bar>bdelete<Bar>endif<CR>",
      desc = "Exit fugitive window",
      silent = true,
    },
  },
}
