local M = {}
local vim = vim
-- Session manager using Telescope
-- Define your sessions directory (adjust if necessary)
local sessions_dir = vim.fn.stdpath("cache") .. "/sessions"

-- Ensure the sessions directory exists
if vim.fn.isdirectory(sessions_dir) == 0 then
    vim.fn.mkdir(sessions_dir, "p")
end

-- Function to save a session with a specific name
local function save_session(session_name)
    if not session_name then
        print("Specify a session name to save!")
        return
    end
    local session_path = sessions_dir .. "/" .. session_name .. ".vim"
    vim.cmd("mksession! " .. session_path)
    print("Session saved to: " .. session_path)
end

-- Function to load a session with a specific name
local function load_session(session_name)
    if not session_name then
        print("Specify a session name to load!")
        return
    end
    local session_path = sessions_dir .. "/" .. session_name .. ".vim"
    if vim.fn.filereadable(session_path) == 1 then
        vim.cmd("source " .. session_path)
        print("Session loaded from: " .. session_path)
    else
        print("No session file found with name: " .. session_name)
    end
end

-- Telescope-based session loader
local function telescope_load_session()
    local session_files = vim.fn.globpath(sessions_dir, "*.vim", false, true)
    local sessions = {}
    for _, session_path in ipairs(session_files) do
        table.insert(sessions, vim.fn.fnamemodify(session_path, ":t:r"))
    end

    -- Use Telescope to pick a session
    require("telescope.pickers").new({}, {
        prompt_title = "Select a Session to Load",
        finder = require("telescope.finders").new_table({
            results = sessions,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", function()
                local selection = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                if selection then
                    load_session(selection.value)
                end
            end)
            return true
        end,
    }):find()
end

-- Create commands for managing sessions
M.save = vim.api.nvim_create_user_command("Save", function(args)
    save_session(args.args)
end, { nargs = 1, desc = "Save session with a specific name" })

M.load = vim.api.nvim_create_user_command("Load", function()
    telescope_load_session()
end, { desc = "Load session interactively using Telescope" })

return M
