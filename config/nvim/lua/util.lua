local M = {}

function M.split(arg)
	local is_horiz = vim.fn.winwidth("%") >= vim.fn.winheight("%") * 2.5
	if is_horiz then
		vim.cmd.vsplit(arg)
	else
		vim.cmd.split(arg)
	end
end

function M.bufname()
	return vim.fn.shellescape(vim.fn.bufname())
end

return M
