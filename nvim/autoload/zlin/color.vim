function zlin#color#setup()
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

    " Apply color scheme
    try
        if g:has_true_color
            colorscheme ayu
        else
            colorscheme wombat256mod
        endif
    catch /^Vim\%((\a\+)\)\=:E185/
        " Color scheme not found
        echom 'Color scheme not found.'
    endtry

endfunction
