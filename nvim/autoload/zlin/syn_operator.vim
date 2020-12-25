function zlin#syn_operator#setup()

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


    au Syntax c,cpp,python,java,rust,go,javascript,typescript,ruby,swift,kotlin,scala
                \ call s:syn_operator()

endfunction
