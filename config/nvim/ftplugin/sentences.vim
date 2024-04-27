let b:surround_113 = "「\r」"
set nowrap

let g:AutoPairs["'"]=''

au BufWritePre <buffer> silent! %!sen %
au BufWritePre <buffer> silent! 2,$:Tabularize /|/

" nnoremap <leader>b :normal ysiw]"ayi]f]i:<Esc>"apT:gut]t]<CR>
" nnoremap <leader>B :normal ysiW]"ayi]f]i:<Esc>"apT:gut]t]<CR>

nnoremap <leader>b :normal ysiw]"ayi]f]i:<Esc>"apt]<CR>
nnoremap <leader>B :normal ysiW]"ayi]f]i:<Esc>"apt]<CR>

let $SCRAPE_LANG = substitute(bufname(), '.*/', '', '')
