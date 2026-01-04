-- fuzzy finding for lists
-- IMPORTANT: telescope sets the current directory to the first opened file
return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.1',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency
    {                        -- fzf-native dependency
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'         -- Ensures native fzf binary is built
    }
  },
  mappings = {
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    -- Setting up telescope with the desired fzf configurations
    telescope.setup {
      extensions = {
        fzf = {
          fuzzy = true,                   -- Enables fuzzy matching
          override_generic_sorter = true, -- Overrides the generic sorter
          override_file_sorter = true,    -- Overrides the file sorter
          case_mode = "smart_case",       -- Case sensitivity mode: smart_case
        }
      }
    }

    -- Loading the fzf extension
    telescope.load_extension('fzf')

    -- Setting up key bindings for telescope functions
    local set = vim.keymap.set
    set('n', '<C-T>t', builtin.git_files, {})  -- Uses git_files, if available
    set('n', '<C-T>z', builtin.buffers, {})    -- Opens list of buffers
    set('n', '<C-T>h', builtin.help_tags, {})  -- Search help tags
    set('n', '<C-T>r', builtin.find_files, {}) -- Search for files
    set('n', '<C-T>gr', builtin.live_grep, {}) -- Search for files
    set('n', '<C-T>gc', builtin.git_commits, {}) -- Search for files
    set('n', '<C-T>gs', builtin.git_status, {}) -- Search for files
    set('n', '<C-T>gb', builtin.git_branches, {}) -- Search for files
    set('n', '<C-T><C-t>', builtin.git_files, {})  -- Uses git_files, if available
    set('n', '<C-T><C-z>', builtin.buffers, {})    -- Opens list of buffers
    set('n', '<C-T><C-h>', builtin.help_tags, {})  -- Search help tags
    set('n', '<C-T><C-c>', builtin.find_files, {}) -- Search for files
    set('n', '<C-T><C-c>', builtin.git_commits, {}) -- Search for files
  end,
}
