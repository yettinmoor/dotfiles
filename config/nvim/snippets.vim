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
autocmd FileType tex inoremap ,beg \begin{}<Enter><++><Enter>\end{<++>}<Esc>2k0f{a
autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,bt {\blindtext}

" HTML/CSS
autocmd FileType html,css set expandtab
autocmd FileType html,css set tabstop=2
autocmd FileType html,css set shiftwidth=2

" Assembly
autocmd BufRead,BufNewFile *.asm set filetype=nasm

" Processing
autocmd FileType processing set tabstop=4 shiftwidth=4
autocmd FileType processing map <leader>c :w! \| make<CR>
