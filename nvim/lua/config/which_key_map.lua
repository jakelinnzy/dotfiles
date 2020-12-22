---- Setup vim-which-key and leader key mappings

local M = {}

function M.setup()
    -- Setup vim-which-key
    -- lua's table syntax is way cleaner than vimscript's
    vim.g.which_key_leader = {
        [","] = "which_key_ignore",
        ["."] = "which_key_ignore",
        [";"] = "which_key_ignore",
        [" "] = { ":Files", "Find files" },
        ["`"] = { "<C-^>", "Alt-file" },
        ["<CR>"] = "No-highlight",
        N = "which_key_ignore",
        Q = { ":silent Sayonara!", "Quit (preserve window)" },
        q = { ":silent Sayonara", "Quit" },
        S = { ":Startify", "Startify" },
        b = {
            name = "+buffer",
            d = { ":Sayonara!", "Delete buffer" },
        },
        e = {
            name = "+edit",
            f = { "<Plug>(coc-format)", "Format" },
            t = { ":call TrimTrailingWhitespace()", "Trim" }
        },
        f = {
            name = "+file/find",
            N = {
                name = "+new from clipboard",
                n = { ":Scratch | put +", "Open empty buffer from clipboard" },
                t = { ":TScratch | put +", "Open empty tab from clipboard" },
                v = { ":VScratch | put +", "Open empty vsplit from clipboard" }
            },
            c = {
                name = "+find-coc",
                c = { ":CocFzfList commands", "Coc commands" },
                l = { ":CocFzfList", "Find coc..." },
                o = { ":CocFzfList outline", "Coc outline" },
                s = { ":CocFzfList sources", "Coc sources" }
            },
            d = {
                name = "+prefix",
                h = { ":call DeleteHiddenBuffers()", "Delete hidden buffers" },
            },
            e = {
                name = "+edit",
                c = { ":CocConfig", "Edit coc_settings.json" },
                d = { ':call execute("drop ".&spellfile)', "Edit dictionary" },
                s = { ":SnipEdit", "Edit snippets" },
                t = { ":drop ~/.vim/tasks.ini", "Edit global tasks" },
                v = { ":drop ~/.vimrc", "Edit .vimrc" }
            },
            f = { ":Files", "Find files" },
            g = {},
            h = { ":Helptags", "Find help" },
            n = {
                name = "+new",
                n = { ":Scratch", "Open empty buffer" },
                t = { ":TScratch", "Open empty tab" },
                v = { ":VScratch", "Open empty vsplit" }
            },
            r = { ":FRg", "Find with rg" },
            s = { ":if &modified | silent! undojoin | w | endif", "Save buffer" },
            t = { ":NERDTreeCWD", "NERDTree" },
            y = {
                name = "+yank",
                c = "Copy file content",
                p = "Copy file path"
            }
        },
        g = {
            name = "+goto/git",
            b = { ":Buffers", "Buffers" },
            h = { ":History", "History" },
            m = { ":Marks", "Marks" },
            s = {
                t = { ":Git status", "git status" }
            }
        },
        j = "which_key_ignore",
        k = "which_key_ignore",
        l = {
            name = "+language",
            a = {
                name = "Code Action"
            },
            c = { ":CocFzfList commands", "List commands" },
            d = { ":CocFzfList diagnostics", "Diagnostics" },
            f = { "<Plug>(coc-refactor)", "Refactor" },
            g = { "<Plug>(coc-definition)", "Go to definition" },
            i = { "<Plug>(coc-implementation)", "Go to implementation" },
            r = { "<Plug>(coc-rename)", "Rename" }
        },
        n = "which_key_ignore",
        o = { ":OpenTerm", "Open terminal" },
        p = { ":Files", "Find files" },
        r = {
            name = "+run",
            b = { ":AsyncTask project-build", "Build project" },
            f = { ":AsyncTask file-run", "Run current file" },
            r = { ":AsyncTask project-run", "Run project" },
            s = { ":AsyncTaskFzf", "Select task..." },
            t = { ":AsyncTask project-test", "Test project" }
        },
        s = { ":if &modified | silent! undojoin | w | endif", "Save buffer" },
        t = {
            name = "+toggle",
            a = {
                name = "+autoformat",
                a = { ":Leadertaa", "Formatting while typing" },
                c = { ":Leadertac", "Only format comment" },
                j = { ":Leadertaj", "Join lines" },
                w = { ":AirlineToggleWhitespace", "Airline-checkWS" }
            },
            c = {
                c = { ":set cursorcolumn! | set cursorcolumn?", "cursorcolumn" },
                e = { ":ToggleConceal", "conceal" },
                l = { ":set cursorline! | set cursorline?", "cursorline" },
                name = "+cursor/coc",
                o = { ":call ToggleCoc()", "coc" },
                r = { ":ColorizerToggle", "colorizer" }
            },
            d = {
                l = { ":call ToggleDisplayLongLines()", "Display long lines" }
            },
            l = { ":set list! | set list?", "list" },
            n = { ":set number! | let &relativenumber = &number | set number?", "number" },
            p = { "<M-p>", "Auto-pairs" },
            r = {
                n = { ":set relativenumber! | set relativenumber?", "relativenumber" },
                t = { ":RooterToggleStatus", "Rooter" }
            },
            s = { ":set spell! | set spell?", "spellcheck" },
            w = { ":set wrap! | set wrap?", "wrap" }
        },
        w = {
            name = "+window",
            h = {
                name = "+height"
            },
            m = {
                name = "+move",
                h = { "<C-w>H", "move left" },
                j = { "<C-w>J", "move down" },
                k = { "<C-w>K", "move up" },
                l = { "<C-w>L", "move right" },
                o = { "<C-w>o", "maximize" },
                t = { "<C-w>T", "move to tab" },
                x = { "<C-w>x", "exchange" },
                ["="] = { "<C-w>=", "equal size" },
            },
            s = { ":split", "Split" },
            t = { ":tabnew", "VSplit" },
            v = { ":vsplit", "VSplit" },
            w = {
                name = "+width"
            }
        }
    }
end

return M
