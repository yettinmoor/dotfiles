local util = require("util")

local cfg_files = {
	"plug.vim",
	"basic.lua",
	"map.lua",
	"ft.vim",
	"color.lua",
	"term.lua",
	"lsp.lua",
}

for _, name in ipairs(cfg_files) do
	local cmd = string.format("source %s/core/%s", vim.fn.stdpath("config"), name)
	vim.cmd(cmd)
end

local config = require("config")
