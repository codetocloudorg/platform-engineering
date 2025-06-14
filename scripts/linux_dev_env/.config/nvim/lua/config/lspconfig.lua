local M = {}

M.opts = {
	servers = {
		clangd = {},
		jsonls = {},
		dockerls = {},
		yamlls = {},
		taplo = {},
	},
}

M.config = function(_, opts)
	-- Setup language servers.
	local lspconfig = require("lspconfig")
	for server, config in pairs(opts.servers) do
		config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
		lspconfig[server].setup(config)
	end

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Next Diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Previous Diagnostic" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "List Workspace Folder" })
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
end

return M
