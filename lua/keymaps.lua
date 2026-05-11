local keymap = vim.keymap.set

-- Window resizing
keymap("n", "<C-j>", ":resize +2<CR>", { desc = "Resize window down" })
keymap("n", "<C-k>", ":resize -2<CR>", { desc = "Resize window up" })
keymap("n", "<C-h>", ":vertical resize -2<CR>", { desc = "Resize window left" })
keymap("n", "<C-l>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Window navigation
keymap("n", "<leader><down>", "<C-w>j", { desc = "Move to window below" })
keymap("n", "<leader><up>", "<C-w>k", { desc = "Move to window above" })
keymap("n", "<leader><left>", "<C-w>h", { desc = "Move to window left" })
keymap("n", "<leader><right>", "<C-w>l", { desc = "Move to window right" })

-- File explorer (netrw fallback)
keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- Move selected lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centred when scrolling/searching
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Paste without overwriting clipboard
keymap("x", "<leader>p", '"_dP', { desc = "Paste without losing clipboard" })

-- Yank to system clipboard
keymap("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
