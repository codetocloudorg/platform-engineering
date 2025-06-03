local vim = vim

local telescope_config = require("config.telescope")
local treesitter_config = require("config.treesitter")
local conform_config = require("config.conform")

return {

	-- Which key provides useful type hints when doing different actions within
	-- neovim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- Snacks contain a bunch of quality of life improvements fopr neovim
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},

	-- Indent guides
	-- Super helpful for understanding scope annd lifetimes while
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- Treesitter provides all of our syntax highlighting for different
	-- languages
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = treesitter_config.config,
	},

	-- Telescope provides a ton of uiseful features on top of the fuzzy finding
	-- It might struggle a little bit with large codebases. Consider switching
	-- to nvim-fzf for something a little snappier.

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = telescope_config.opts,
		keys = telescope_config.keys,
	},

	-- nvim surround is a super helpful plugin that makes it easy to surround
	-- existing text with symbols like " ' { [ etc
	-- Really helpful when porting between configuration file types
	{

		"kylechui/nvim-surround",

		version = "*",

		event = "VeryLazy",

		opts = {},
	},

	-- Comment is essential for commenting out code nicely
	-- Supports both line comments and block comments in most languages
	{

		"numToStr/Comment.nvim",

		opts = {},
	},

	-- Autopairs adds the closing symbol to standard programming symbols like
	-- " { [ etc
	{

		"windwp/nvim-autopairs",

		event = "InsertEnter",

		config = true,
	},

	-- Code formatting

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = conform_config.keys,
		config = conform_config.config,
	},

	-- Motion enhancements

	-- Icon picker
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({ disable_legacy_commands = true })
			vim.keymap.set("n", "<Leader>li", "<cmd>IconPickerNormal<cr>", { noremap = true, silent = true })
		end,
	},
}
