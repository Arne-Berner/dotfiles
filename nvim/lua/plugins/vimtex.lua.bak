return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_latexmk = {
          build_dir = '',
          continuous = 1,
          executable = 'latexmk',
          options = {
            '-pdf',
            '-output-directory=output',
            --'-shell-escape',
          },
        }
    vim.g.vimtex_complete_enabled = 1
  end
}
