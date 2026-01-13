-- lsp
return {
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

      --grammar
      -- typst, md, latex, txt
      local dict_path = vim.fn.stdpath("cache") .. "/ltex_plus/dict_de"
      local function AddWordsToFiles(path, words)
        local open_file = io.open(path, "a+")
        if open_file then
          for _, word in ipairs(words) do
            open_file:write(word .. "\n")
          end
          open_file:close()
        else
          return print("Failed insert %q", vim.inspect(words))
        end
      end

      lsp.enable("ltex_plus")
      local wkspc = "workspace/didChangeConfiguration"
      local on_attach = function(client, bufnr)
        local addToDict = function(command, _)
          for _, arg in ipairs(command.arguments) do
            for lang, words in pairs(arg.words) do
              -- this would need to be the std dictionary or 
              AddWordsToFiles(dict_path, words)
            end
          end
          client.config.settings.ltex.dictionary = {
            ["de-DE"] = ":" .. dict_path
          }
          -- notify the client of the new settings
          return client.notify(wkspc, client.config.settings)
        end
        vim.lsp.commands["_ltex.addToDictionary"] = addToDict
      end
      lspconfig.ltex_plus = {
        -- on_attach = addToDict,
        on_attach = on_attach,
        cmd = { "ltex-ls-plus" },
        settings = {
          ltex = {
            language = "de-DE",
            diagnostics = {
              checkOnOpen = true,
              checkOnChange = true,
            },
            completion = {
              enabled = true,
            },
            --[[ does not work yet, because dict is not read.
            dictionary = {
              ["de-DE"] = ":" .. dict_path
            },
            hiddenFalsePositives = {
              ["de"] = { vim.fn.stdpath("cache") .. "/ltex_plus/hidden_false_de" }
            },
            disabledRules = {
              ["de"] = { vim.fn.stdpath("cache") .. "/ltex_plus/disable_de" }
            },
            --]]
          },
        },
      }

      --tinymist
      lsp.enable("tinymist")
      lspconfig.tinymist = {
        on_attach = function(client, bufnr)
          -- Define a helper to pin "main.typ"
          local pin_main_typ_file = function()
            -- Search for "main.typ" in the workspace
            local main_file = vim.fn.findfile("main.typ", ".;") -- Search "main.typ" in the current working directory
            if main_file ~= "" then
              -- Automatically pin "main.typ" if found
              client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { vim.fn.fnamemodify(main_file, ":p") }, -- Get absolute path of "main.typ"
              }, { bufnr = bufnr })
            else
              -- Notify the user if "main.typ" is not found
              api.nvim_err_writeln("Could not find 'main.typ' in the workspace directory.")
            end
          end

          -- Automatically pin "main.typ" on attach
          api.nvim_create_user_command("PinMain", function()
            pin_main_typ_file()
          end, {})

          -- Optional: Add a manual command for pinning if needed
          api.nvim_create_user_command("TinyPin", function()
            client:exec_cmd({
              title = "pin",
              command = "tinymist.pinMain",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

        
          api.nvim_create_user_command("TinyUnpin", function()
            client:exec_cmd({
              title = "unpin",
              command = "tinymist.pinMain",
              arguments = { vim.v.null },
            }, { bufnr = bufnr })
          end, {})

          api.nvim_create_user_command("TinyInfo", function()
            client:exec_cmd({
              title = "unpin",
              command = "tinymist.getServerInfo",
              arguments = { vim.v.null },
            }, { bufnr = bufnr })
          end, {})

          api.nvim_create_user_command("TinyHTML", function()
            client:exec_cmd({
              title = "unpin",
              command = "tinymist.pinMain",
              arguments = { vim.v.null },
            }, { bufnr = bufnr })
          end, {})

          -- TODO needs a page number to work correctly
          api.nvim_create_user_command("TinySVG",  function()
            client:exec_cmd({
              title = "exportSvg",
              command = "tinymist.exportSvg",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

          api.nvim_create_user_command("TinyHTML",  function()
            client:exec_cmd({
              title = "exportHtml",
              command = "tinymist.exportHtml",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

          -- TODO needs a page number to work correctly
          api.nvim_create_user_command("TinyPNG",  function()
            client:exec_cmd({
              title = "exportPng",
              command = "tinymist.exportPng",
              arguments = { api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
          end, {})

          api.nvim_create_user_command("TinyThumbnail", function()
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
      lspconfig.wgsl_analyzer.filetypes = { "wgsl", "wesl" }

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
