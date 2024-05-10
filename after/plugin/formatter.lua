local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		go = { "gofmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		elixir = { "mix" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
})
vim.keymap.set({ "n", "v" }, "F", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end)

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
