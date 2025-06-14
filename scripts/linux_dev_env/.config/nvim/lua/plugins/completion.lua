local blink_config = require("config.blink")

return {

	-- Blink is our autocomplete engine for everything from LSP recommendations
	-- to buffer completions
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally

		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = blink_config.opts,
		opts_extend = { "sources.completion.enabled_providers" },
	},
}
