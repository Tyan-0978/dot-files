-------------------------------------------------------------------------------
-- user/keymaps.lua
-------------------------------------------------------------------------------
vim.g.mapleader = ','
vim.g.maplocalleader = ','

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- misc.
map('n', '<leader>r', '<cmd>source $MYVIMRC<cr>', opts)
map('n', "<leader>'", "viw<esc>a'<esc>bi'<esc>", { noremap = true, silent = false })
map('n', '<leader>"', 'viw<esc>a"<esc>bi"<esc>', { noremap = true, silent = false })

-- system clipboard
map('n', '<leader>y', '"+yy', opts)
map('n', '<leader>p', '"+p', opts)
map('v', '<leader>y', '"+y', opts)
map('v', '<leader>p', '"+p', opts)
