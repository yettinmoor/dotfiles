let b:surround_113 = "「\r」"
set nowrap

let g:AutoPairs["'"]=''

au BufWritePre <buffer> silent! %!sen %
au BufWritePre <buffer> silent! 2,$:Tabularize /|/
