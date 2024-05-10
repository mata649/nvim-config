require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "go", "java", "elixir", "rust", "python", "lua", "vim", "vimdoc", "query" },

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
	},
})
