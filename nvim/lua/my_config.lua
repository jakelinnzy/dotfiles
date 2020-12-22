---- Lua config file for Neovim 0.5+

---- In vimscript, do:
----     lua requrie('my_config').setup()

---- For reference, see https://github.com/nanotee/nvim-lua-guide

local M = {}


function M.setup()
    if vim.g.has_true_color then
        vim.o.termguicolors = true
        require('colorizer').setup()
    end

    if vim.call('has', 'nvim-0.5.0') then
        M.setup_treesitter()
    end

    require('config/which_key_map').setup()
end


function M.setup_treesitter()
    local blackList = { 'bash', 'zsh', 'rust' }
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = blackList,
        },
        indent = {
            enable = true,
            disable = blackList,
        },
    }
end


return M
