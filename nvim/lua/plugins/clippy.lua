local M = {}
local vim = vim
local inspect = vim.inspect
-- _home_arne_dotfiles_playground__clippy.json
-- _home_arne_dotfiles_playground__clippy.json

-- Path for saving cached Clippy results
local cache_dir = vim.fn.stdpath("cache") .. "/clippy_results"
vim.fn.mkdir(cache_dir, "p") -- Ensure the directory exists

-- Utility function to calculate a cache file based on the project
local function get_cache_file()
  local project_id = vim.fn.fnamemodify(vim.fn.getcwd(), ":p"):gsub("[/:]", "_")
  return cache_dir .. "/" .. project_id .. "_clippy.json"
end

-- Check if cache exists
local function load_clippy_from_cache(cache_file)
  if vim.fn.filereadable(cache_file) == 1 then
    local content = table.concat(vim.fn.readfile(cache_file), "\n")
    return vim.fn.json_decode(content)
  end
  return nil
end

-- Save Clippy results to cache
local function save_clippy_to_cache(cache_file, data)
  local encoded = vim.fn.json_encode(data)
  vim.fn.writefile(vim.split(encoded, "\n"), cache_file)
end

local function find_suggested_replacements(node, replacements)
  -- Recursively search for all `suggested_replacement` values in the JSON structure
  if not node then
    return
  end

  if type(node) == "table" then
    for key, value in pairs(node) do
      if key == "suggested_replacement" and value and value ~= vim.NIL then
        table.insert(replacements, value)
      elseif type(value) == "table" then
        find_suggested_replacements(value, replacements) -- Recurse into nested tables
      end
    end
  end
end


local function fill_dict_with_entries(dict, data)
  for _, line in ipairs(data) do
    if line ~= "" then
      -- Decode Clippy JSON output
      local ok, item = pcall(vim.fn.json_decode, line)
      if ok and item and item.reason == "compiler-message" then
        local message = item.message
        if message and message.spans and #message.spans > 0 then
          for _, span in ipairs(message.spans) do
            local replacements = {}
            find_suggested_replacements(message, replacements)

            -- Format replacements for Telescope
            local entry = {
              filename = span.file_name,
              lnum = span.line_start,
              col = span.column_start,
              level = message.level:upper(),
              rendered = message.rendered or "Clippy diagnostic",
              replacements = #replacements > 0 and table.concat(replacements, "\n") or nil
            }
            table.insert(dict, entry)
          end
        end
      end
    end
  end
end

-- Run Clippy or load from cache
local function get_clippy_results(callback, force_refresh)
  local cache_file = get_cache_file()

  -- Try loading from cache if not forcing refresh
  if not force_refresh then
    local cached_results = load_clippy_from_cache(cache_file)
    if cached_results then
      vim.notify("Loaded Clippy results from cache.", vim.log.levels.INFO)
      callback(cached_results) -- Send cache directly to callback
      return
    end
  end

  -- Run Clippy job and process results
  vim.notify("Running Clippy...", vim.log.levels.INFO)
  local cmd = { "cargo", "clippy", "--message-format=json" }
  local diagnostics = {}

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data)
      -- Parse Clippy output
      if data then
        fill_dict_with_entries(diagnostics, data)
      end
    end,

    on_exit = function(_, exit_code)
      if exit_code == 0 then
        save_clippy_to_cache(cache_file, diagnostics)
        callback(diagnostics) -- Pass results to the callback
      else
        vim.notify("Clippy failed with exit code " .. exit_code, vim.log.levels.ERROR)
        callback({}) -- Pass empty table to the callback on failure
      end
    end,
  })
end

local function show_entries_with_telescope(diagnostics)
  if diagnostics and #diagnostics > 0 then
    require("telescope.pickers").new({}, {
      prompt_title = "Clippy Diagnostics",
      finder = require("telescope.finders").new_table {
        results = diagnostics,
        entry_maker = function(entry)
          local replacement_text = entry.replacements and ("\nSuggested replacement:\n" .. entry.replacements) or ""
          return {
            value = entry,
            display = entry.filename .. ":" .. entry.lnum .. ":" .. entry.col .. " | " .. entry.rendered:match("[^\n]*") .. " [...]",
            ordinal = entry.filename .. " " .. entry.rendered,
            filename = entry.filename,
            lnum = entry.lnum,
            col = entry.col,
            text = entry.rendered .. replacement_text,
            suggested_fixes = entry.replacements 
          }
        end
      },
      sorter = require("telescope.config").values.generic_sorter(),
      previewer = require("telescope.previewers").new_buffer_previewer({
        define_preview = function(self, entry, status)
          local bufnr = self.state.bufnr
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(entry.text, "\n"))
          vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
        end,
      }),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          require("telescope.actions").close(bufnr)
          if selection then
            -- Detect the current indentation level of the diagnostic line
            local indent_level = string.rep(" ", vim.fn.indent(selection.lnum))

            -- Adjust the suggested fix to match the indentation
            local indented_fixes = {}
            if selection.suggested_fixes then
              for _, line in ipairs(vim.split(selection.suggested_fixes, "\n")) do
                table.insert(indented_fixes, indent_level .. line)
              end
            end
            local indented_fixes_text = table.concat(indented_fixes, "")

            -- Copy the indented suggested fixes to a register
            if #indented_fixes > 0 then
              vim.fn.setreg('"', indented_fixes_text) -- Copy with indentation to clipboard register
              vim.notify('Copied indented suggested fixes to the " register:\n' .. indented_fixes_text, vim.log.levels.INFO)
            end

            -- Jump to the location in the file
            vim.cmd("edit " .. selection.filename)
            vim.fn.cursor(selection.lnum, selection.col)
          end
        end)
        return true
      end
    }):find()
  end
end


-- Function to display Clippy results in Telescope
local function clippy_cached(force_refresh)
  -- must be a callback, bc can't return in async inner function to outer
  get_clippy_results(function(diagnostics)
    -- Only show results if there are diagnostics
    show_entries_with_telescope(diagnostics)
    vim.notify("No Clippy diagnostics to show.", vim.log.levels.INFO)
  end, force_refresh)
end

local function run_clippy_with_telescope()
  local cmd = { "cargo", "clippy", "--message-format=json" }
  local diagnostics = {}

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data)
      if data then
        fill_dict_with_entries(diagnostics, data)
      end
    end,

    on_exit = function(_, exit_code)
      if exit_code == 0 then
        show_entries_with_telescope(diagnostics)
      elseif exit_code ~= 0 then
        vim.notify("Clippy process failed with code " .. exit_code, vim.log.levels.ERROR)
      else
        vim.notify("No diagnostics found!", vim.log.levels.INFO)
      end
    end
  })
end

local function run_clippy_and_fill_qf()
    -- Function to run Clippy and populate the quickfix list with its diagnostics
  local cmd = { "cargo", "clippy", "--message-format=json" }

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data)
      if data then

        -- Parse and populate quickfix list
        local qf_entries = {}

        fill_dict_with_entries(qf_entries, data)
        -- Populate the quickfix list
        vim.fn.setqflist(qf_entries, "r")
        if #qf_entries > 0 then
          vim.cmd("copen")
          vim.notify("Clippy diagnostics added to the quickfix list", vim.log.levels.INFO)
        else
          vim.notify("No diagnostics found!", vim.log.levels.INFO)
        end
      end
    end,
  })
end

M.run_clippy_with_telescope = vim.api.nvim_create_user_command(
  'TClippy',
  run_clippy_with_telescope,
  {}
)
M.run_clippy_plain = vim.api.nvim_create_user_command(
  'Clippy',
  run_clippy_and_fill_qf,
  {}
)
M.run_clippy_cached = vim.api.nvim_create_user_command("Clip", 
  function(opts)
    clippy_cached(opts.bang)
  end, { bang = true }
)
return M
