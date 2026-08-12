return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"go",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"css",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = {},
			},
			indent = { enable = true },
		},
		config = function(_, opts)
			-- ---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
