return {
	-- 1. Sonokai (Active)
	{
		"sainnhe/sonokai",
		priority = 1000,
		config = function()
			vim.g.sonokai_transparent_background = "1"
			vim.g.sonokai_enable_italic = "1"
			-- Styles: "default", "atlantis", "andromeda", "shusia", "maia", "espresso"
			vim.g.sonokai_style = "atlantis"
			vim.cmd.colorscheme("sonokai")
		end,
	},

	-- 2. Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				-- Flavours: "latte", "frappe", "macchiato", "mocha"
				flavour = "mocha",
				transparent_background = true,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- 3. OneDark
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				-- Styles: "dark", "darker", "cool", "deep", "warm", "warmer", "light"
				style = "darker",
				transparent = true,
				code_style = {
					comments = "italic",
					keywords = "italic",
				},
			})
			require("onedark").load()
		end,
	},

	-- 4. Gruvbox Material
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_enable_italic = true
			-- Background: "hard", "medium", "soft"
			vim.g.gruvbox_material_background = "hard"
			-- Foreground: "material", "mix", "original"
			vim.g.gruvbox_material_foreground = "material"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	-- 9. Eldritch
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("eldritch").setup({
				-- Palette: "default", "dark"
				palette = "default",
				transparent = true,
				--terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
				},
			})
			vim.cmd.colorscheme("eldritch")
		end,
	},

	-- 10. Fluoromachine
	{
		"maxmx03/fluoromachine.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("fluoromachine").setup({
				-- Themes: "fluoromachine", "retrowave", "delta"
				theme = "delta",
				glow = false,
				brightness = 0.05,
			})
			vim.cmd.colorscheme("fluoromachine")
		end,
	},
}
