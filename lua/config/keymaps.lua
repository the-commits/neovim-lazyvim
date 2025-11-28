-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move lines up and down in normal and visual modes
vim.keymap.set("n", "<C-j>", function()
  if vim.fn.line(".") < vim.fn.line("$") then
    vim.cmd("m .+1")
    vim.cmd("normal! ==")
  end
end, { desc = "Move line down" })

vim.keymap.set("n", "<C-k>", function()
  if vim.fn.line(".") > 1 then
    vim.cmd("m .-2")
    vim.cmd("normal! ==")
  end
end, { desc = "Move line up" })

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
