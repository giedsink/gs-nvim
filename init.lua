vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("lazy-bootstrap")
require("keymaps")

vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE
  hi LineNr guibg=NONE
  hi FoldColumn guibg=NONE
]])
