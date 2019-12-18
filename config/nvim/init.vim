let mapleader=","

" Plugins
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
Plug 'jiangmiao/auto-pairs'
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
set mouse=a
set number relativenumber
set clipboard=unnamedplus
set wildmode=longest,list,full
set encoding=utf-8
set nohlsearch

" Tabbing
set so=8
set tabstop=4
set shiftwidth=4

" Colorscheme
set bg=dark
let g:gruvbox_bold='0'
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

"Statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Term mode
autocmd TermOpen * set nonumber norelativenumber
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
nnoremap <leader><leader> <Esc>/<++><Enter>"_c4l

" Script maps
nmap <leader>l :!sloc %<CR>
nmap <leader>c :w! \| !compiler <c-r>\"%"<CR>
nmap <leader>C :w! \| :te compiler <c-r>\"%"<CR>
nmap <leader>p :!opout <c-r>\"%"<CR>

" Misc remaps
nnoremap S :%s//g<Left><Left>
nnoremap c "_c
nnoremap <leader>g :Magit<CR>
map <leader>ff :Goyo \| set linebreak \| hi Normal guibg=NONE ctermbg=NONE<CR>

" Annoying keys
command! W w
map Q <nop>

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Splits
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Filetype detection stuff
nmap <leader>ft :set ft=
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.rasi set filetype=css
let g:vimwiki_ext2syntax = {'.md': 'markdown'}

" Delete trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Runs certain update commands when configs are saved
autocmd BufWritePost *local/share/files,*local/share/directories !shortcuts
autocmd BufWritePost *Xresources,*Xresources.custom !xrdb %
autocmd BufWritePost *sxhkdrc !pkill -SIGUSR1 sxhkd

" Source snippets from separate file
so ~/.config/nvim/snippets.vim
