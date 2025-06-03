return {

	-- neogit lets us manage the state of our repository from within neovim
	-- commits, patches, index, etc
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},

	-- git signs adds nice symbols to the column line to show whats dirty and
	-- what isn't
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
}
