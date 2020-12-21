" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Ziyang Lin's Neovim Configuration
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" Things to do first {{{1
if &compatible
    set nocompatible
endif
let mapleader = ' '
let maplocalleader = '\'
let s:is_mac = has('mac')
let s:is_windows = has('win32') || has('win64')
let s:is_linux = has('linux')
if s:is_mac
    let g:python3_host_prog = '/usr/local/bin/python3'
elseif s:is_linux
    let g:python3_host_prog = '/usr/bin/python3'
endif
if $TERM_PROGRAM =~# '\v(kitty|iTerm|alacritty)'
    let s:patched_font = 1
    let s:termguicolors = 1
else
    let s:patched_font = 0
    let s:termguicolors = 0
endif

source ~/.config/nvim/before.vim
" }}}
" vim-plug Setup {{{1
" I choose vim-plug because it is actively maintained and allows to backup all
" plugins inside .vimrc
" :PlugInstall to install plugins
" :PlugUpdate to update plugins
" :PlugUpgrade to update vim-plug itself

" To install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.config/plugged')

Plug 'jakelinnzy/delimitMate'    " my fork
Plug 'jakelinnzy/vim-easymotion' " my fork
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jdhao/better-escape.vim'
" auto-pairs prevents <CR> from expanding abbreviations
Plug 'junegunn/vim-easy-align'  " ga to align
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-peekaboo'    " automatically show register contents
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-fugitive'       " Git wrapper
Plug 'tpope/vim-unimpaired'     " Bracket mappings
Plug 'tpope/vim-abolish'        " cr* to change case
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'         " :SudoWrite, :Chmod, etc.
Plug 'ciaranm/detectindent'     " :DetectIndent
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-sayonara'
Plug 'airblade/vim-rooter'      " Automatically cd to project root
Plug 'godlygeek/tabular'        " Required by vim-markdown
Plug 'mbbill/undotree'
Plug 'chrisbra/unicode.vim'

" Custom Text Objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'

" Display
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if s:patched_font
    Plug 'ryanoasis/vim-devicons'
endif
Plug 'liuchengxu/vim-which-key'
" Zen mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
    " Semantic highlighting for Python, only supports neovim.
    " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
endif
if has('nvim-0.5.0')
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'iamcco/markdown-preview.nvim', {
                \ 'do': 'cd app && yarn install',
                \ 'for': ['markdown'],
                \ }
endif

" Languages
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf', { 'branch': 'release' }
Plug 'editorconfig/editorconfig-vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
" Plug 'keith/swift.vim'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/jsonc.vim'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'    " Language pack

" Color scheme
Plug 'ayu-theme/ayu-vim'
Plug 'mhinz/vim-janah'
Plug 'vim-scripts/wombat256.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nightsense/carbonized'
Plug 'zacanger/angr.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'fenetikm/falcon'
Plug 'embark-theme/vim', { 'as': 'embark' }

call plug#end()
" - END vim-plug setup }}}1

" - Basic {{{1

" Turn on file type detection & syntax highlighting.
filetype plugin indent on
syntax on

" Remove all autocommands in this file and then define them again so reloading
" this file is safe.
augroup vimrc
    au!
augroup END

set encoding=utf-8  " Set default encoding to utf-8. No effect for Neovim.

set number          " Show line numbers
set relativenumber  " Relative line numbers
set cursorline      " Displays a line below cursor
set list            " Shows tab character clearly
set listchars=tab:➤·,trail:_,nbsp:␣
set showcmd         " Shows pressed keys at status bar
set noshowmode      " The -- INSERT -- at the bottom is not needed because
                    " we have lightline
set scrolloff=5     " Set 5 lines to the cursor when moving vertically using j/k
set sidescrolloff=5 " Same for horizontal scroll
set laststatus=2    " Always show the status line at the bottom
set wrap            " Wrap text at window width. The actual file is unchanged.
set linebreak       " Wrap lines only at word breaks to improve readability. The
                    " actual file is not changed.
set breakindent     " Indent wrapped line the same amount as last line.
set hidden          " Enables hidden buffer
                    " :DH to close all saved hidden buffers (see below)
set swapfile
set clipboard=unnamedplus  " yank into system clipboard by default

" - Tab width & indentation {{{1

set tabstop=4      " display width of tab character
set shiftwidth=4   " amount of indent using < and >
set softtabstop=4
set expandtab      " insert spaces
set smarttab       " insert and delete 'shiftwidth' spaces at start of line
set autoindent     " copy the indent from last line
" smartindent is deprecated. autoindent + filetype plugin indent on is enough.
" set smartindent

" - Display {{{1

" Format the status line (not needed because of lightline)
" set statusline=\ %F%m%r%h\ %w\ \ \ \ %l:%c
set wildmenu               " Turn on the Wild menu
set pumheight=20           " Display at most 20 completion items
set shortmess=filmntToOF   " Shorten various messages, see :h 'shortmess'
set shortmess+=rxc         " Avoids hit-enter prompts

if has('nvim') && s:termguicolors
    " Make pum and floating windows pseudo-transparent
    set pumblend=15
    set winblend=15
    " Highlight yanked text
    au vimrc TextYankPost * silent!
                \ lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}
endif

" Display signcolumn (coc's diagnostics) in the number column
if has('nvim-0.5.0') || v:version > 800
    set signcolumn=number
else
    set signcolumn=no
endif

set title                  " Displays terminal title

if has('nvim') || has('gui')
    " Cursor shapes, see :h 'guicursor'
    set guicursor=n-v-c-sm:block-Cursor
                \,i-ci-ve:ver25-Cursor
                \,r-cr-o:hor20-Cursor
endif

set fillchars+=stl:\ ,stlnc:\  " fix status line

" Open new split window at bottom right
set splitbelow
set splitright

" Open help doc at the right if have enough horizontal space ( >160 )
au vimrc BufEnter *.txt
            \ if &buftype ==# 'help' && winwidth(0) > 160 |
            \     wincmd L |
            \ endif

" - Navigation & Searching {{{1

set foldmethod=marker
set foldopen+=jump
set foldopen+=search
" Enable mouse support.
set mouse+=a

set ignorecase
set smartcase       " Make search case sensitive if the query includes any upper
                    " case characters.
set hlsearch        " Highlight search results
set incsearch
if has('nvim')
    set inccommand=split " preview results of :s in a preview window
endif
set magic           " Always use magic search

" Remember position of last edit
au vimrc BufReadPost *
            \ if line("'\"") > 1 && line ("'\"") <= line ("$") && &ft !~# 'commit'
            \ | exe "normal! g'\"zv"
            \ | endif


" - Misc {{{1

" Delete comment character when joining commented lines
set formatoptions+=j

set sessionoptions-=buffers
set sessionoptions-=localoptions

" File used for spell check
set spellfile=~/.vim/spell/en.utf-8.add

" Make backspace's behaviour sensible
set backspace=indent,eol,start

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=
set report=0        " Always report the number of lines changed
set updatetime=300  " Reduce update time to enhance coc's experience

" Automatically check if file is modified outside Vim
set autoread
" au vimrc CursorHold silent! checktime

set nobackup        " Language Servers may have issue with backup
set nowritebackup

set lazyredraw      " Don't redraw while executing macros, etc.
set synmaxcol=500   " Don't highlight long lines

set timeout         " time out for key combinations e.g dd
set timeoutlen=1000
set ttimeout        " time out for key codes
set ttimeoutlen=33  " wait up to 33ms after Esc for special key

let g:is_posix = 1  " Prevent Vim from marking the $() in shell script as error

if has('nvim')
    set shada='100,<1000,s100,:1000,n~/.nvim_shada
endif

" - Color Scheme {{{1

" Use true colors in terminal
if exists("+termguicolors") && s:termguicolors
    set termguicolors
    " nvim-colorizer.lua
endif

set background=dark

" Color scheme overrides
let g:ayucolor = "mirage"
function! s:ayu_mirage()
    hi Cursor        gui=NONE guifg=#212733 guibg=#FFD580
    hi lCursor       gui=NONE guifg=#212733 guibg=#FFD580
    hi Comment       guifg=#7C8793
    hi CursorLine    guibg=#303844
    hi IncSearch     gui=NONE guifg=#212733 guibg=#D9D7CE
    hi MatchParen    gui=NONE guifg=#212733 guibg=#7C8793
    hi VertSplit     guifg=#303844 guibg=#303844
    hi LineNr        guifg=#5C6773
    hi Identifier    guifg=#80D4FF
    hi Operator      guifg=#F29E74
    hi NonText       guifg=#506070

    hi! link SpecialKey   NonText
    hi! link startifyHeader Function
    hi CocHighlightText    guibg=#4C5763
    hi! link semshiSelected CocHighlightText
endfunction
au vimrc ColorScheme ayu call s:ayu_mirage()

function! s:seoul256()
    " Seoul256 (dark): 233~239 default:237
    let g:seoul256_background = 234
    let g:seoul256_srgb = 1
    colorscheme seoul256

    hi CursorLine    ctermbg=236 guibg=#303030
    hi CursorColumn  ctermbg=236 guibg=#303030
    hi CursorLineNr  ctermbg=236 guibg=#303030
endfunction
au vimrc ColorScheme seoul256 call s:seoul256()

function! s:semshi_overrides()
    hi semshiAttribute guifg=#3CAEA3
    hi semshiImported guifg=#C47B62
    hi semshiParameter       ctermfg=75  guifg=#D4BFFF
    hi link semshiBuiltin Identifier

    " Semshi defaults
    " hi semshiLocal           ctermfg=209 guifg=#ff875f
    " hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    " hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
    " hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    " hi semshiFree            ctermfg=218 guifg=#ffafd7
    " hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
    " hi semshiAttribute       ctermfg=49  guifg=#00ffaf
    " hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    " hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    " hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f
    " hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    " hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    " sign define semshiError text=E> texthl=semshiErrorSign
endfunction
" au vimrc ColorScheme * call s:semshi_overrides()

" Apply color scheme
try
    if s:termguicolors
        colorscheme ayu
    else
        colorscheme wombat256mod
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    " Color scheme not found
    echom 'Color scheme not found.'
endtry

if has('nvim') && s:termguicolors
    lua require'colorizer'.setup()
endif

" Highlight common operators in most languages {{{2
function! s:syn_operator()
    syntax match Operator "\V+"
    syntax match Operator "\V-"
    " be careful with C comments
    syntax match Operator "\v[^/]\zs\*{1,2}\ze[^/]"
    syntax match Operator "\v[^/*]\zs/\ze[^/*]"
    syntax match Operator "\V%"
    syntax match Operator "\V="
    syntax match Operator "\V+="
    syntax match Operator "\V-="
    syntax match Operator "\V*="
    syntax match Operator "\V/="
    syntax match Operator "\V%="

    syntax match Operator "\V++"
    syntax match Operator "\V--"

    syntax match Operator "\V:="
    syntax match Operator "\V=="
    syntax match Operator "\V==="
    syntax match Operator "\V!="
    syntax match Operator "\V!=="
    syntax match Operator "\V>"
    syntax match Operator "\V<"
    syntax match Operator "\V>="
    syntax match Operator "\V<="

    syntax match Operator "\V~"
    syntax match Operator "\V<<"
    syntax match Operator "\V>>"
    syntax match Operator "\V&"
    syntax match Operator "\V|"
    syntax match Operator "\V^"

    syntax match Operator "\V~="
    syntax match Operator "\V>>="
    syntax match Operator "\V<<="
    syntax match Operator "\V&="
    syntax match Operator "\V|="
    syntax match Operator "\V^="

    syntax match Operator "\V!"
    syntax match Operator "\V&&"
    syntax match Operator "\V||"

    if &ft ==# 'python'
        syntax match Operator "\V//"
    else
        syntax match Operator "\V:"
    endif


    syntax match Operator "\V?"
    syntax match Operator "\V??"
endfunction


au Syntax c,cpp,python,java,rust,go,javascript,typescript,ruby,swift,
            \kotlin,scala
            \ call s:syn_operator()

" END Operators }}}

" }}}1

" Mappings & Commands {{{1

" <Leader> had been set to <Space> at the top of this file

" There's no *escape* {{{2

" Press jk to leave insert mode
" inoremap jk <Esc>
" :h better-escape.txt
let g:better_escape_interval = 150
let g:better_escape_shortcut = 'jk'

" <Esc> to exit terminal mode
" fzf.vim can interfere with this, so check first
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>"
" tnoremap <expr> jk (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>"


" More sensible defaults {{{2

" 'Q' in normal mode enters Ex mode. You almost never want this.
nnoremap Q <Nop>
map <Space> <Nop>

" `s` deletes one character and enters insert mode
" Why use it if you have xi and r?
nnoremap s <Nop>
" S is a synonym for cc (change the current line)
nnoremap S <Nop>

" Make Y consistent with C and D
nnoremap Y y$

" ^U Insert Mode breaks undo sequence
inoremap <C-u> <C-g>u<C-u>

" n always search forward and N always backward
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" j and k move visual lines instead of real lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Movements {{{2

" Jump to start and end of line using the home row keys
noremap H ^
noremap L $

" Scroll with , and m
noremap , <C-u>
noremap m <C-d>
" Move the mark key to M
noremap M m

" Use Emacs movement keybindings in insert mode
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <C-o>gk
inoremap <C-n> <C-o>gj
inoremap <M-f> <S-Right>
inoremap <M-b> <S-Left>

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Ctrl-a and Ctrl-e
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" <M-n> to move between pairs
inoremap <M-n> <C-o>%
" <M-o> and <M-Shift-o> adds new line below and above
inoremap <M-o> <C-o>o
inoremap <M-O> <C-o>O

" Manage windows {{{2

" Goto - Buffer
nnoremap <silent> gb :<C-u>Buffers<CR>

" Better way to move between windows
noremap <M-h> <C-W>h
noremap <M-j> <C-W>j
noremap <M-k> <C-W>k
noremap <M-l> <C-W>l

inoremap <M-h> <Esc><C-W>h
inoremap <M-j> <Esc><C-W>j
inoremap <M-k> <Esc><C-W>k
inoremap <M-l> <Esc><C-W>l

tnoremap <M-h> <C-\><C-n><C-W>h
tnoremap <M-j> <C-\><C-n><C-W>j
tnoremap <M-k> <C-\><C-n><C-W>k
tnoremap <M-l> <C-\><C-n><C-W>l

" Resize windows using Alt+Shift
nnoremap <M-H> :vertical resize -2<CR>
nnoremap <M-J> :resize -2<CR>
nnoremap <M-K> :resize +2<CR>
nnoremap <M-L> :vertical resize +2<CR>

" Ctrl-W t to move window to a new tab
nnoremap <C-w>t <C-w>T

" Nvim Terminal {{{2
if has('nvim')
    let g:float_terminal_height = 15
endif

" Visual Mode {{{2

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" <Leader> {{{2

let g:which_key_leader = {
            \ 'q': [ ':silent Sayonara', 'Quit' ],
            \ 'Q': [ ':silent Sayonara!', 'Quit (preserve window)' ],
            \ 'f': { 'name': '+file/find',
            \        'e': { 'name': '+edit',
            \               'v': [':drop ~/.vimrc', 'Edit .vimrc'],
            \               'c': [':CocConfig', 'Edit coc_settings.json'],
            \               't': [':drop ~/.vim/tasks.ini', 'Edit global tasks'],
            \               'd': [':call execute("drop ".&spellfile)', 'Edit dictionary'],
            \               's': [':SnipEdit', 'Edit snippets'] },
            \        's': [ ':if &modified | silent! undojoin | w | endif', 'Save buffer' ],
            \        'n': { 'name': '+new',
            \               'n': [':Scratch', 'Open empty buffer'],
            \               't': [':TScratch', 'Open empty tab'],
            \               'v': [':VScratch', 'Open empty vsplit'], },
            \        'N': { 'name': '+new from clipboard',
            \               'n': [':Scratch | put +', 'Open empty buffer from clipboard'],
            \               't': [':TScratch | put +', 'Open empty tab from clipboard'],
            \               'v': [':VScratch | put +', 'Open empty vsplit from clipboard']},
            \        'y': { 'name': '+yank',
            \               'c': 'Copy file content',
            \               'p': 'Copy file path'},
            \        'd': { 'name': '+prefix',
            \               'h': [':call DeleteHiddenBuffers()',
            \                     'Delete hidden buffers']},
            \        't': [ ':NERDTreeCWD', 'NERDTree' ],
            \        'g': {},
            \        'r': [ ':FRg', 'Find with rg' ],
            \        'f': [ ':Files', 'Find files' ],
            \        'h': [ ':Helptags', 'Find help' ],
            \        'c': { 'name': '+find-coc',
            \               'l': [ ':CocFzfList', 'Find coc...' ],
            \               'c': [ ':CocFzfList commands', 'Coc commands' ],
            \               'o': [ ':CocFzfList outline', 'Coc outline' ],
            \               's': [ ':CocFzfList sources', 'Coc sources' ]},
            \ },
            \ 'b': { 'name': '+buffer',
            \        'd': [ ':Sayonara!', 'Delete buffer' ],
            \ },
            \ 'r': { 'name': '+run',
            \        's': [ ':AsyncTaskFzf', 'Select task...' ],
            \        'b': [ ':AsyncTask project-build', 'Build project' ],
            \        'r': [ ':AsyncTask project-run', 'Run project' ],
            \        't': [ ':AsyncTask project-test', 'Test project' ],
            \        'f': [ ':AsyncTask file-run', 'Run current file' ]},
            \ 'e': { 'name': '+edit',
            \        't': [ ':call TrimTrailingWhitespace()', 'Trim' ],
            \        'f': [ '<Plug>(coc-format)', 'Format' ],
            \ },
            \ 'g': { 'name': '+goto/git',
            \        'h': [ ':History', 'History' ],
            \        'b': [ ':Buffers', 'Buffers' ],
            \        'm': [ ':Marks', 'Marks' ],
            \        's': { 't': [':Git status', 'git status']} },
            \ 'l': { 'name': '+language',
            \        'a': { 'name': 'Code Action' },
            \        'c': [ ':CocFzfList commands', 'List commands' ],
            \        'r': [ '<Plug>(coc-rename)', 'Rename' ],
            \        'f': [ '<Plug>(coc-refactor)', 'Refactor' ],
            \        'g': [ '<Plug>(coc-definition)', 'Go to definition' ],
            \        'i': [ '<Plug>(coc-implementation)', 'Go to implementation' ],
            \        'd': [ ':CocFzfList diagnostics', 'Diagnostics' ],
            \ },
            \ 't': { 'name': '+toggle',
            \        'a': { 'name': '+autoformat',
            \               'a': [ ':Leadertaa', 'Formatting while typing' ],
            \               'j': [ ':Leadertaj', 'Join lines' ],
            \               'c': [ ':Leadertac', 'Only format comment' ],
            \               'w': [ ':AirlineToggleWhitespace', 'Airline-checkWS'],
            \ },
            \        'w': [':set wrap! | set wrap?', 'wrap'],
            \        'l': [':set list! | set list?', 'list'],
            \        's': [':set spell! | set spell?', 'spellcheck'],
            \        'n': [':set number! | let &relativenumber = &number | set number?',
            \              'number'],
            \        'r': { 'n': [':set relativenumber! | set relativenumber?',
            \                     'relativenumber'],
            \               't': [':RooterToggleStatus', 'Rooter'] },
            \        'd': { 'l': [':call ToggleDisplayLongLines()', 'Display long lines'] },
            \        'c': { 'name': '+cursor/coc',
            \               'o': [':call ToggleCoc()', 'coc'],
            \               'l': [':set cursorline! | set cursorline?', 'cursorline'],
            \               'c': [':set cursorcolumn! | set cursorcolumn?', 'cursorcolumn'],
            \               'r': [':ColorizerToggle', 'colorizer'],
            \               'e': [':ToggleConceal', 'conceal']},
            \         'p': [ '<M-p>', 'Auto-pairs' ]},
            \ 'w': { 'name': '+window',
            \        'm': { 'name': '+move',
            \               'h': [ '<C-w>H', 'move left' ],
            \               'j': [ '<C-w>J', 'move down' ],
            \               'k': [ '<C-w>K', 'move up' ],
            \               'l': [ '<C-w>L', 'move right' ],
            \               't': [ '<C-w>T', 'move to tab' ],
            \               'o': [ '<C-w>o', 'maximize' ],
            \               'x': [ '<C-w>x', 'exchange' ],
            \               '=': [ '<C-w>=', 'equal size' ], },
            \        'w': { 'name': '+width' },
            \        'h': { 'name': '+height' },
            \        's': [ ':split', 'Split' ],
            \        'v': [ ':vsplit', 'VSplit' ],
            \        't': [ ':tabnew', 'VSplit' ],
            \ },
            \ 's': [':if &modified | silent! undojoin | w | endif', 'Save buffer'],
            \ 'p': [':Files', 'Find files'],
            \ 'S': [':Startify', 'Startify'],
            \ '`': ['<C-^>', 'Alt-file'],
            \ '<CR>': 'No-highlight',
            \ 'j': 'which_key_ignore',
            \ 'k': 'which_key_ignore',
            \ 'n': 'which_key_ignore',
            \ 'N': 'which_key_ignore',
            \ ',': 'which_key_ignore',
            \ ';': 'which_key_ignore',
            \ '.': 'which_key_ignore',
            \ }

if has('nvim')
    let g:which_key_leader.o = [':OpenTerm', 'Open terminal']
endif
nnoremap <silent> <Leader><CR> :nohlsearch<CR>
" File - Yank - Content (copy the whole file to system clipboard)
nnoremap <silent> <Leader>fyc gg"+yG<C-o>:<C-u>echom "Copied to clipboard"<CR>
" File - Yank - Path (copy the full path to system clipboard)
nnoremap <silent> <Leader>fyp :<C-u>let @+ = expand("%:p") <Bar>
            \ echom "Copied "..@+.." to clipboard"<CR>

" Edit
vmap <Leader>ef <Plug>(coc-format-selected)

" Language - Action
"     Example: `<Leader>aap` for current paragraph
xmap <Leader>la   <Plug>(coc-codeaction-selected)
"     for the current line
nmap <Leader>lac  <Plug>(coc-codeaction)

" \rl to save and reload vimrc
augroup vimrc
    au BufRead *vimrc nnoremap <buffer><nowait><silent> <LocalLeader>rl
                      \ :silent w <Bar> source ~/.vimrc <Bar> nohl <BAR>
                      \ echom "Saved & reloaded .vimrc"<CR>
augroup END

" Commands {{{2

" Allow saving of files as sudo when forgot to start vim using sudo
command! SUWrite execute 'write !sudo tee % >/dev/null' <bar> edit!

" :Reload reloads vimrc
command! Reload source $MYVIMRC | nohl
" :DH closes all the hidden and unmodified buffers
command! DH call DeleteHiddenBuffers()

" Open a new buffer to test highlight
command! HiTest source $VIMRUNTIME/syntax/hitest.vim

" :Scratch to open a scratch buffer that can be discarded at any time
command! MakeScratch setlocal nobuflisted buftype=nofile bufhidden=delete noswapfile
command! Scratch <mods>new +MakeScratch
command! VScratch vnew +MakeScratch
command! TScratch tabnew +MakeScratch


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis

" Toggle settings, etc. Used by which-key
command! Leadertaa call
            \ ToggleSetFlag
            \ ('formatoptions', 'a',
            \ 'Enabled formatting while typing.',
            \ 'Disabled formatting while typing.'
            \ )
command! Leadertaj call ToggleSetFlag('formatoptions', 'w',
            \ 'Enabled "gq" joining lines.', 'Disabled "gq" joining lines.')
command! Leadertac call ToggleSetFlag('formatoptions', 't',
            \ 'Format both comment and code', 'Only format comment.')

command! ToggleConceal
            \ let &conceallevel = (&conceallevel == 0) ? 2 : 0 |
            \ set conceallevel?

function! ToggleDisplayLongLines()
    if exists('w:long_line_match')
        silent! call matchdelete(w:long_line_match)
        unlet w:long_line_match
        echom "Disabled highlighting long lines."
    elseif &textwidth > 0
        let w:long_line_match = matchadd('ErrorMsg','\%>'.&tw.'v.\+',-1)
        echom "Highlighting lines longer than "..&tw.." characters."
    else
        let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1)
        echom "Highlighting lines longer than 80 characters. (default)"
    endif
endfunction

" Toggle a flag in an option
" e.g. 'formatoptions'
" :call ToggleSetFlag('formatoptions', 'a', 'Auto-formatting')
" echoes 'Auto-formatting Enabled.' / 'Auto-formatting Disabled.'
function! ToggleSetFlag(option, flag, pos_description, neg_description) abort
    if stridx(execute('echo &'..a:option), a:flag) == -1
        execute 'set '..a:option..'+='..a:flag
        echom a:pos_description
    else
        execute 'set '..a:option..'-='..a:flag
        echom a:neg_description
    endif
endfunction

function! ToggleCoc() abort
    if get(g:, 'coc_enabled', 0) == 1
        CocDisable
    else
        CocEnable
    endif
endfunction

" }}}

" END Commands }}}2

" Abbreviations {{{1

" date= to insert current date; time= to insert date and time
iabbrev <expr> date= strftime('%d-%b-%Y')
iabbrev <expr> time= strftime('%c')

" mail and signature
iabbrev @@m jakelinnzy@gmail.com
iabbrev @@s ---<CR>Ziyang Lin<CR>jakelinnzy@gmail.com

augroup vimrc
    au FileType c,cpp iabbrev <buffer> i32 int32_t
    au FileType c,cpp iabbrev <buffer> i64 int64_t
    " Quickly insert JavaDoc-style comments
    au FileType c,cpp,java  iabbrev <buffer> /** /**<CR><CR>/<Up>

    " shebang
    au FileType python  iabbrev <buffer> #! #!/usr/bin/env python3
    au FileType sh,bash iabbrev <buffer> #! #!/bin/bash

augroup END


" Add command abbreviation that would not expand unless at beginning of a line
" and is typing a command (not search), preventing unexpected expansion.
function! AddCommandAbbr(abbr, expansion)
    execute 'cabbrev '..a:abbr..
                \ ' <C-r>=(getcmdpos() == 1 && getcmdtype() == ":") ? "'..
                \ a:expansion..'" : "'..a:abbr..'"<CR>'
endfunction

" Git commands
call AddCommandAbbr("gst" , "Git status")
call AddCommandAbbr("gc"  , "Git commit")
call AddCommandAbbr("gca" , "Git commit -a")
call AddCommandAbbr("gco" , "Git checkout")
call AddCommandAbbr("gd"  , "Git diff")
call AddCommandAbbr("glg" , "Git log --graph --decorate --oneline")
call AddCommandAbbr("gsta", "Git stash")

" }}}

" Plugin settings {{{1

" - airline {{{2

let g:airline_theme = 'ayu_mirage_custom'

let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline_inactive_collapse = 1
" Fix red triangle at the bottom right
let g:airline_skip_empty_sections = 1
" Don't draw airline for preview windows
let g:airline_exclude_preview = 1
" Improve performance
let g:airline_highlighting_cache = 0

" The text to show in different modes
let g:airline_mode_map = {
            \ '__'     : '-',
            \ 'c'      : 'CMD',
            \ 'i'      : 'INS',
            \ 'ic'     : 'INS',
            \ 'ix'     : 'INS',
            \ 'n'      : 'NOR',
            \ 'multi'  : 'MUL',
            \ 'ni'     : 'NOR',
            \ 'no'     : 'NOR',
            \ 'R'      : 'REP',
            \ 'Rv'     : 'V-REP',
            \ 's'      : 'SEL',
            \ 'S'      : 'SEL',
            \ ''     : 'SEL',
            \ 't'      : 'TERM',
            \ 'v'      : 'VISUAL',
            \ 'V'      : 'V-LINE',
            \ ''     : 'V-BLOCK',
            \ }

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
if s:patched_font
    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
else
    " unicode symbols
    " let g:airline_left_sep = ' »'
    " let g:airline_left_sep = '▶'
    let g:airline_left_sep = ''
    " let g:airline_right_sep = '« '
    " let g:airline_right_sep = '◀'
    let g:airline_right_sep = ''
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
endif

let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.linenr = '☰ '
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty='✗'

" Customize the modified indicator
function! AirlineInit()
    let g:airline_section_c =
                \ airline#section#create(['%<', '%f',
                \ '%{&modified ? " 🔮" : ""}', ' ', 'readonly'])
    let g:airline_section_x =
                \ airline#section#create(['%{&filetype}'])
endfunction
au vimrc User AirlineAfterInit call AirlineInit()

let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 5,
            \ 'y': 88,
            \ 'z': 45,
            \ 'warning': 80,
            \ 'error': 80,
            \ }

let g:airline_extensions = [
            \ 'branch', 'tabline', 'fzf', 'term', 'coc',
            \ 'undotree', 'vimtex', 'whitespace'
            \ ]

" coc
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = 'E:'
let g:airline#extensions#coc#warning_symbol = 'W:'

" tab bar
let g:airline#extensions#tabline#left_sep = g:airline_left_sep
let g:airline#extensions#tabline#right_sep = g:airline_right_sep
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
" don't show tab bar if there is only one tab
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1 " display tab number
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 1

" branch
let g:airline#extensions#branch#empty_message = ''
" truncate display long branch names
let g:airline#extensions#branch#displayed_head_limit = 10

" whitespace
let g:airline#extensions#whitespace#enabled = 1
" disable the mixed-indent-file check
let g:airline#extensions#whitespace#checks =
            \ [ 'indent', 'trailing', 'long', 'conflicts' ]
let airline#extensions#c_like_langs =
            \ ['arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php']

au vimrc FileType gitcommit call airline#extensions#whitespace#disable()


" - asynctasks.vim {{{2

let g:asyncrun_open = 6    " height of quickfix window
let g:asynctasks_term_pos = 'bottom' " 'tab' for open terminal in new tab
let g:asynctasks_term_reuse = 1
let g:asynctasks_profile = 'debug'
let g:asynctasks_term_rows = 15

" FZF integration
function! s:asynctasks_fzf_sink(what)
    let p1 = stridx(a:what, '<')
    if p1 >= 0
        let name = strpart(a:what, 0, p1)
        let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
        if name != ''
            exec "AsyncTask ". fnameescape(name)
        endif
    endif
endfunction

function! s:asynctasks_fzf()
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    let opts = { 'source': source, 'sink': function('s:asynctasks_fzf_sink'),
                \ 'options': '+m --nth 1 --inline-info --tac' }
    if exists('g:fzf_layout')
        for key in keys(g:fzf_layout)
            let opts[key] = deepcopy(g:fzf_layout[key])
        endfor
    endif
    call fzf#run(opts)
endfunction

command! -nargs=0 AsyncTaskFzf call s:asynctasks_fzf()


" - coc.nvim {{{2
" ---------------------------

" Config file at ~/.vim/coc-settings.json
let g:coc_config_home = '~/.vim'

" These coc extensions will be automatically installed
" After changing this list, reload vimrc and run :CocRestart
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-lists',
            \ 'coc-clangd',
            \ 'coc-java',
            \ 'coc-html',
            \ 'coc-emmet',
            \ 'coc-tsserver',
            \ 'coc-css',
            \ 'coc-json',
            \ 'coc-yaml',
            \ 'coc-toml',
            \ 'coc-python',
            \ 'coc-vimtex',
            \ 'coc-vimlsp',
            \ 'coc-emoji',
            \ 'coc-prettier',
            \ ]

" Option+Space triggers completion.
inoremap <silent><expr> <M-Space> coc#refresh()

" Use <tab> to select and accept the first completion item
inoremap <silent><expr> <tab>
            \ pumvisible() ? coc#_select_confirm()
            \ : "\<tab>"

" Use K to show documentation in preview window.
nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

" Use Ctrl-P and Ctrl-N to scroll the popup window
if has('nvim-0.4.3')
    nnoremap <nowait><expr> <C-p> coc#float#has_scroll() ?
                \ coc#float#scroll(0) : '<C-p>'
    nnoremap <nowait><expr> <C-n> coc#float#has_scroll() ?
                \ coc#float#scroll(1) : '<C-n>'
endif

" Custom text objects provided by coc (:h text-objects)
" if / af to select a function
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
" ic / ac to select a class
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Configure Snippets
command! SnipEdit     :CocCommand snippets.editSnippets
command! SnipFiles    :CocCommand snippets.openSnippetFiles

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

" If coc is not installed (typically on a new system), don't load autocommands
" to prevent error
augroup vimrc
    " Force lightline to update when Coc status changes
    " au User CocStatusChange,CosDiagnosticChange call lightline#update()
    " Highlight symbol under cursor
    au CursorHold * silent! call CocActionAsync('highlight')
augroup END


" - delimitMate {{{2

" Allow triple quotes '''|'''
let g:delimitMate_nesting_quotes = ['"', "'", "`"]

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
" jump over spaces / newlines
let g:delimitMate_jump_expansion = 1
" try to make parentheses match (
let g:delimitMate_balance_matchpairs = 1

noremap <silent> <M-p> :DelimitMateSwitch<CR>
inoremap <silent> <M-p> <Esc>:DelimitMateSwitch<CR>

augroup vimrc
    " Don't auto-close double quote in vimscript
    au FileType vim let b:delimitMate_quotes = "'"
augroup END


" - easy-align {{{2

" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)


" - easymotion {{{2

" The key at the back (;) will be used to start a pair
let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm;'
let g:EasyMotion_smartcase = 1

" Changes the default binding from <Leader><Leader> to <Leader>
" map <Leader> <Plug>(easymotion-prefix)
" Bind common keys instead to prevent accidental <Leader> shortcuts
let g:EasyMotion_do_mapping = 0

" Find characters with easymotion so we don't need ; and ,
map f <Plug>(easymotion-bd-f)
map t <Plug>(easymotion-bd-t)

" s to search for 2 chars
map s <Plug>(easymotion-bd-f2)

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" map <Leader>w <Plug>(easymotion-bd-w)
" map <Leader>W <Plug>(easymotion-bd-W)
" map <Leader>e <Plug>(easymotion-bd-e)
" map <Leader>E <Plug>(easymotion-bd-E)

" n always forward and N always backward, same as our customisation
map <Leader>n <Plug>(easymotion-n)
map <Leader>N <Plug>(easymotion-N)

map <Leader>; <Plug>(easymotion-next)
map <Leader>, <Plug>(easymotion-prev)
map <Leader>. <Plug>(easymotion-repeat)

" Enter and space jumps to first match
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade Comment

" EasyMotion can confuse coc.nvim because it changes the text in buffer
" This is a workaround
augroup vimrc
    au User EasyMotionPromptBegin silent! CocDisable
    au User EasyMotionPromptEnd   silent! CocEnable
    " au TextChanged,CursorMoved * call s:fix_easymotion_coc()
augroup END


" - editorconfig {{{2

" Only highlight the lines that exceed length limit
let g:EditorConfig_max_line_indicator = "exceeding"

" - FZF.vim {{{2

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

let g:fzf_colors = {
          \ 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', 'Normal'],
          \ 'hl':      ['fg', 'Comment'],
          \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
          \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          \ 'hl+':     ['fg', 'Statement'],
          \ 'info':    ['fg', 'PreProc'],
          \ 'border':  ['fg', 'Ignore'],
          \ 'prompt':  ['fg', 'Conditional'],
          \ 'pointer': ['fg', 'Exception'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Comment']
          \ }

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-l> <Plug>(fzf-complete-line)

command! -bang -nargs=* FRg call fzf#vim#grep("rg --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 0)

" - goyo & limelight {{{2

" :Focus to toggle both commands
command! Focus Goyo | Limelight!!

" - NERDTree {{{2

" C-t toggles NERDTree
map <silent> <C-t> :<C-u>NERDTreeToggle<CR>
" Removes the Press ? for help line at the top
let g:NERDTreeMinimalUI = 1
" Shows hidden files
let g:NERDTreeShowHidden = 1
" sort numbers naturally
let g:NERDTreeNaturalSort = 1
" when deleting a file, also delete the buffer of the file
let g:NERDTreeAutoDeleteBuffer = 1

" Mappings
" s to split and v to vsplit
let g:NERDTreeMapPreview = "i"
let g:NERDTreeMapOpenSplit = "s"
let g:NERDTreeMapPreviewSplit = "gs"
let g:NERDTreeMapOpenVSplit = "v"
let g:NERDTreeMapPreviewVSplit = "gv"

let g:NERDTreeMapMenu = "a"
let g:NERDTreeMapChangeRoot = "cd"
" list of ignore files
let g:NERDTreeIgnore = ['\.DS_Store', 'Icon']

let g:NERDTreeGitStatusConcealBrackets = 1 " don't show angle brackets
let g:NERDTreeGitStatusShowIgnored = 1     " show ignored files
let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ 'Modified'  :'※',
            \ 'Staged'    :'✚',
            \ 'Untracked' :'¿',
            \ 'Renamed'   :'➜',
            \ 'Unmerged'  :'═',
            \ 'Deleted'   :'✖',
            \ 'Dirty'     :'✗',
            \ 'Ignored'   :'¶',
            \ 'Clean'     :'✔︎',
            \ 'Unknown'   :'?',
            \ }

augroup vimrc
    au FileType nerdtree noremap <buffer> <space>q :q<CR>
    au FileType nerdtree hi NERDTreeGitStatusIgnored guifg=#708090
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END


" - rooter  {{{2

" Patterns to identify a root directory
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile',
            \ '.project', '=playground', '.root', '.vim_root']

let g:rooter_manual_only = 0
let g:rooter_silent_chdir = 0
let g:rooter_resolve_links = 1
let g:rooter_cd_cmd = 'cd'

command! -nargs=0 RooterToggleStatus RooterToggle |
            \ echom g:rooter_manual_only ? "Rooter Disabled." : "Rooter Enabled."

nnoremap <M-r> :<C-u>RooterToggleStatus<CR>


" - Sayonara {{{2

" Confirm if going to close the last active buffer
let g:sayonara_confirm_quit = 0

let g:sayonara_filetypes = {
            \ 'nerdtree': 'NERDTreeClose',
            \ }



" - startify {{{2


function! s:nerdtreeBookmarks()
    let bookmarks = systemlist("cut -d' ' -f 2 ~/.NERDTreeBookmarks")
    let bookmarks = bookmarks[0:-2] " Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
            \ { 'type': 'files',     'header' : [ '    Files' ] },
            \ { 'type': 'dir',       'header' :
            \              [ '    Current Directory: '..getcwd() ] },
            \ { 'type': 'sessions',  'header' : [ '    Sessions' ] },
            \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']}
            \ ]

" Automatically update sessions
let g:startify_session_persistence = 1
" Don't save local states to session.
let g:startify_session_remove_lines = ['setlocal', 'winheight']
" Sort sessions by modification time
let g:startify_session_sort = 1
let g:startify_files_number = 5
let g:startify_session_number = 9
let g:startify_change_to_dir = 0       " let rooter do this
let g:startify_change_to_vcs_root = 0
let g:startify_fortune_use_unicode = 1 " Use Unicode characters

let s:startify_ascii_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \]
let g:startify_custom_header = map(s:startify_ascii_header +
            \ startify#fortune#boxed(), { k, v -> "        " .. v })

au vimrc FileType startify setl nowrap

" :SS tries to reload last session
command! SS SLoad!


" - Tabular {{{2

" Provide custom patterns here
" Use with :Tabular asterisk
"          :Tabular remove_leading_spaces
function! MyTabularCommands() abort
    if exists(':Tabularize')
        AddTabularPattern! asterisk /*/l1
        AddTabularPipeline! remove_leading_spaces /^ / map(a:lines, "substitute(v:val, '^ *', '', '')")
    endif
endfunction

au vimrc VimEnter * call MyTabularCommands()


" - textobj-user {{{2


" - undotree {{{2

let g:undotree_WindowLayout = 3
let g:undotree_ShortIndicators = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HelpLine = 0
nnoremap <silent> U :<C-u>UndotreeToggle<CR>

function! g:Undotree_CustomMap()
    nmap <buffer> p <Plug>UndotreePreviousState
    nmap <buffer> n <Plug>UndotreeNextState
endfunction

if has('persistent_undo')
    set undodir=$HOME/.undodir
    set undofile

    augroup vimrc
        au BufWritePre /tmp/* setlocal noundofile
        au FileType gitcommit setlocal noundofile
    augroup END
endif

" - Unicode {{{2

noremap <silent> ga :<C-u>UnicodeName<CR>


" - vim-emoji {{{2

" :Emoji to replace :emoji_name: into emojis
" Default to current line, :%Emoji to replace the whole file
command! -range Emoji <line1>,<line2>
            \ s/:\(\w\{-}\):/\=emoji#for(submatch(1),submatch(0))/eg |
            \ nohl


" - vim-which-key {{{2


let g:which_key_exit = ["\<C-[>", "\<Esc>", "\<C-c>"]
let g:which_key_use_floating_win = 1
let g:which_key_sep = '→'
let g:which_key_display_names = {
            \ ' ': 'SPC',
            \ '<SPACE>': 'SPC',
            \ '<Space>': 'SPC',
            \ '<TAB>': 'TAB',
            \ }
let g:which_key_flatten = 1            " Try to flatten

call which_key#register(' ', 'g:which_key_leader')

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>


" }}}

" - vim-polyglot {{{2
let g:polyglor_disabled = ['markdown']


" - vim-markdown {{{2

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

augroup vimrc
    au FileType markdown nmap <LocalLeader>r <Plug>MarkdownPreviewToggle
augroup END


" - vimtex {{{2

let g:tex_flavor = 'latex'

let g:vimtex_compiler_method = "latexmk"

" If using latexmk, make sure to call XeLaTeX to support CJK
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 0,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}

let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \ 'pdflatex'         : '-pdf',
            \ 'dvipdfex'         : '-pdfdvi',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}

nnoremap <silent> <LocalLeader>lt
            \ :call vimtex#fzf#run('ctli', g:fzf_layout)<CR>

" - nvim-treesitter {{{2

if has('nvim-0.5.0')
lua <<EOF

local blackList = { "bash", "zsh", "rust" }
require'nvim-treesitter.configs'.setup {
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
EOF
endif

" - semshi {{{2

" List of highlight groups not to highlight.
" Choose from local, unresolved, attribute, builtin, free, global, parameter,
" parameterUnused, self, imported.
let g:semshi#excluded_hl_groups = ['local']


" }}}2

" END Plugin settings }}}1

" File type settings {{{1

augroup vimrc

    " file type associations
    " *.h is a C file
    au BufRead,BufNewFile,BufWritePost *.c,*.h set filetype=c
    " AsyncTask uses ini config file
    au BufRead,BufNewFile,BufWritePost .tasks  set filetype=dosini
    au BufRead,BufNewFile,BufWritePost *.cls  set filetype=tex

    " comment with // instead of /* */ for C-like languages
    au FileType c,cpp,jsonc setlocal commentstring=//\ %s

    " makefile
    " Makefile requires to indent with tabs
    au FileType make     setlocal noexpandtab

    " Markdown
    " au FileType markdown setlocal conceallevel=2
    au FileType markdown setlocal foldlevel=999
    au FileType markdown setlocal textwidth=80

    " Python
    " \i to set coc-python's interpreter
    au FileType python   map <buffer><silent> <LocalLeader>i
                \ :CocCommand python.setInterpreter<CR>
    au FileType python   map <buffer><silent> <LocalLeader>l
                \ :CocCommand python.enableLinting<CR>

    " Rust
    au FileType rust setlocal textwidth=99
augroup END

" END File type settings }}}1

" Helper functions {{{1

" Not needed because my fork of EasyMotion executes autocommand at activation
" and deactivation

" let s:easymotion_is_active = 0
" function! s:fix_easymotion_coc()
"     if EasyMotion#is_active()
"         let s:easymotion_is_active = 1
"         silent! CocDisable
"     else
"         if s:easymotion_is_active == 1
"             let s:easymotion_is_active = 0
"             silent! CocEnable
"         endif
"     endif
" endfunction

function! DeleteHiddenBuffers() abort
    let l:open_buffers = []
    let l:num_closed = 0

    for i in range(tabpagenr('$'))
        call extend(l:open_buffers, tabpagebuflist(i + 1))
    endfor

    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(l:open_buffers, num) == -1
            silent exec "bdelete ".num
            let l:num_closed += 1
        endif
    endfor
    echom "Closed "..l:num_closed.." buffers."
endfunction

function! TrimTrailingWhitespace() abort
    let l:last_search = @/
    let l:save_view   = winsaveview()
    " Remove trailing spaces
    silent %s/\s\+$//e
    " Remove newlines at end of file
    silent %s/\($\n\s*\)\+\%$//ge
    nohl " Disable search highlight
    let @/ = l:last_search
    call winrestview(l:save_view)
    echom "Removed trailing spaces & newlines."
endfunction

" }}}1

" Done. {{{1
source ~/.config/nvim/after.vim

" vim:et:sw=4:ts=4:tw=0:foldmethod=marker
