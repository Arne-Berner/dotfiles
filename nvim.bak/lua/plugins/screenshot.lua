-- screenshot.lua
-- A fast way to implement a little Plugin
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

function minimize_window()
    local active_window = vim.fn.system("xdotool getactivewindow")
    local window_minimize = "xdotool windowminimize " .. active_window
    local result = vim.fn.system(window_minimize)
    return active_window
end

function bring_window_back(active_window)
    local make_window_active = "xdotool windowactivate " .. active_window
    vim.fn.system(make_window_active)
end


-- Function to take a screenshot
function take_screenshot(filename)
    create_resources_directory()
    local active_window = minimize_window()

    local gnome_screenshot = string.format("gnome-screenshot -a --file=%s/resources/%s.png", vim.fn.getcwd(), filename)
    local result = vim.fn.system(gnome_screenshot)
    print(result)

    bring_window_back(active_window)
end

local M = {}
-- Function to insert a link to the screenshot in the current buffer
function insert_screenshot_link(filename)
  take_screenshot(filename)
    local screenshot_path = string.format("./resources/%s.png", filename)
    local line_number = vim.fn.line('.')
    vim.api.nvim_buf_set_lines(0, line_number, line_number, false, {string.format("![%s](%s)", filename, screenshot_path)})
end
vim.cmd("command! -nargs=1 Screenshot lua insert_screenshot_link('<args>')")

return M
