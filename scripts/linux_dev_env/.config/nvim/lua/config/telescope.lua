local M = {}

-- keymaps
M.keys = {
	{ "<localleader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
	{ "<localleader>gf", "<cmd>Telescope grep_string<CR>", desc = "Find Word" },
	{ "<localleader>gg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
	{ "<localleader>b", "<cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Buffers" },
	{ "<localleader>m", "<cmd>Telescope marks<CR>", desc = "Marks" },
	{ "<localleader>u", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
	{ "<localleader>x", "<cmd>Telescope oldfiles<CR>", desc = "Old files" },
	{ "<localleader>;", "<cmd>Telescope command_history<CR>", desc = "Command history" },
	{ "<localleader>:", "<cmd>Telescope commands<CR>", desc = "Commands" },
	{ "<localleader>/", "<cmd>Telescope search_history<CR>", desc = "Search history" },
	{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer find" },
	{ "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Key Maps" },
	{ "<leader>sm", "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
}

-- options
M.opts = {}

return M
