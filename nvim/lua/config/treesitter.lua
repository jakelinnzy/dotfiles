local M = {}


function M.setup()
    M.setup_treesitter()
end


function M.setup_treesitter()
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = { 'bash', 'zsh' },
        },
        indent = {
            enable = true,
            disable = { 'bash', 'zsh', 'lua' },
        },
    }
end


return M
