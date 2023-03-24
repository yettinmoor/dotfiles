local util = require("util")
local k = vim.keymap

vim.g.mapleader = ","

-- rc
k.set("n", "<leader>ev", function()
	local rc = vim.fn.expand("$MYVIMRC")
	vim.cmd.edit(rc)
end, {
	silent = true,
	desc = "reload init.lua",
})
k.set("n", "<leader>sv", function()
	local rc = vim.fn.expand("$MYVIMRC")
	vim.cmd.update(rc)
	vim.cmd.source(rc)
	vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
	silent = true,
	desc = "reload init.lua",
})

-- compile
k.set("n", "<leader>c", function()
	vim.cmd.write()
	util.split("term://compile -f " .. vim.opt.filetype:get() .. " " .. vim.fn.bufname("%"))
end)

-- run
k.set("n", "<leader>r", function()
	vim.cmd.write()
	util.split("term://run " .. vim.opt.filetype:get() .. " " .. vim.fn.bufname("%"))
end)

-- misc remaps
k.set("n", "S", ":%s//g<Left><Left>")
k.set("n", "c", '"_c')
