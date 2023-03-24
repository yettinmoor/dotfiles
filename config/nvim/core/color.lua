-- color
vim.opt.termguicolors = true
vim.opt.bg = "dark"

vim.g.gruvbox_material_background='medium'
vim.g.gruvbox_material_enable_italic='1'
vim.g.airline_theme = 'gruvbox_material'
vim.cmd.colo("gruvbox-material")
vim.cmd.hi("Normal", "guibg=NONE", "ctermbg=NONE")
vim.cmd.hi("EndOfBuffer", "guibg=NONE", "ctermbg=NONE")
