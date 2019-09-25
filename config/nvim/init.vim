let mapleader=","

" Plugs

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
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

filetype plugin on
set encoding=utf-8
set number relativenumber
syntax on
set bg=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

command! W w

nnoremap c "_c
nmap <leader>ft :set filetype=
map <leader>o :setlocal spell! spelllang=en_us<CR>

nnoremap <leader>g :Magit<CR>
map <leader>ff :Goyo \| set linebreak \| hi Normal guibg=NONE ctermbg=NONE<CR>

set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap S :%s//g<Left><Left>

nnoremap <leader>l :!sloc %<CR>
map <leader>c :w! \| !compiler <c-r>\"%"<CR>
map <leader>p :!opout <c-r>\"%"<CR><CR>

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
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i

" sh
autocmd FileType sh inoremap <leader>n >/dev/null
autocmd FileType sh inoremap <leader>N >/dev/null 2>&1

" C
autocmd FileType c,cpp inoremap <leader>4 /*  */<Esc>3ha
autocmd FileType c,cpp inoremap <leader>pr printf()<++><Esc>F(a
autocmd FileType c,cpp inoremap <leader>if if () {<Enter><++><Enter>}<Esc>2k0f(a
autocmd FileType c,cpp inoremap <leader>ti () ? <++> : <++> <Esc>F(a
autocmd FileType c,cpp inoremap <leader>wh while () {<Enter><++><Enter>}<Esc>2k0f(a
autocmd FileType c,cpp inoremap <leader>fr for () {<Enter><++><Enter>}<Esc>2k0f(a
autocmd FileType c,cpp inoremap <leader>fn <Space>(<++>) {<Enter><++><Enter>}<Esc>2k0f(hi

" Python
autocmd FileType python inoremap <leader>pr print()<++><Esc>F(a
autocmd FileType python inoremap <leader>if if :<Enter><++><Esc>k0f:i
autocmd FileType python inoremap <leader>wh while :<Enter><++><Esc>k0f:i
autocmd FileType python inoremap <leader>fr for :<Enter><++><Esc>k0f:i

" Scheme
autocmd FileType scheme set tabstop=2 shiftwidth=2 expandtab

" LaTeX
autocmd VimLeave *.tex !texclear %
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,li <Enter>\item<Space>
autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Esc>2kA{}<Esc>i
autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,beg \begin{}<Enter><++><Enter>\end{<++>}2k0f{a
autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,bt {\blindtext}

"html/css
autocmd FileType html,css set expandtab
autocmd FileType html,css set tabstop=2
autocmd FileType html,css set shiftwidth=2
