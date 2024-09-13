-- paste-image.lua
-- creates the ressources directory if it doesn't exist
function create_resources_directory()
    print("directory")
    local dir_path = vim.fn.expand('%:p:h') .. '/resources'
    
    -- Check if the directory exists
    if vim.fn.isdirectory(dir_path) == 0 then
        -- If the directory doesn't exist, create it
        local cmd = string.format("mkdir %s", dir_path)
        vim.fn.system(cmd)
    end
end

local M = {}
-- Function to paste image to markdown file
function M.paste_image(filename)
    print("pasteimage")
    create_resources_directory()
    cmd = string.format("xclip -selection clipboard -t image/png -o > '%s/resources/%s.png'", vim.fn.getcwd(), filename)
    local result = vim.fn.system(cmd)
    print(result)
end

return M
