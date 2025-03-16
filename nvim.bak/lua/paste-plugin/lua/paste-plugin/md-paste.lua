local paste = require("paste-plugin.paste")
local M = {}

-- Function to insert a link to the pasted image in the current buffer
function M.insert_image_md(filename)
  paste.paste_image(filename)
  local screenshot_path = string.format("./resources/%s.png", filename)
  local line_number = vim.fn.line('.')
  vim.api.nvim_buf_set_lines(0, line_number, line_number, false, {string.format("![%s](%s)", filename, screenshot_path)})
end

return M

