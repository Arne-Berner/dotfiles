local M = {}

local show_help = function()
  vim.cmd("split ~/dotfiles/nvim/TIPPS.md")
end
M.show_help = vim.api.nvim_create_user_command("ShowTipps",show_help,{})

return M
