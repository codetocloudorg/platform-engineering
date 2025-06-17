local M = {}

M.opts = {
	-- Configuration here, or leave empty to use defaults
	line_offset = function(args)
		return args.line1
	end,
	language = function()
		return vim.bo.filetype
	end,
	output = function()
		return os.getenv("HOME") .. "/Pictures/Code/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
	end,
	window_title = function()
		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
	end,
	no_window_controls = true,
}
M.init = function()
	local wk = require("which-key")
	wk.add({
		mode = { "v" },
		{
			"<leader>sc",
			function()
				require("nvim-silicon").clip()
			end,
			desc = "Copy code screenshot to clipboard",
		},
		{
			"<leader>sf",
			function()
				require("nvim-silicon").file()
			end,
			desc = "Save code screenshot as file",
		},
		{
			"<leader>ss",
			function()
				require("nvim-silicon").shoot()
			end,
			desc = "Create code screenshot",
		},
	})
end

return M
