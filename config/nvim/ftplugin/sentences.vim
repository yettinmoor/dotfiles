let b:surround_113 = "「\r」"
set nowrap

au BufWritePre <buffer> silent! %!sen %
au BufWritePre <buffer> silent! 2,$:Tabularize /|/
