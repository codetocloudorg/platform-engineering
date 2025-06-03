local vim = vim

-- Keymap helper function

local function map(mode, lhs, rhs, opts)
	opts = opts or {}

	opts.silent = opts.silent ~= false

	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Escape key alternatives

for _, key in ipairs({ "j", "k" }) do
	for _, mode in ipairs({ "n", "i", "v", "s", "x", "c", "o", "l", "t" }) do
		map(mode, "<C-" .. key .. ">", "<Esc>")
	end
end

-- Leader mappings

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

map("n", "<leader><leader>", "<c-^>", { desc = "Switch to last buffer" })

map("n", "<leader>,", ":set invlist<cr>", { desc = "Toggle hidden characters" })

map("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>', { desc = "Open new file in current directory" })

-- Center search results

map("n", "n", "nzz", { desc = "Next search result (centered)" })

map("n", "N", "Nzz", { desc = "Previous search result (centered)" })

map("n", "*", "*zz", { desc = "Search word under cursor (centered)" })

map("n", "#", "#zz", { desc = "Search word under cursor backward (centered)" })

map("n", "g*", "g*zz", { desc = "Search partial word under cursor (centered)" })

-- Search with better defaults

map("n", "?", "?\\v", { desc = "Very magic search backward" })

map("n", "/", "/\\v", { desc = "Very magic search forward" })

map("c", "%s/", "%sm/", { desc = "Substitute with magic" })

-- Disable arrow keys in normal and insert mode

for _, key in ipairs({ "up", "down" }) do
	map("n", "<" .. key .. ">", "<nop>")

	map("i", "<" .. key .. ">", "<nop>")
end

for _, key in ipairs({ "left", "right" }) do
	map("i", "<" .. key .. ">", "<nop>")
end

-- Arrow keys for buffer navigation

map("n", "<left>", ":bp<cr>", { desc = "Previous buffer" })

map("n", "<right>", ":bn<cr>", { desc = "Next buffer" })

-- Visual line navigation

map("n", "j", "gj", { desc = "Move down by visual line" })

map("n", "k", "gk", { desc = "Move up by visual line" })

-- Quick variable name modification

map("n", "<leader>m", "ct_", { desc = "Change text until underscore" })

-- F1 is Escape

map("", "<F1>", "<Esc>")

map("i", "<F1>", "<Esc>")

-- Quick find

map("", "<C-p>", "<cmd>Files<cr>", { desc = "Find files" })

-- Quick search clearing

map("v", "<C-c>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })

map("n", "<C-c>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })

-- Duplicate and comment

map("n", "yc", "yygccp", { desc = "Duplicate line and comment original" })

-- Change word

map("n", "<CR>", "ciw", { desc = "Change inner word" })

-- Move selected lines

map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected lines down" })

map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected lines up" })

-- Line navigation

map("n", "L", "$", { desc = "Go to end of line" })

map("n", "H", "^", { desc = "Go to start of line" })

-- open lazy
map("n", "<leader>ll", "<cmd>Lazy<cr>", { silent = true, desc = "open lazy" })
