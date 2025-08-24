let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_strikethrough = 1

nnoremap gd <Plug>Markdown_EditUrlUnderCursor<CR>

let g:instant_markdown_autostart = 0
let g:instant_markdown_mathjax = 1

nnoremap <leader>md :InstantMarkdownPreview<CR>

nnoremap <leader>b :normal ysiw*lysiw*<CR>
nnoremap <leader>B :normal ysiW*lysiW*<CR>
nnoremap <leader>i :normal ysiw_<CR>
nnoremap <leader>I :normal ysiW_<CR>

set tabstop=2
set shiftwidth=2
set linebreak
