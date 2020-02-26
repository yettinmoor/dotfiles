" sh
au FileType sh inoremap <leader>n >/dev/null
au FileType sh inoremap <leader>N >/dev/null 2>&1

" C
au FileType c,cpp inoremap <leader>4 /*  */<Esc>3ha
au FileType c,cpp inoremap <leader>pr printf()<++><Esc>F(a
au FileType c,cpp inoremap <leader>if if () {<Enter><++><Enter>}<Esc>2k0f(a
au FileType c,cpp inoremap <leader>ti () ? <++> : <++> <Esc>F(a
au FileType c,cpp inoremap <leader>wh while () {<Enter><++><Enter>}<Esc>2k0f(a
au FileType c,cpp inoremap <leader>fr for () {<Enter><++><Enter>}<Esc>2k0f(a
au FileType c,cpp inoremap <leader>fn <Space>(<++>) {<Enter><++><Enter>}<Esc>2k0f(hi

" Python
au FileType python inoremap <leader>pr print()<++><Esc>F(a
au FileType python inoremap <leader>if if :<Enter><++><Esc>k0f:i
au FileType python inoremap <leader>wh while :<Enter><++><Esc>k0f:i
au FileType python inoremap <leader>fr for :<Enter><++><Esc>k0f:i

" LaTeX
au FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
au FileType tex inoremap ,it \textit{}<++><Esc>T{i
au FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
au FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
au FileType tex inoremap ,li <Enter>\item<Space>
au FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
au FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Esc>2kA{}<Esc>i
au FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
au FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
au FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
au FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
au FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
au FileType tex inoremap ,beg \begin{}<Enter><++><Enter>\end{<++>}<Esc>2k0f{a
au FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
au FileType tex inoremap ,bt {\blindtext}
