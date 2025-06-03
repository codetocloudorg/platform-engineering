local M = {}

M.config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
		ensure_installed = { "rust", "lua", "c", "python", "go", "nix", "json", "toml", "yaml" },
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				node_incremental = "v",
				node_decremental = "V",
			},
		},
	})
end

return M
