local util = require("util")

vim.keymap.set("n", "<A-CR>", function()
	util.split("term://zsh")
end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.nu = false
		vim.opt.rnu = false
		vim.cmd.startinsert()
	end,
})
