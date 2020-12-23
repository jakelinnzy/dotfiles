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
        require('colorizer').setup()
    end

    if vim.fn.has('nvim-0.5.0') ~= 0 then
        require('config/lsp').setup()
        require('config/treesitter').setup()
    end

    require('config/which_key_map').setup()
end


return M
