
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)

vim.keymap.set("i", "<C-h>", "<C-w>")

vim.keymap.set("n", "<C-e>", vim.cmd.Ex)

vim.keymap.set("v", "<C-y>", "\"+y")

vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "p", "\"_dP")

