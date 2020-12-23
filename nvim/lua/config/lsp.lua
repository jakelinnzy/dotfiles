local M = {}

function M.setup()
    -- Use fzf
    require('fzf_lsp').setup()
    M.setup_lsp_servers()
    -- M.setup_completion()
end

function M.setup_completion()
    vim.api.nvim_exec([[
        augroup vimrc_completion
            au!
            au BufEnter * lua require('completion').on_attach()
        augroup END
    ]], true)
end

-- Reference:
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
function M.setup_lsp_servers()

    -- Run :LspInstall to install the respective language server

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


return M
