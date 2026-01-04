-- lsp
return	{
  {
		'neovim/nvim-lspconfig',
		config = function()
			-- Setup language servers.
			local lspconfig = vim.lsp.config

      --python
      vim.lsp.enable("pyright")

      -- WGSL 
      vim.lsp.enable('wgsl_analyzer')
      lspconfig.wgsl_analyzer.filetypes = {"wgsl", "wesl"}

			-- Rust
      vim.lsp.enable("rust_analyzer")
			lspconfig.rust_analyzer = {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
            procMacro = {
                    ignored = {
                        leptos_macro = {
                            -- optional: --
                            -- "component",
                            "server",
                        },
                    },
                  },
						cargo = {
							allFeatures = true,
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
					},
				},
			}

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.buf` and vim.diagnostic for documentation on any of the below functions
          -- the normal map for them is 
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'grd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'grO', vim.diagnostic.setqflist, opts)
					vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<F3>', function()
						vim.lsp.buf.format { async = true }
					end, opts)

				end,
			})
		end
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
---@diagnostic disable-next-line: unused-local
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require "lsp_signature".setup({
				doc_lines = 0,
				handler_opts = {
					border = "none"
				},
			})
		end
	},


	-- language support
	-- toml
	'cespare/vim-toml',

	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- rust
	{
		'rust-lang/rust.vim',
		ft = { "rust" },
		config = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rustfmt_emit_files = 1
			vim.g.rustfmt_fail_silently = 0
			vim.g.rust_clip_command = 'wl-copy'
		end
	},
	-- markdown
	{
		'plasticboy/vim-markdown',
		ft = { "markdown" },
		dependencies = {
			'godlygeek/tabular',
		},
		config = function()
			-- never ever fold!
			vim.g.vim_markdown_folding_disabled = 1
			-- support front-matter in .md files
			vim.g.vim_markdown_frontmatter = 1
			-- 'o' on a list item should insert at same level
			vim.g.vim_markdown_new_list_item_indent = 0
			-- don't add bullets when wrapping:
			-- https://github.com/preservim/vim-markdown/issues/232
			vim.g.vim_markdown_auto_insert_bullets = 0
		end
	},
}
