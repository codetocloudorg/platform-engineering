local lspconfig_config = require("config.lspconfig")
local trouble_config = require("config.trouble")

return {
	-- LSP config provides the backbone for installing different language
	-- servers that can be used within neovim
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "saghen/blink.cmp" },
		config = lspconfig_config.config,
		opts = lspconfig_config.opts,
	},

	-- Mason makes installing necessary language servers, linters, etc super
	-- easy
	-- Make sure you run :checkhealth to ensure all of the necessary tooling is
	-- installed
	{
		"williamboman/mason.nvim",
		opts = {},
		keys = {
			{ "<leader>mm", "<cmd>Mason<cr>", mode = "n", desc = "Open Mason" },
		},
	},

	-- Provides some useful features like LSPInstall
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
	},

	-- LSP diagnostics, code actions, etc.
	{
		"folke/trouble.nvim",
		opts = { focus = true },
		cmd = "Trouble",
		keys = trouble_config.keys,
	},
}
