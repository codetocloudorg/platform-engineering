local vim = vim

-- Create autocommand groups
local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Adjust colorcolumn for Rust files
vim.api.nvim_create_autocmd("Filetype", {
	group = augroup("rust_settings"),
	pattern = "rust",
	command = "set colorcolumn=100",
})
