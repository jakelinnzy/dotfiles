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
if g:has_patched_font
    Plug 'ryanoasis/vim-devicons'
endif
Plug 'liuchengxu/vim-which-key'
" Zen mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'norcalli/nvim-colorizer.lua'
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
let g:polyglot_disabled = ['markdown']
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

" For benchmark only
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }

call plug#end()
