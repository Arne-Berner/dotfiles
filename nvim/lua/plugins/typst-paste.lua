-- paste-image.lua
-- creates the ressources directory if it doesn't exist
function create_resources_directory()
    local dir_path = vim.fn.expand('%:p:h') .. '/resources'
    
    -- Check if the directory exists
    if vim.fn.isdirectory(dir_path) == 0 then
        -- If the directory doesn't exist, create it
        local cmd = string.format("mkdir %s", dir_path)
        vim.fn.system(cmd)
    end
end

-- Function to paste image to markdown file
function paste_image(filename)
    create_resources_directory()
    cmd = string.format("xclip -selection clipboard -t image/png -o > '%s/resources/%s.png'", vim.fn.getcwd(), filename)
    local result = vim.fn.system(cmd)
    print(result)
end

-- Function to insert a link to the pasted image in the current buffer
function insert_paste_image_link(filename)
    local screenshot_path = string.format("./resources/%s.png", filename)
    local line_number = vim.fn.line('.')
    vim.api.nvim_buf_set_lines(0, line_number, line_number, false, {string.format("#figure(image(\"%s\"), caption: [%s])", screenshot_path, filename)})
end

return {
  -- Define a command to take a screenshot and insert a link to it
  vim.cmd("command! -nargs=1 TypstPaste lua paste_image('<args>'); insert_paste_image_link('<args>')")
}
