au BufEnter,BufNewFile ~/docs/wiki/*.md nnoremap <leader>ww :e $WIKI_DIR/index.md<CR>

au BufWritePost ~/docs/wiki/*.md !wiki2html %
