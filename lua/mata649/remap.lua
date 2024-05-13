vim.g.mapleader = " "
-- Explorer
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)
-- Delete word
vim.keymap.set("i", "<C-h>", "<C-w>")

-- Copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y')

-- Movie line
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

-- I don't remember but I am sure it pastes
vim.keymap.set("x", "p", '"_dP')

-- Tabs
vim.keymap.set("n", "<leader>t", vim.cmd.tabnew)
vim.keymap.set("n", "<leader>nt", vim.cmd.tabnext)
vim.keymap.set("n", "<leader>pt", vim.cmd.tabp)
