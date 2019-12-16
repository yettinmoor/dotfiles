let mapleader=","

" Plugs

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-sort-motion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jreybert/vimagit'
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'bling/vim-airline'
Plug 'lervag/vimtex'
Plug 'kovetskiy/sxhkd-vim'
Plug 'sophacles/vim-processing'
Plug 'junegunn/goyo.vim'
call plug#end()

" Basics

set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus
set so=8
set tabstop=4
set shiftwidth=4
set nocompatible
set wildmode=longest,list,full

set encoding=utf-8
set number relativenumber
set bg=dark

let g:gruvbox_bold='0'
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

autocmd TermOpen * set nonumber norelativenumber
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

command! W w
map Q <nop>

nnoremap c "_c
nmap <leader>ft :set filetype=
map <leader>o :setlocal spell! spelllang=en_us<CR>

nnoremap <leader>g :Magit<CR>
map <leader>ff :Goyo \| set linebreak \| hi Normal guibg=NONE ctermbg=NONE<CR>

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap S :%s//g<Left><Left>

nnoremap <leader>l :!sloc %<CR>
map <leader>c :w! \| !compiler <c-r>\"%"<CR>
map <leader>C :w! \| :te compiler <c-r>\"%"<CR>
map <leader>p :!opout <c-r>\"%"<CR>

let g:vimwiki_ext2syntax = {'.md': 'markdown'}
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Runs certain update commands when configs are saved
autocmd BufWritePost *files,*directories !shortcuts
autocmd BufWritePost *Xresources,*Xresources.custom !xrdb %
autocmd BufWritePost *dwmbar !dwmbar init
autocmd BufWritePost *sxhkdrc !pkill -SIGUSR1 sxhkd

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

" Autocomplete & highlight brackets
hi MatchParen cterm=underline ctermbg=none ctermfg=none
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

" Source snippets from separate file
so ~/.config/nvim/snippets.vim
