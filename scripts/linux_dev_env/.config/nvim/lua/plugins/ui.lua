local vim = vim

-- configs
local noice_config = require("config.noice")

return {
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight-storm]])
		end,

		-- Status line
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},

		-- Notifications and UI improvements
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = noice_config.opts,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
		},

		-- Get neovim to use nicer UI components from telescope
		{
			"stevearc/dressing.nvim",
			opts = {},
		},
	},
}
