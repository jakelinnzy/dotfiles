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
        M.setup_lsp()
        M.setup_treesitter()
    end

    require('config/which_key_map').setup()
end


-- Reference:
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
function M.setup_lsp()
    local lspconfig = require('lspconfig')
    -- C/C++
    lspconfig.clangd.setup {}
    -- Python
    -- :LspInstall pyls_ms
    lspconfig.pyls_ms.setup {}
    -- Lua
    lspconfig.sumneko_lua.setup {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
    }
    -- LaTeX
    lspconfig.texlab.setup {
        settings = {
            bibtex = {
                formatting = {
                    lineLength = 120
                }
            },
            latex = {
                build = {
                    args = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
                    executable = "latexmk",
                    onSave = false
                },
                forwardSearch = {
                    args = {},
                    onSave = false
                },
                lint = {
                    onChange = false
                },
            },
        },
    }
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
