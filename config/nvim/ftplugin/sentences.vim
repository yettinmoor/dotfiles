let b:surround_113 = "「\r」"
set nowrap

au BufWritePre <buffer> %!sen %
au BufWritePre <buffer> :Tabularize /|/
