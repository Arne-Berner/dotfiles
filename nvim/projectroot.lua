return	{
  'notjedi/nvim-rooter.lua',
  config = function()
  require('nvim-rooter').setup {
    rooter_patterns = { '.git'},
    trigger_patterns = { '*' },
    manual = false,
    fallback_to_parent = false,
  }
  end
}
