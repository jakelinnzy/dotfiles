if has('mac')
    let g:python3_host_prog = '/usr/local/bin/python3'
elseif has('linux')
    let g:python3_host_prog = '/usr/bin/python3'
endif

" Use vim's runtimepath & vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
