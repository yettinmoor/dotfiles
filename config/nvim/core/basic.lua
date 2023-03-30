vim.opt.nu = true
vim.opt.rnu = true
vim.opt.signcolumn = "auto:3"

vim.opt.updatetime = 100
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.encoding = "utf-8"
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")

vim.opt.matchpairs:append("<:>,「:」,『:』,【:】,“:”,‘:’,《:》")

-- conceallevel
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "set conceallevel=2",
})

-- wild
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildignore:append("*.o,*.obj,*.dylib,*.bin,*.dll,*.exe")
vim.opt.wildignore:append("*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**")
vim.opt.wildignore:append("*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico")
vim.opt.wildignore:append("*.pyc,*.pkl")
vim.opt.wildignore:append("*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv")
vim.opt.wildignorecase = true

-- trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- tabs
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- statusline
vim.opt.statusline:append("%#warningmsg#")
vim.opt.statusline:append("%*")

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

-- no search highlight
vim.keymap.set("n", "<Esc>", function()
	vim.cmd.noh()
	vim.cmd.stopinsert()
end)

-- break inserted text into smaller undo units when we insert some punctuation chars
for _, ch in ipairs({ ",", ".", "!", "?", ";", ":" }) do
	vim.keymap.set("i", ch, ch .. "<c-g>u")
end
