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
			local lsp = vim.lsp
      local api = vim.api


      --tinymist
      lsp.enable("tinymist")
      lspconfig.tinymist = {
        on_attach = function(client, bufnr)
          api.nvim_create_user_command("TinymistPin",  function()
            client:exec_cmd({
              title = "pin",
              command = "tinymist.pinMain",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})
        
          api.nvim_create_user_command("TinymistUnpin", function()
            client:exec_cmd({
              title = "unpin",
              command = "tinymist.pinMain",
              arguments = { vim.v.null },
            }, { bufnr = bufnr })
          end, {})

          -- TODO needs a page number to work correctly
          api.nvim_create_user_command("TinymistSVG",  function()
            client:exec_cmd({
              title = "exportSvg",
              command = "tinymist.exportSvg",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

          api.nvim_create_user_command("TinymistHTML",  function()
            client:exec_cmd({
              title = "exportHtml",
              command = "tinymist.exportHtml",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

          -- TODO needs a page number to work correctly
          api.nvim_create_user_command("TinymistPNG",  function()
            client:exec_cmd({
              title = "exportPng",
              command = "tinymist.exportPng",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

          api.nvim_create_user_command("TinymistThumbnail", function()
            vim.fn.jobstart({
              "typst",
              "compile",
              "-f", "png",
              "--pages", "1",
              "--ppi", "250",
              "main.typ",
              "thumbnail.png"
            }, {
              stdout_buffered = true,
              stderr_buffered = true,
              on_stdout = function(_, data)
                if data then
                  print(table.concat(data, "\n"))
                end
              end,
              on_stderr = function(_, data)
                if data then
                  print("Error: " .. table.concat(data, "\n"))
                end
              end,
              on_exit = function(_, exit_code)
                if exit_code == 0 then
                  print("✔ Successfully generated thumbnail: thumbnail.png")
                else
                  print("✘ Failed to generate thumbnail!")
                end
              end,
            })
          end, {})
        end,
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onSave",
          -- semanticTokens = "disable",
        },
      }


      --python
      lsp.enable("pyright")

      -- WGSL 
      lsp.enable('wgsl_analyzer')
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
            -- too slow
            --[[
            check = {
              command = "clippy",
            },
            --]]
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
