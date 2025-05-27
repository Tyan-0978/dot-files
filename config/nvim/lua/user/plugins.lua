-------------------------------------------------------------------------------
-- user/plugins.lua
-------------------------------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- visuals
Plug('karb94/neoscroll.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('akinsho/bufferline.nvim')

-- motions
Plug('ggandor/leap.nvim')

-- files
Plug('ibhagwan/fzf-lua')
Plug('nvim-tree/nvim-tree.lua')

-- programming utilities
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('lukas-reineke/indent-blankline.nvim')
Plug('numToStr/Comment.nvim')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')

Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')

Plug('L3MON4D3/LuaSnip')
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
        diagnostics_indicator = function(count, level)
            local icon = level:match('error') and 'xxx' or ''
            return ' ' .. icon .. count
        end,
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
try_require('fzf-lua').setup({
    file_icons = false,
    git_icons = false,
    color_icons = false,
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
    ensure_installed = { 'lua', 'python', 'vim' },
    auto_install = true,
    highlight = {
        enable = true,
    },
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

-- LSP
try_require('user.lsp').setup()
