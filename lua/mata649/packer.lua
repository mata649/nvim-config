-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "catppuccin/nvim", as = "catppuccin" })

	use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
	-- Java hell
	use("mfussenegger/nvim-jdtls")

	-- Formatting
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	})
	-- Linting
	use("mfussenegger/nvim-lint")

	-- Automatically does things
	use("WhoIsSethDaniel/mason-tool-installer.nvim")
end)
