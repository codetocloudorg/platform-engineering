local M = {}

M.opts = {

	-- 'default' for mappings similar to built-in completion
	-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
	-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	-- see the "default configuration" section below for full documentation on how to define
	-- your own keymap.
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
	},

	appearance = {
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- will be removed in a future release
		use_nvim_cmp_as_default = true,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	-- default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, via `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	-- pref

	-- experimental auto-brackets support
	-- completion = { accept = { auto_brackets = { enabled = true } } }

	-- experimental signature help support
	-- signature = { enabled = true }
}

return M
