---- init.lua file for Neovim 0.5+
---- For reference, see https://github.com/nanotee/nvim-lua-guide

-- Make this globally available
U = require('zlin/utils')

-- Use space key as <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if U.is_mac then
    vim.g.python3_host_prog = '/usr/local/bin/python3'
elseif U.is_linux then
    vim.g.python3_host_prog = '/usr/bin/python3'
end

-- Load plugins
U.vimfile('plug_setup.vim')

require('zlin/mappings').setup()

-- Load viml functions (~/.config/nvim/autoload/zlin)
vim.call('zlin#color#setup')
vim.call('zlin#syn_operator#setup')

if vim.g.has_true_color ~= 0 then
    vim.o.termguicolors = true
    require('colorizer').setup(
        {'*'},  -- for all files
        {
            RRGGBB   = true,
            RRGGBBAA = true,
            css_fn   = true,  -- rgb(), rgba(), hsl(), hsla()
            RGB      = false,
            names    = false,
            mode     = 'background',
        })
end

if U.is_nvim_nightly then
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = { "bash", "zsh" },
        },
        indent = {
            enable = false,
            -- treesitter indent does not work with Python for some reason
            disable = { "bash", "zsh", "python" },
        },
    }
end
