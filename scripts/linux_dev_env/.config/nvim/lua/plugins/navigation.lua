local vim = vim
local neotree_config = require("config.neotree")

return {

	-- Neo-tree provides us with a filesystem tree view of our current project
	-- Try not to abuse this and instead rely more on harpoon to move between
	-- files
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = neotree_config.keys,
		opts = neotree_config.opts,
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
	},

	-- Flash is the enhanced movement mechanism that will get you to any point
	-- in your buffer within 2-3 keystrokes.
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
	},
	-- Harpoon for file navigation
	-- Typically you only have a handful of main files that you want to cycle
	-- through while also opening some different files through find definition
	-- or whatever. Harpoon is my current solution for that.
	-- See https://www.youtube.com/watch?v=Qnos8aApa9g for why it might be
	-- useful
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
		end,
	},

	-- Spectre helps with global search and replace in your project
	-- Bonus points because spectre was one of my most played heroes in dota
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Toggle Spectre", mode = "n" },
		},
	},

	-- Marks improves the existing neovim marks functionality
	{
		"chentoast/marks.nvim",
		opts = {},
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
