-- lsp
return	{
  {
		'neovim/nvim-lspconfig',
		config = function()
      -- :help lsp-defaults
      -- :help diagnostic-defaults
      -- :help lsp-attach
      -- :help lsp-buf
			-- Setup language servers.
			local lspconfig = vim.lsp.config

      --python
      vim.lsp.enable("pyright")

      -- WGSL 
      vim.lsp.enable('wgsl_analyzer')
      lspconfig.wgsl_analyzer.filetypes = {"wgsl", "wesl"}

			-- Rust
      vim.lsp.enable("rust_analyzer")
      -- https://rust-analyzer.github.io/book/configuration.html
			lspconfig.rust_analyzer = {
        on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
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
            -- checkOnSave = true -- default
            -- features: completion
						cargo = {
							features = "all",
              allTargets = true,
              -- extraArgs
              -- extraEnv
						},
            check = {
              command = "clippy",
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

}
