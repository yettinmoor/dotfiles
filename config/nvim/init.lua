local util = require("util")

local cfg_files = {
	"plug.vim", -- plugins
	"basic.lua", -- basic settings
	"map.lua", -- keymaps
	"ft.vim", -- filetype def
	"color.lua", -- color settings
	"term.lua", -- term settings
}

for _, name in ipairs(cfg_files) do
	local cmd = string.format("source %s/core/%s", vim.fn.stdpath("config"), name)
	vim.cmd(cmd)
end

local config = require("config")
