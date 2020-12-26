local M = {}

-- Execute a piece of Vimscript code and discard the result
--   require('zlin/utils').viml [[
--       let text = "Hello world"
--       echom text
--   ]]
function M.viml(cmd)
    if cmd then
        return
    end
    vim.api.nvim_exec(cmd, false)
end

function M.vimfile(filename)
    if not filename then
        return
    end

end

return M
