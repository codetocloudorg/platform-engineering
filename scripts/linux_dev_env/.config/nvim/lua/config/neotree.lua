local M = {}

M.keys = {
	{
		"<LocalLeader>e",
		"<cmd>Neotree filesystem left toggle dir=./<CR>",
		desc = "Explorer NeoTree Toggle",
	},
	{
		"<LocalLeader>a",
		"<cmd>Neotree filesystem left reveal dir=./<CR>",
		desc = "Explorer NeoTree Reveal",
	},
}

M.opts = {
	close_if_last_window = true,

	source_selector = {
		winbar = false,
		show_scrolled_off_parent_node = true,
		padding = { left = 1, right = 0 },
		sources = {
			{ source = "filesystem", display_name = "  Files" }, --       
			{ source = "buffers", display_name = "  Buffers" }, --        
			{ source = "git_status", display_name = " 󰊢 Git" }, -- 󰊢      
		},
	},

	event_handlers = {
		-- Close neo-tree when opening a file.
		{
			event = "file_opened",
			handler = function()
				require("neo-tree").close_all()
			end,
		},
	},

	default_component_configs = {
		indent = {
			padding = 0,
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			folder_empty_open = "",
			default = "",
		},
		modified = {
			symbol = "•",
		},
		name = {
			trailing_slash = true,
			highlight_opened_files = true,
			use_git_status_colors = false,
		},
		git_status = {
			symbols = {
				-- Change type
				added = "A",
				deleted = "D",
				modified = "M",
				renamed = "R",
				-- Status type
				untracked = "U",
				ignored = "I",
				unstaged = "",
				staged = "S",
				conflict = "C",
			},
		},
	},
	window = {
		width = 25,
		mappings = {
			["q"] = "close_window",
			["?"] = "noop",
			["<Space>"] = "noop",

			["g?"] = "show_help",
			["<2-LeftMouse>"] = "open",
			["<CR>"] = "open_with_window_picker",
			["l"] = "open_drop",
			["h"] = "close_node",
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["<C-r>"] = "refresh",

			["s"] = "noop",
			["sv"] = "open_split",
			["sg"] = "open_vsplit",
			["st"] = "open_tabnew",

			["c"] = { "copy", config = { show_path = "relative" } },
			["m"] = { "move", config = { show_path = "relative" } },
			["a"] = { "add", nowait = true, config = { show_path = "relative" } },
			["N"] = { "add_directory", config = { show_path = "relative" } },
			["d"] = "noop",
			["dd"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["P"] = "paste_from_clipboard",
			["<S-Tab>"] = "prev_source",
			["<Tab>"] = "next_source",

			["p"] = {
				"toggle_preview",
				nowait = true,
				config = { use_float = true },
			},
		},
	},
	filesystem = {
		window = {
			mappings = {
				["H"] = "toggle_hidden",
				["/"] = "noop",
				["f"] = "fuzzy_finder",
				["F"] = "filter_on_submit",
				["<C-x>"] = "clear_filter",
				["<C-c>"] = "clear_filter",
				["<BS>"] = "navigate_up",
				["."] = "set_root",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
			},
		},
		group_empty_dirs = true,
		use_libuv_file_watcher = true,
		bind_to_cwd = false,
		cwd_target = {
			sidebar = "window",
			current = "window",
		},

		filtered_items = {
			visible = false,
			show_hidden_count = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				".git",
				".hg",
				".svc",
				".DS_Store",
				"thumbs.db",
				".sass-cache",
				"node_modules",
				".pytest_cache",
				".mypy_cache",
				"__pycache__",
				".stfolder",
				".stversions",
			},
			never_show = {},
		},
	},
	buffers = {
		bind_to_cwd = false,
		window = {
			mappings = {
				["<BS>"] = "navigate_up",
				["."] = "set_root",
				["dd"] = "buffer_delete",
			},
		},
	},
}

return M
