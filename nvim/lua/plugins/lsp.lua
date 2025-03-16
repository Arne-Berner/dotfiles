-- lsp
return {
  {
    "neovim/nvim-lspconfig",

<<<<<<< Updated upstream
      -- WGSL 
||||||| Stash base
      --python
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      lspconfig.pyright.setup{
        capabilities=capabilities,
      }

      -- WGSL 
=======
    config = function()
      -- Setup language servers.
      local lspconfig = require("lspconfig")

      -- Setup language servers.
      -- WGSL
>>>>>>> Stashed changes
      -- lspconfig.wgsl_analyzer.setup {}
<<<<<<< Updated upstream
      lspconfig.wgsl_analyzer.setup({
      })
      
			-- Rust
			lspconfig.rust_analyzer.setup {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
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
					-- See `:help vim.lsp.*` for documentation on any of the below functions
          -- might want to use <C-g> instead of space?
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', '<space>d', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', '<space><space>', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, opts)
          -- will show diagnostics
					vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next, opts)
					vim.keymap.set('n', '<space>p', vim.diagnostic.goto_prev, opts)
					--vim.keymap.set('n', '<space>n', vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set('n', '<leader>wl', function()
						-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
					--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<space>r', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<F3>', function()
						vim.lsp.buf.format { async = true }
					end, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
					-- *and* there's some way to make it only apply to the current line.
					-- if client.server_capabilities.inlayHintProvider then
					--     vim.lsp.inlay_hint(ev.buf, true)
					-- end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
          -- TODO maybe use this for no treesitter?
					--client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
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


  -- typst
  {
      require'lspconfig'.typst_lsp.setup{
      settings = {
        exportPdf = "onType" -- Choose onType, onSave or never.
            -- serverPath = "" -- Normally, there is no need to uncomment it.
      }
    }
||||||| Stash base
      lspconfig.glasgow.setup {}
      
			-- Rust
			lspconfig.rust_analyzer.setup {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
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
					-- See `:help vim.lsp.*` for documentation on any of the below functions
          -- might want to use <C-g> instead of space?
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', '<space>d', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', '<space><space>', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, opts)
          -- will show diagnostics
					vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next, opts)
					vim.keymap.set('n', '<space>p', vim.diagnostic.goto_prev, opts)
					--vim.keymap.set('n', '<space>n', vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set('n', '<leader>wl', function()
						-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
					--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts).bak
					vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<F3>', function()
						vim.lsp.buf.format { async = true }
					end, opts)


          local function refs()
            vim.lsp.buf.references()
            vim.cmd([[
                augroup CloseQuickfixOnLeave
                autocmd!
                autocmd WinLeave * if &filetype == 'qf' | q |
                autocmd FileType qf nnoremap <buffer> <esc> :q<cr>
                augroup END
            ]])
          end

					vim.keymap.set('n', '<space>r', refs, opts)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
					-- *and* there's some way to make it only apply to the current line.
					-- if client.server_capabilities.inlayHintProvider then
					--     vim.lsp.inlay_hint(ev.buf, true)
					-- end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
          -- TODO maybe use this for no treesitter?
					--client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
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


  -- typst
  {
      require'lspconfig'.typst_lsp.setup{
      settings = {
        exportPdf = "onType" -- Choose onType, onSave or never.
            -- serverPath = "" -- Normally, there is no need to uncomment it.
      }
    }
=======
      lspconfig.wgsl_analyzer.setup({})
    end,
>>>>>>> Stashed changes
  },
}

