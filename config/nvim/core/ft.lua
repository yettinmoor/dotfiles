vim.keymap.set("n", "<leader>ft", ":set ft=")

local map = {
	{ "*.asm", "nasm" },
	{ "*.h", "c" },
	{ "*.ms,*.me,*.mom,*.man", "groff" },
	{ "*.tw", "twee" },
	{ "*.vs,*.fs", "glsl" },
	{ "*.wiki", "vimwiki" },
	{ ".clangd", "yaml" },
	{ ".clang-format", "yaml" },
	{ ".compile", "sh" },
	{ "fonts.conf", "xml" },
}

for _, x in ipairs(map) do
	vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
		pattern = x[1],
		callback = function()
			vim.opt.filetype = x[2]
		end,
	})
end
