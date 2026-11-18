return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- 🔥 ADD THIS DIAGNOSTIC CONFIG FIRST - FIX FOR NEOVIM 0.11.0
			vim.diagnostic.config({
				virtual_text = {
					enabled = true, -- This was disabled by default in 0.11.0!
					source = "if_many",
					prefix = "●",
					spacing = 4,
					format = function(diagnostic)
						return string.format("%s [%s]", diagnostic.message, diagnostic.source or "")
					end,
				},
				signs = {
					enabled = true,
					priority = 10,
				},
				underline = {
					enabled = true,
					severity = { min = vim.diagnostic.severity.HINT },
				},
				float = {
					enabled = true,
					source = "always",
					border = "rounded",
					format = function(diagnostic)
						return string.format("%s [%s]", diagnostic.message, diagnostic.source or "unknown")
					end,
				},
				severity_sort = true,
				update_in_insert = false,
			})

			-- Define diagnostic signs with icons
			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
				fg = "#FF6B6B",
				bg = "#4A1A1A", -- Dark red background
				italic = true,
				bold = true,
			})
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
				fg = "#FFE066",
				bg = "#4A4A1A", -- Dark yellow background
				italic = true,
				bold = true,
			})
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
				fg = "#7DD3FC",
				bg = "#1A3A4A", -- Dark blue background
				italic = true,
				bold = true,
			})
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {
				fg = "#C084FC",
				bg = "#3A1A4A", -- Dark purple background
				italic = true,
				bold = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				clangd = {},
				omnisharp = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim", "require" },
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
								},
							},
							codeLens = {
								enable = true,
							},
							hint = {
								enable = true,
								semicolon = "Disable",
							},
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"eslint-lsp",
				"typescript-language-server",
				"css-lsp",
				"html-lsp",
				"prettier",
				"gopls", -- Go language server
				"gofumpt", -- Formatter for Go
				"staticcheck",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = { "gopls" },
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
					["omnisharp"] = function()
						require("lspconfig").omnisharp.setup({
							capabilities = capabilities,
							cmd = {
								"dotnet",
								vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
							},
							enable_roslyn_analyzers = true,
							organize_imports_on_format = true,
							enable_import_completion = true,
						})
					end,
				},
			})
		end,
	},
}
