au BufEnter,BufNewFile */wiki/*.md nnoremap <leader>ww :e $WIKI_DIR/index.md<CR>

au BufWritePost */wiki/*.md !wiki2html %
