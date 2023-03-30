au BufWritePost <buffer> silent Vimwiki2HTML

nmap <leader>c :w! \| :VimwikiAll2HTML<CR>

nmap gd    <Plug>VimwikiFollowLink
nmap <S-l> <Plug>VimwikiNextLink
nmap <S-h> <Plug>VimwikiPrevLink

let g:vimwiki_list = [{
    \ 'syntax': 'markdown',
    \ 'ext': '.wiki',
    \ 'path': '~/docs/vimwiki',
    \ 'path_html': '~/docs/html',
    \ 'template_path': '~/docs/html/.templates',
    \ 'template_default': 'template.html',
    \ 'custom_wiki2html': 'vimwiki_markdown',
    \ 'html_filename_parameterization': 1,
\ }]

let g:vimwiki_key_mappings = {
    \ 'all_maps': 1,
    \ 'global': 1,
    \ 'headers': 1,
    \ 'text_objs': 1,
    \ 'table_format': 1,
    \ 'table_mappings': 0,
    \ 'lists': 1,
    \ 'links': 1,
    \ 'html': 1,
    \ 'mouse': 0,
    \ }

" unmap tab in insert mode
" iunmap <buffer> <Tab>
" remap table tab mappings to M-n M-p
inoremap <silent><expr><buffer> <M-n> vimwiki#tbl#kbd_tab()
inoremap <silent><expr><buffer> <M-p> vimwiki#tbl#kbd_shift_tab()
" on enter if completion is open, complete first element otherwise use
" default vimwiki mapping
inoremap <silent><expr><buffer> <cr> pumvisible() ? coc#_select_confirm()
    \: "<C-]><Esc>:VimwikiReturn 1 5<CR>"
