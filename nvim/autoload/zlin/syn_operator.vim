function zlin#syn_operator#setup()
    au Syntax c,cpp,python,java,rust,go,javascript,typescript,ruby,swift,kotlin,scala
                \ call zlin#syn_operator#c_like_patterns()
endfunction


function zlin#syn_operator#c_like_patterns()
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
