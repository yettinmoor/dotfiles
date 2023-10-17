vim.keymap.set("n", "<leader>ft", ":set ft=")

local map = {
	{ "*.asm", "nasm" },
	{ "*.h", "c" },
	{ "*.mnemo", "mnemo" },
	{ "*.ms,*.me,*.mom,*.man", "groff" },
	{ "*.nil", "nil" },
	{ "*.tw", "twee" },
	{ "*.vs,*.fs", "glsl" },
	{ "*.wiki", "vimwiki" },
	{ "*/mnemo/sen/*", "sentences" },
	{ "*/mnemo/cloze/*", "cloze" },
	{ ".clang-format", "yaml" },
	{ ".clangd", "yaml" },
	{ ".compile", "sh" },
	{ "fonts.conf", "xml" },
}

for _, x in ipairs(map) do
	vim.api.nvim_create_autocmd("BufRead", {
		pattern = x[1],
		callback = function()
			vim.opt.filetype = x[2]
		end,
	})
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = x[1],
		callback = function()
			vim.opt.filetype = x[2]
		end,
	})
end
