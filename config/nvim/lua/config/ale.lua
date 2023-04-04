vim.cmd.highlight("ALEErrorSign", "ctermbg=NONE", "ctermfg=red")
vim.cmd.highlight("ALEWarningSign", "ctermbg=NONE", "ctermfg=yellow")

vim.g.ale_sign_error = "✘"
vim.g.ale_sign_warning = "⚠"
vim.g.ale_linters_explicit = 1
vim.g.ale_lint_on_text_changed = "always"
vim.g.ale_lint_on_enter = 1
vim.g.ale_lint_on_save = 1
vim.g.ale_fix_on_save = 1

vim.g.ale_linters = {
	haskell = "hlint",
	lua = "luacheck",
	nim = "nimlsp",
	python = "ruff check",
	rust = "cargo clippy",
	sh = "shellcheck",
}

-- function! FormatSh(buffer)
--     return { 'command': 'shfmt -i 4 -bn -ci -kp -sr' }
-- endfunction
-- execute ale#fix#registry#Add('shfmt', 'FormatSh', ['sh'], 'shfmt for sh')

vim.g.ale_fixers = {
	c = "clang-format",
	cpp = "clang-format",
	css = "prettier",
	haskell = "hindent",
	html = "prettier",
	json = "jq",
	lua = "stylua",
	markdown = "prettier",
	nim = "nimpretty",
	python = "autopep8",
	rust = "rustfmt",
	typescript = "deno",
	xml = "prettier",
	yaml = "prettier",
}
