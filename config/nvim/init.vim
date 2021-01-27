let mapleader=","

" Plugins
filetype plugin on
filetype plugin indent on
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'dkasak/gruvbox'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-sort-motion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jreybert/vimagit'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tell-k/vim-autopep8'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'ziglang/zig.vim'
Plug 'OmniSharp/omnisharp-vim'
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
" set nohlsearch
nnoremap <silent> <Esc> :noh<CR><Esc>
set conceallevel=2
set smartcase
au FileType * setlocal formatoptions-=cro
nnoremap <F5> :so $MYVIMRC \| echo "vimrc resourced"<CR>

" Tabbing
set so=8
set tabstop=4
set shiftwidth=4

" Colorscheme
set termguicolors
set bg=dark
let g:gruvbox_italic='1'
" let g:gruvbox_bold='0'
let g:gruvbox_italicize_strings='1'
colorscheme gruvbox
let g:airline_theme = 'gruvbox'
hi Normal guibg=NONE

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

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
nnoremap <leader><leader> <Esc>/<++><Enter>"_c4l

" Whitespace
set listchars=tab:▸\ ,
" set list
nnoremap <leader>s :set list!<CR>

" Script maps
nmap <leader>l :!sloc %<CR>
nmap <leader>c :w! \| :sp term://compiler %<CR>
nmap <leader>p :!opout <c-r>\"%"<CR>

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
" au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Splits
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-A-h> <C-w>5>
map <C-A-j> <C-w>5+
map <C-A-k> <C-w>5-
map <C-A-l> <C-w>5<

" Filetype detection stuff
nmap <leader>ft :set ft=
au BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
au BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
au BufRead,BufNewFile *.tex set filetype=tex
au BufRead,BufNewFile *.rasi set filetype=css
au BufRead,BufNewFile *.vs,*.fs set filetype=glsl

" Markdown
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:instant_markdown_autostart = 0
au BufRead,BufNewFile *.md nnoremap <leader>md :InstantMarkdownPreview<CR>
" Pandoc
let g:pandoc#spell#enabled = 0
let g:pandoc#folding#level = 3

" Delete trailing whitespace
au BufWritePre * %s/\s\+$//e

" Runs certain update commands when configs are saved
au BufWritePost *local/share/files,*local/share/directories !shortcuts
au BufWritePost *Xresources,*Xresources.custom !xrdb %
au BufWritePost *sxhkdrc !pkill -SIGUSR1 sxhkd

" CoC
set shortmess+=c
" set signcolumn=yes
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
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

let g:coc_snippet_next = '<S-Tab>'

" Source snippets from separate file
so ~/.config/nvim/snippets.vim

" Per-filetype syntax stuff

" C
au BufRead,BufNewFile *.h set filetype=c
function! ClangFormat()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
au BufWritePre *.h,*.c,*.cpp,*.ino call ClangFormat()

" Python
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0
let g:autopep8_disable_show_diff=1
let g:autopep8_on_save = 1

" C#
au FileType cs setlocal expandtab

" HTML/CSS
au FileType html,css setlocal expandtab
au FileType html,css setlocal tabstop=2
au FileType html,css setlocal shiftwidth=2

" Assembly
au BufRead,BufNewFile *.asm set filetype=nasm

" Processing
au FileType processing setlocal tabstop=4 shiftwidth=4
au FileType processing map <leader>c :w! \| make<CR>

" LaTeX
au VimLeave *.tex !texclear %
let g:tex_flavor = 'latex'

" Haskell
au FileType haskell setlocal expandtab
au FileType haskell noremap <leader>Q :%!indent<CR>
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1

" Go
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" Rust
let g:rustfmt_autosave = 1

" Octave
au BufRead,BufNewFile *.m set filetype=octave
