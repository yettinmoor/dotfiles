let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_no_extensions_in_markdown = 1

nnoremap gd <Plug>Markdown_EditUrlUnderCursor<CR>
nnoremap <backspace> <C-o>

let g:instant_markdown_mathjax = 1
let g:instant_markdown_autostart = 0

nnoremap <leader>md :InstantMarkdownPreview<CR>
