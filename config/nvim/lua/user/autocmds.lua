-------------------------------------------------------------------------------
-- user/autocmds.lua
-------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local myGroup = augroup('MyGroup', { clear = true })

autocmd('InsertEnter', {
    pattern = '*',
    group = myGroup,
    callback = function ()
        vim.wo.list = false
    end,
})

autocmd('InsertLeave', {
    pattern = '*',
    group = myGroup,
    callback = function ()
        vim.wo.list = true
    end,
})

