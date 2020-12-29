---- Lua config file for Neovim 0.5+

---- In vimscript, do:
----     lua requrie('my_config').setup()

---- For reference, see https://github.com/nanotee/nvim-lua-guide

local M = {}


function M.setup()
    -- caution: 0 and '' are true in Lua
    -- `~=` is the 'not equal' operator
    if vim.g.has_true_color ~= 0 then
        vim.o.termguicolors = true
        require('colorizer').setup(
            {'*'},
            {
                RGB      = false,
                names    = false,
                RRGGBB   = true,
                RRGGBBAA = true,
                css_fn   = true,  -- rgb(), rgba(), hsl(), hsla()
                mode     = 'background',
            })
    end

    if vim.fn.has('nvim-0.5.0') ~= 0 then
        M.setup_treesitter()
    end

    require('zlin/mappings').setup()
end


function M.setup_treesitter()
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


return M
