let b:surround_113 = "「\r」"
set nowrap

au BufWritePre <buffer> %!./sentences %
au BufWritePre <buffer> :Tabularize /|/
