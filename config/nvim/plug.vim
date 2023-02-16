filetype plugin on
filetype plugin indent on

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier'

" Languages/filetypes
Plug 'vimwiki/vimwiki'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'rhysd/vim-clang-format', { 'for': 'c' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'ziglang/zig.vim', { 'for': 'zig' }
Plug 'zah/nim.vim', { 'for': 'nim' }
Plug 'OmniSharp/omnisharp-vim', { 'for': 'csharp' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'kovetskiy/sxhkd-vim', { 'for': 'sxhkd' }
Plug 'kalekundert/vim-nestedtext', {'for': 'nt' }
Plug 'vim-scripts/Twee-Integration-for-Vim'
Plug 'mtdl9/vim-log-highlighting'

" Small utilities
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jreybert/vimagit'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-sort-motion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/goyo.vim'

" Aesthetics
Plug 'sainnhe/gruvbox-material'
Plug 'dkasak/gruvbox'
Plug 'honza/vim-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'calebsmith/vim-lambdify'

call plug#end()
