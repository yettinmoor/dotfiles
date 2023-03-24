" Conceal 'function' with a lambda character
syntax keyword racketNiceLambda lambda conceal cchar=λ

" Link up syntax
hi link racketNiceLambda Statement
hi! link Conceal Statement

" Set conceallevel/cursor
setlocal conceallevel=1
setlocal concealcursor=c
