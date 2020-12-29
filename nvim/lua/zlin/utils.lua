local U = {}

-- Caution: 0 and '' are true in Lua, `~=` is the 'not equal' operator
-- These variables are booleans
U.is_mac      = vim.fn.has('mac') ~= 0
U.is_linux    = vim.fn.has('linux') ~= 0
U.is_windows  = vim.fn.has('win32') ~= 0 or vim.fn.has('win64') ~= 0
U.is_nvim_nightly  = vim.fn.has('nvim-0.5.0') ~= 0
U.has_patched_font = (vim.env.TERM_PROGRAM
                      and (not not vim.regex([[\v(kitty|iTerm|alacritty)]]):match_str(vim.env.TERM_PROGRAM)))
U.has_true_color   = (vim.fn.has('gui')
                      or vim.env.COLORTERM
                      and (not not vim.regex([[\v^(truecolor|24bit)$]]):match_str(vim.env.COLORTERM)))

-- Execute a piece of Vimscript code and discard the result
--   require('zlin/utils').viml [[
--       let text = "Hello world"
--       echom text
--   ]]
function U.viml(cmd)
    if cmd then
        return
    end
    vim.api.nvim_exec(cmd, false)
end

-- Source a Vimscript file from config directory (~/.config/nvim)
-- e.g.
--   U.vimfile('plugins.vim')  -->  ~/.config/nvim/plugins.vim
function U.vimfile(filename)
    if not filename then
        return
    end
    local config_path = vim.fn.stdpath('config') .. '/'
    vim.api.nvim_command('source '..config_path..filename)
end

return U
