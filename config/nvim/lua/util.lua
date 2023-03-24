local M = {}

function M.split(arg)
	local is_horiz = vim.fn.winwidth("%") >= vim.fn.winheight("%") * 2.5
	if is_horiz then
		vim.cmd.vsplit(arg)
	else
		vim.cmd.split(arg)
	end
end

return M
