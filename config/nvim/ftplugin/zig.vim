set wildignore+=zig-cache

nnoremap <leader>t :lua require("util").split("term://zig test " .. vim.fn.bufname("%"))<CR>
