local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		haskell = { "hindent" },
		html = { "prettier" },
		javascript = { "deno" },
		json = { "jq" },
		lua = { "stylua" },
		markdown = { "prettier" },
		nim = { "nimpretty" },
		python = { "autopep8" },
		rust = { "rustfmt" },
		typescript = { "deno" },
		xml = { "prettier" },
		yaml = { "prettier" },
		zig = { "zigfmt" },
	},

	["_"] = { "trim_whitespace" },

	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
