return {
	{
		"tpope/vim-sleuth",
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},
		{ -- Useful plugin to show you pending keybinds.
			"folke/which-key.nvim",
			event = "VimEnter", -- Sets the loading event to 'VimEnter'
			config = function() -- This is the function that runs, AFTER loading
				require("which-key").setup()

				-- Document existing key chains
				require("which-key").add({
					{ "<leader>c", group = "[C]ode" },
					{ "<leader>d", group = "[D]ocument" },
					{ "<leader>r", group = "[R]ename" },
					{ "<leader>s", group = "[S]earch" },
					{ "<leader>w", group = "[W]orkspace" },
					{ "<leader>t", group = "[T]oggle" },
					{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
				})
			end,
		},
		{
			-- used for completion, annotations and signatures of Neovim apis
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
		-- Highlight todo, notes, etc in comments
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		-- Line on bottom
		{
			"akinsho/bufferline.nvim",
			event = "VeryLazy",
			keys = {
				{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
				{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
			},
			opts = {
				options = {
					mode = "tabs",
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			event = "VeryLazy",
			opts = function()
				return {
					options = {
						theme = "powerline", -- You can choose any theme you prefer
						section_separators = "",
						component_separators = "",
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff", "diagnostics" },
						lualine_c = { "filename" },
						lualine_x = { "encoding", "fileformat", "filetype" },
						lualine_y = { "progress" },
						lualine_z = {
							{ "location" },
							{
								"cwd",
								function()
									return vim.fn.getcwd()
								end,
							},
						},
					},
					extensions = { "fzf", "quickfix", "nvim-tree" },
				}
			end,
		},
		{
			"nvimdev/dashboard-nvim",
			event = "VimEnter",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local db = require("dashboard")

				-- Function to get current date and time
				local function get_datetime()
					return os.date(" %A, %B %d   %H:%M")
				end

				vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#fd7e14", bold = true }) -- Orange for header
				vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#00ff00", bold = true })

				db.setup({
					theme = "doom",
					config = {
						header = {
							"",
							--	" ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷ ",
							--	" ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇ ",
							--	" ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽ ",
							--	" ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕ ",
							--	" ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕ ",
							--	" ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕ ",
							--	" ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄ ",
							--	" ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕ ",
							--	" ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿ ",
							--	" ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ",
							--	" ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟ ",
							--	" ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠ ",
							--	" ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙ ",
							--	" ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣ ",
							"",
							get_datetime(), -- Insert dynamic date and time here
							"",
							"",
						},
						center = {
							{
								icon = " ",
								desc = "Find File                              ",
								key = "f",
								action = "Telescope find_files",
							},
							{
								icon = " ",
								desc = "Recent Files",
								key = "r",
								action = "Telescope oldfiles",
							},
							{
								icon = " ",
								desc = "Find Word",
								key = "fw",
								action = "Telescope live_grep",
							},
							{
								icon = " ",
								desc = "File Explorer",
								key = "e",
								action = "NvimTreeToggle",
							},
							{
								icon = " ",
								desc = "Config",
								key = "c",
								action = "edit ~/.config/nvim/init.lua",
							},
							{
								icon = " ",
								desc = "Quit Neovim",
								key = "q",
								action = "qa",
							},
						},
						vertical_center = true,
						highlight = {
							header = "DashboardHeader", -- Apply header highlight (Red)
							center = "DashboardCenter", -- Apply center highlight (Green for left, Red for right)
						},
					},
				})
			end,
		},
	},
	{ "rafamadriz/friendly-snippets" },
	{
		"folke/twilight.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
