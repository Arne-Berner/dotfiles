local M = {}

local notizen = function()
  vim.cmd("split ~/Notizen")
end
M.noti = vim.api.nvim_create_user_command("No",notizen,{})
M.notizen = vim.api.nvim_create_user_command("Notizen",notizen,{})

return M
