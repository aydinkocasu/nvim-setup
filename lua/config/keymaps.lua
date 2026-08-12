-- lua/config/keymaps.lua

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic quickfix list
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Window resizing
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

-- Plugin & terminal toggles
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", '<leader>"', ":vsplit | terminal<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":tabnew<CR>", { noremap = true, silent = true })

-- Scrolling shortcuts
vim.api.nvim_set_keymap("n", "<C-b>", "<C-d>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", "<C-u>", { noremap = true, silent = true })

-- Save shortcuts
vim.api.nvim_set_keymap("n", "<C-s>", ":update<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:update<CR>a", { noremap = true, silent = true })

-- Fast escape in insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true, silent = true})

-- Clipboard yank
vim.api.nvim_set_keymap("n", "<C-c>", '"+Y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Compilation shortcuts
vim.api.nvim_set_keymap("n", "<F5>", ":!g++ -std=c++17 % -o %< && ./%<<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<F6>",
	":!cmake -S . -B build && cmake --build build<CR>",
	{ noremap = true, silent = true }
)

-- Highlight on yank autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Map Ctrl+Shift+T to open a new empty tab
-- vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })
