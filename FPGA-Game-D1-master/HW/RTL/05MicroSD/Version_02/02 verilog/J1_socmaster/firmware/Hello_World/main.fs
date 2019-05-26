include crossj1.fs
include basewords.fs
target
include hw_defs.fs

4 org
module[ eveything"
include nuc.fs
include app.fs

]module

0 org

code 0jump
    \ h# 3e00 ubranch
    main ubranch
    main ubranch
end-code

meta

hex

: create-output-file w/o create-file throw to outfile ;
s" j1.mem" create-output-file
:noname
    4000 0 do i t@ s>d <# # # # # #> type cr 2 +loop
; execute

s" j1.lst" create-output-file
d# 0
h# 2000 disassemble-block
