let mapleader=","
let g:coc_snippet_next = '<S-Tab>'

" Plugins
filetype plugin on
filetype plugin indent on

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'dkasak/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-sort-motion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jiangmiao/auto-pairs'
Plug 'calebsmith/vim-lambdify'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jreybert/vimagit'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jpalardy/vim-slime'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tell-k/vim-autopep8'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'wlangstroth/vim-racket'
Plug 'fatih/vim-go'
Plug 'ziglang/zig.vim'
Plug 'zah/nim.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'prettier/vim-prettier'
Plug 'neovimhaskell/haskell-vim'
Plug 'lervag/vimtex'
Plug 'jansedivy/jai.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'sophacles/vim-processing'
Plug 'junegunn/goyo.vim'
call plug#end()

" Basics
set mouse=a
set number relativenumber
set clipboard=unnamedplus
set wildmode=longest,list,full
set encoding=utf-8
nnoremap <silent> <Esc> :noh<CR><Esc>
set conceallevel=2
set smartcase
setl formatoptions-=cro
" nnoremap <F5> :so $MYVIMRC \| echo "vimrc resourced"<CR>

" CtrlP
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 0
let g:ctrlp_show_hidden = 1

" Compile & show scripts
nmap <leader>c :w! \| :sp term://compiler %<CR>
nmap <leader>p :w! \| :sp term://run %<CR>

" Tabbing
set scrolloff=8
set tabstop=4
set shiftwidth=4
set expandtab

" Colorscheme
set termguicolors
set bg=dark
let g:gruvbox_material_background='medium'
let g:gruvbox_material_enable_italic='1'
let g:airline_theme = 'gruvbox_material'
colo gruvbox-material
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" Term
nmap <A-CR> :vs term://zsh<CR>
tmap <C-c> <Esc>:q!<CR>

" Statusline
set statusline+=%#warningmsg#
set statusline+=%*

" Term mode
au TermOpen * set nonumber norelativenumber
au TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

" Misc remaps
nnoremap S :%s//g<Left><Left>
nnoremap <A-S> :.s//g<Left><Left>
xnoremap S :s//g<Left><Left>
nnoremap c "_c
nnoremap <leader>g :Magit<CR>
map <leader>ff :Goyo \| set linebreak \| hi Normal guibg=NONE ctermbg=NONE<CR>

" Annoying keys
command! W w
map Q <nop>

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
au StdinReadPre * let s:std_in=1

" Splits
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

" VimWiki
let g:vimwiki_list = [{
            \ 'path': '~/docs/wiki',
            \ 'path_html': '~/docs/wiki/.html',
            \ 'template_path': '~/docs/wiki/.html/.templates',
            \ 'template_default': 'template',
            \ 'template_ext': '.html'
            \}]
let g:vimwiki_global_ext = 0

" Delete trailing whitespace
au BufWritePre * %s/\s\+$//e

" Run shortcuts
au BufWritePost *local/share/files,*local/share/directories !shortcuts

" CoC
set shortmess+=c
" set signcolumn=yes
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

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

""" Ale

let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 0
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {}
let g:ale_fixers = {}

let g:ale_linters['nim'] = ['nimlsp']
let g:ale_linters['haskell'] = ['hlint']

let g:ale_fixers['*'] = ['remove_trailing_lines']
let g:ale_fixers['nim'] = ['nimpretty']
let g:ale_fixers['typescript'] = ['deno']
let g:ale_fixers['haskell'] = ['hfmt']


""" Misc filetype stuff

nmap <leader>ft :set ft=

au BufRead,BufNewFile *.h set filetype=c

au BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
au BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
au BufRead,BufNewFile *.vs,*.fs set filetype=glsl

au BufRead,BufNewFile *.asm set filetype=nasm

au BufRead,BufNewFile fonts.conf set filetype=xml

let g:slime_target = "neovim"

let g:instant_markdown_autostart = 0

""" Misc

au BufWritePost *dwmbar.cfg !dwmbar
