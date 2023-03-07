""" plug
source ~/.config/nvim/plug.vim

""" color
set termguicolors
set bg=dark
let g:gruvbox_material_background='medium'
let g:gruvbox_material_enable_italic='1'
let g:airline_theme = 'gruvbox_material'
colo gruvbox-material
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

""" basics
let mapleader=","
set mouse=a
set number relativenumber
set clipboard=unnamedplus
set wildmode=longest,list,full
set encoding=utf-8
nnoremap <silent> <Esc> :noh<CR><Esc>
set conceallevel=2
set ignorecase
set smartcase
set wildignore+=*/.git/*
setl formatoptions-=cro

""" part
function Part(...)
  if winwidth('%') >= winheight('%') * 2.5
    execute 'vsplit ' . join(a:000)
  else
    execute 'split ' . join(a:000)
  endif
endfunction

command! Part call Part()

""" compile
nmap <silent> <leader>c :w! \| :call Part('term://compile -f ' . &filetype . ' ' . bufname("%"))<CR>
nmap <silent> <leader>p :w! \| :call Part('term://run ' . bufname("%"))<CR>

""" trailing whitespace
au BufWritePre * %s/\s\+$//e

""" tabs
set scrolloff=8
set tabstop=4
set shiftwidth=4
set expandtab

""" CtrlP
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 0
let g:ctrlp_show_hidden = 1

""" term
nmap <A-CR> :call Part('term://zsh')<CR>

""" statusline
set statusline+=%#warningmsg#
set statusline+=%*

""" term
au TermOpen * set nonumber norelativenumber
au TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

""" misc remaps
nnoremap S :%s//g<Left><Left>
nnoremap <A-S> :.s//g<Left><Left>
xnoremap S :s//g<Left><Left>
nnoremap c "_c
nnoremap <leader>g :Magit<CR>
map <leader>ff :Goyo \| set linebreak \| hi Normal guibg=NONE ctermbg=NONE<CR>

""" annoying keys
command! W w
map Q <nop>

""" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
au StdinReadPre * let s:std_in=1

""" splits
set splitbelow splitright
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

""" vimwiki
let g:vimwiki_list = [{
            \ 'path': '~/docs/wiki',
            \ 'path_html': '~/docs/wiki/html',
            \ 'template_path': '~/docs/wiki/html/.templates',
            \ 'template_default': 'template',
            \ 'template_ext': '.html',
            \}]
let g:vimwiki_global_ext = 0

""" Recompile files when edited
au BufWritePost *shortcuts/* !mkshortcuts

""" coc
let g:coc_snippet_next = '<S-Tab>'
set shortmess+=c
" set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nnoremap <leader>f :call CocAction('format')<CR>

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

inoremap <F2> <Plug>(coc-rename)

""" ale
let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'always'
let g:ale_lint_on_enter               = 1
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {}
let g:ale_fixers = {}

function! FormatSh(buffer)
    return { 'command': 'shfmt -i 4 -bn -ci -kp -sr' }
endfunction
execute ale#fix#registry#Add('shfmt', 'FormatSh', ['sh'], 'shfmt for sh')

let g:ale_linters['haskell'] = ['hlint']
let g:ale_linters['lua'] = ['luacheck']
let g:ale_linters['nim'] = ['nimlsp']
let g:ale_linters['python'] = ['ruff check']
let g:ale_linters['rust'] = ['cargo clippy']
let g:ale_linters['sh'] = ['shellcheck']

let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['haskell'] = ['hindent']
let g:ale_fixers['html'] = ['prettier']
let g:ale_fixers['json'] = ['jq']
let g:ale_fixers['lua'] = ['stylua']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['nim'] = ['nimpretty']
let g:ale_fixers['python'] = ['autopep8']
let g:ale_fixers['rust'] = ['rustfmt']
let g:ale_fixers['sh'] = ['shfmt']
let g:ale_fixers['typescript'] = ['deno']
let g:ale_fixers['xml'] = ['prettier']
let g:ale_fixers['yaml'] = ['prettier']


""" misc filetype stuff
nmap <leader>ft :set ft=

au BufRead,BufNewFile *.asm set filetype=nasm
au BufRead,BufNewFile *.h set filetype=c
au BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
au BufRead,BufNewFile *.tw set filetype=twee
au BufRead,BufNewFile *.vs,*.fs set filetype=glsl
au BufRead,BufNewFile .clangd set filetype=yaml
au BufRead,BufNewFile fonts.conf set filetype=xml

""" mnemo
au BufRead,BufNewFile *.mnemo set filetype=mnemo
au BufRead,BufNewFile */mnemo/sen/* set filetype=sentences
au BufRead,BufNewFile */mnemo/cloze/* set filetype=cloze
