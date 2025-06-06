-------------------------------------------------------------------------------
-- user/plugins.lua
-------------------------------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- visuals
Plug('karb94/neoscroll.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('akinsho/bufferline.nvim', { tag = 'v4.9.1' })

-- motions
Plug('ggandor/leap.nvim')

-- files
Plug('ibhagwan/fzf-lua')
Plug('nvim-tree/nvim-tree.lua', { tag = 'v1.12.0' })

-- programming utilities
Plug('nvim-treesitter/nvim-treesitter', { branch = 'master' })
Plug('lukas-reineke/indent-blankline.nvim', { tag = 'v3.9.0' })
Plug('numToStr/Comment.nvim')
Plug('stevearc/aerial.nvim', { tag = 'v2.5.0' })
Plug('windwp/nvim-autopairs')

-- Git utilities
Plug('lewis6991/gitsigns.nvim', { tag = 'v1.0.2' })

-- LSP
Plug('neovim/nvim-lspconfig', { tag = 'v2.2.0' })
Plug('mason-org/mason.nvim', { tag = 'v2.0.0' })
Plug('mason-org/mason-lspconfig.nvim', { tag = 'v2.0.0' })

Plug('hrsh7th/nvim-cmp', { tag = 'v0.0.2' })
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')

Plug('L3MON4D3/LuaSnip', {
    tag = 'v2.4.0',
    ['do'] = 'make install_jsregexp'
})
Plug('saadparwaiz1/cmp_luasnip')

vim.call('plug#end')


local keymap_opts = { noremap = true, silent = true }

local function try_require(plugin_name)
    local ok, plugin = pcall(require, plugin_name)
    if ok then
        return plugin
    else
        local metatable = {
            __index = function (_ ,key)
                local message = string.format(
                    'calling "%s" on missing plugin "%s', key, plugin_name
                )
                vim.notify(message, vim.log.levels.DEBUG)
                return function () end  -- dummy function
            end
        }
        plugin = {}
        setmetatable(plugin, metatable)
        return plugin
    end
end

-- neoscroll.nvim
try_require('neoscroll').setup({
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
    stop_eof = false,
    easing = 'quadratic',
})

-- lualine.nvim
try_require('lualine').setup({
    options = {
        theme = 'nord',
        icons_enabled = false,
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
            {
                'filename',
                path = 3,
            },
        },
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp', 'nvim_diagnostic'},
            },
            'lsp_status',
        },
        lualine_y = {'filetype'},
        lualine_z = {'%c %l/%L'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'%c %l/%L'},
        lualine_z = {}
    },
    extensions = {'fzf', 'nvim-tree', 'quickfix'},
})

-- bufferline.nvim
try_require('bufferline').setup({
    options = {
        style_preset = 'minimal',
        buffer_close_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        truncate_names = false,
        diagnostics = 'nvim_lsp',
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        separator_style = 'thick',
        sort_by = 'insert_after_current',
    },
})
vim.keymap.set('n', '<C-l>', '<cmd>BufferLineCycleNext<cr>', keymap_opts)
vim.keymap.set('n', '<C-h>', '<cmd>BufferLineCyclePrev<cr>', keymap_opts)
vim.keymap.set('n', 'b]', '<cmd>BufferLineMoveNext<cr>', keymap_opts)
vim.keymap.set('n', 'b[', '<cmd>BufferLineMovePrev<cr>', keymap_opts)

-- leap.nvim
try_require('leap').set_default_mappings()

-- fzf.lua
-- files/directories to ignore when searching for files
local ignore_patterns = {
    { value = '.git', is_dir = true },
    { value = '.ruff_cache', is_dir = true },
    { value = '.venv', is_dir = true },
    { value = '__pycache__', is_dir = true },
    { value = 'node_modules', is_dir = true },
}
local fzf_find_opts = {'-type', 'f'}
local fzf_rg_opts = {'--color=never', '--hidden', '--no-ignore', '--files'}
local fzf_fd_opts = {'--color=never', '--hidden', '--no-ignore', '--type="file"'}
for _, pattern in ipairs(ignore_patterns) do
    if pattern.is_dir then
        local find_opt = string.format("-not -path '*/%s/*'", pattern.value)
        table.insert(fzf_find_opts, find_opt)
    else
        local find_opt = string.format("-not -name '%s'", pattern.value)
        table.insert(fzf_find_opts, find_opt)
    end
    local rg_opt = string.format("--glob='!%s'", pattern.value)
    table.insert(fzf_rg_opts, rg_opt)
    local fd_opt = string.format("--exclude='%s'", pattern.value)
    table.insert(fzf_fd_opts, fd_opt)
end
try_require('fzf-lua').setup({
    winopts = {
        height = 0.85,
        width = 0.9,
    },
    defaults = {
        file_icons = false,
        git_icons = false,
        color_icons = false,
        find_opts = table.concat(fzf_find_opts, ' '),
        rg_opts = table.concat(fzf_rg_opts, ' '),
        fd_opts = table.concat(fzf_fd_opts, ' '),
    },
})
vim.keymap.set('n', '<c-p>', '<cmd>FzfLua files<cr>', keymap_opts)

-- nvim-tree.lua
try_require('nvim-tree').setup({
    renderer = {
        add_trailing = true,
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
                modified = false,
                hidden = false,
                diagnostics = false,
                bookmarks = false,
            },
        },
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', keymap_opts)

-- nvim-treesitter
try_require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})

-- indent-blankline.nvim
try_require('ibl').setup({
    indent = {
        char = '│'
    },
    scope = {
        char = '┃',
        show_start = false,
        show_end = false,
    },
})

-- Comment.nvim
try_require('Comment').setup()

-- aerial.nvim
try_require('aerial').setup({
    backends = {'lsp', 'treesitter'},
    layout = {
        default_direction = 'float',
        min_width = 24,
        max_width = {60, 0.6}
    },
    float = {
        relative = 'editor',
        height = 0.7,
    },
    keymaps = {
        ['<esc>'] = 'actions.close',
    },
    nerd_font = false,
    show_guides = true,
    close_on_select = true,
})
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<cr>', keymap_opts)

-- nvim-autopairs
try_require('nvim-autopairs').setup()

-- gitsigns.nvim
try_require('gitsigns').setup()
vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame<cr>', keymap_opts)
vim.keymap.set('n', '<leader>gl', '<cmd>Gitsigns blame_line<cr>', keymap_opts)

-- LSP
try_require('user.lsp').setup()
