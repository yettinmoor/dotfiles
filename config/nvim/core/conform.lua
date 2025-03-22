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

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
