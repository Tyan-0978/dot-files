-------------------------------------------------------------------------------
-- user/options.lua
-------------------------------------------------------------------------------
local opt = vim.opt

-- misc. options
opt.autoindent = true
opt.autoread = true
opt.background = 'dark'
opt.backspace = {'indent', 'eol', 'start'}
opt.completeopt = 'menuone'
opt.guicursor = 'n-v:block,i-c-ci-ve:ver25,a:blinkwait1000-blinkoff600-blinkon300'
opt.hidden = true
opt.list = true
opt.listchars = 'tab:>-,trail:$'
opt.mouse = ''
opt.number = true
opt.scrolloff = 3
opt.shiftround = true
opt.shiftwidth = 4
opt.wildmenu = true
opt.wildoptions = 'pum'
opt.wrap = true
opt.langremap = false
opt.showmatch = false

-- tabs
opt.expandtab = true
opt.smarttab = true

-- timeout
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 100
opt.updatetime = 1000

-- folding
opt.foldenable = true
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldnestmax = 10

-- highlight
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#555555' })

-- fallback syntax highlighting
vim.cmd('syntax on')
vim.cmd('syntax enable')
