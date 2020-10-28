if exists('g:loaded_float_terminal')
    finish
endif
let g:loaded_float_terminal = 1

let s:float_terminal_height = get(g:, float_terminal_height, 15)

command! OpenTerm call s:float_terminal_open()

let s:float_terminal_buffer = -1
let s:float_terminal_jobid = -1
let s:float_terminal_window = -1

function! s:float_terminal_open() abort
    if win_gotoid(s:float_terminal_window)
        startinsert
        return
    endif

    if bufexists(s:float_terminal_buffer)
        let buf = s:float_terminal_buffer
    else
        " create an unlisted scratch buffer
        let buf = nvim_create_buf(v:false, v:true)
    endif

    " create a window for terminal buffer
    let opts = {
                \ 'relative': 'editor',
                \ 'row': &lines - 1,
                \ 'col': 0,
                \ 'width': &columns,
                \ 'height': s:float_terminal_height,
                \ }
    call nvim_open_win(buf, 1, opts)
    let s:float_terminal_window = win_getid()

    if !bufexists(s:float_terminal_buffer)
        let s:float_terminal_jobid = termopen($SHELL, {
                    \ 'detach': 0,
                    \ 'on_exit': 'G_float_terminal_on_exit'})
        let s:float_terminal_buffer = bufnr('%')

        setl nonumber
        setl norelativenumber
        setl modifiable
        setl bufhidden=hide
        au BufEnter <buffer>
                    \ startinsert
        tnoremap <buffer> <Esc> <C-\><C-n>:close<CR>
    endif
    startinsert
endfunction

" using s:function gives error for some reason
function! G_float_terminal_on_exit(job_id, code, event) dict
    bwipeout!
endfunction
