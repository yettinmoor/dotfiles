au BufEnter,BufNewFile ~/docs/wiki/*.md nnoremap <leader>ww :e $WIKI_DIR/index.md<CR>

au BufWritePost ~/docs/wiki/*.md !wiki2html %

au BufEnter,BufNewFile ~/docs/wiki/*.typ nnoremap <leader>ww :e $WIKI_DIR/index.typ<CR>

au BufWritePost ~/docs/wiki/*.typ !typst2html "%"
