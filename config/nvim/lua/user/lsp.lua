-------------------------------------------------------------------------------
-- user/lsp.lua
-------------------------------------------------------------------------------

local function setup_mason()
    local mason_ok, mason = pcall(require, 'mason')
    if not mason_ok then
        vim.notify('mason not found')
        return
    end
    mason.setup({
        ui = {
            icons = {
                package_installed = 'O',
                package_pending = '-',
                package_uninstalled = 'X',
            },
        },
    })

    local mlc_ok, mason_lsp_config = pcall(require, 'mason-lspconfig')
    if not mlc_ok then
        vim.notify('mason-lspconfig not found')
        return
    end
    mason_lsp_config.setup({
        automatic_enable = true,
        ensure_installed = {
            'basedpyright',
            'ruff',
            'lua_ls',
        },
    })
end


local function on_attach(client, bufnr)
    local function map(mode, lhs, rhs, desc)
        local opts = {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = 'LSP: ' .. desc,
        }
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    local function remap(mode, lhs, rhs, desc)
        local opts = {
            remap = true,
            silent = true,
            buffer = bufnr,
            desc = 'LSP: ' .. desc .. ' (remap)',
        }
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- core
    map('n', 'gd', vim.lsp.buf.definition, 'go to definition')
    map('n', 'K', vim.lsp.buf.hover, 'hover documentation')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'rename symbol')
    map({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, 'code action')

    -- diagnostics
    remap('n', '<leader>d[', '[d', 'previous diagnostic')
    remap('n', '<leader>d]', ']d', 'next diagnostic')
    map('n', '<leader>dl', vim.diagnostic.setloclist, 'open diagnostics list')
    map('n', '<leader>do', vim.diagnostic.open_float, 'show diagnostic float')

    -- formatting
    map({'n', 'v'}, '<leader>lf', function ()
        vim.lsp.buf.format({ async = true })
    end, 'format code')
end


local function on_attach_event_callback(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
        return
    end
    for bufnr, _ in pairs(client.attached_buffers) do
        on_attach(client, bufnr)
    end
end


local function setup_lsp_config()
    -- cmp-nvim-lsp
    local capabilities
    local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
    else
        vim.notify('cmp-nvim-lsp not found; fallback to empty capabilities')
        capabilities = {}
    end

    -- default config for all language servers
    vim.lsp.config('*', {
        capabilities = capabilities,
    })
    local lspGroup = vim.api.nvim_create_augroup('LspGroup', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
        group = lspGroup,
        callback = on_attach_event_callback,
    })

    -- basedpyright
    vim.lsp.config('basedpyright', {
        settings = {
            basedpyright = {
                autoSearchPaths = true,
                disableOrganizeImports = true,
                disableTaggedHints = false,
                analysis = {
                    autoImportCompletions = false,
                    autoSearchPaths = true,
                    diagnosticMode = 'openFilesOnly',
                    -- setting below can be overridden by pyrightconfig.json
                    diagnosticSeverityOverrides = {
                        -- values: error/warning/information/true/false/none
                    },
                    ignore = {
                        -- file paths to ignore
                    },
                    typeCheckingMode = 'standard',
                },
            },
        },
    })

    -- lua-ls / lua-language-server
    vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = {'vim'},
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = 'space',
                        indent_size = '4',
                    },
                },
            },
        },
    })

    -- ruff
    vim.lsp.config('ruff', {
        init_options = {
            settings = {
                lineLength = 79,
                configuration = {
                    format = {
                        ["quote-style"] = 'single',
                    },
                },
                organizeImports = true,
                lint = {
                    enable = false,
                },
            },
        },
    })

    -- diagnostic
    vim.diagnostic.config({
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
    })
end


local function setup_completion()
    local cmp_ok, cmp = pcall(require, 'cmp')
    if not cmp_ok then
        vim.notify('nvim-cmp not found')
        return
    end

    local luasnip_ok, luasnip = pcall(require, 'luasnip')
    if not luasnip_ok then
        vim.notify('luasnip not found')
    end

    local select_opts = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'luasnip' },
        }),
        mapping = cmp.mapping.preset.insert({
            ['<c-j>'] = cmp.mapping.scroll_docs(1),
            ['<c-k>'] = cmp.mapping.scroll_docs(-1),
            ['<c-n>'] = cmp.mapping.select_next_item(select_opts),
            ['<c-p>'] = cmp.mapping.select_prev_item(select_opts),
            ['<tab>'] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Replace,
            }),
        }),
        preselect = cmp.PreselectMode.Item,
        completion = {
            keyword_length = 0,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function (args)
                if luasnip_ok then
                    luasnip.lsp_expand(args.body)
                end
            end,
        },
        experimental = {
            ghost_text = true,
        },
    })
    cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        completion = {
            keyword_length = 2,
        },
        sources = {
            { name = 'path' },
            { name = 'cmdline' },
        },
    })
end


return {
    setup = function()
        setup_mason()
        setup_lsp_config()
        setup_completion()
    end
}
