-- https://davelage.com/posts/nvim-dap-getting-started/
-- This needs lua installed and lua-toml installed via luarocks
local get_name = function()
-- Load the lua-toml library
local toml = require("toml")

-- Define a function to read the TOML file and extract the value
local function read_toml_file(file_path)
    -- Open the TOML file in read mode
    local file = io.open(file_path, "r")
    if not file then
        return nil
    end
    
    -- Read the content of the TOML file
    local toml_content = file:read("*a")
    file:close()
    
    -- Parse the TOML content
    local parsed_toml = toml.parse(toml_content)
    
    -- Get the value associated with the key "name"
    local name = parsed_toml.package.name
    
    -- Return the extracted value
    return name
end

-- Example usage:
local current_directory = vim.fn.getcwd()
local toml_file_path = current_directory .. "/Cargo.toml"
local name = read_toml_file(toml_file_path)
return name
end

return {
  {
    -- Debugging
    'mfussenegger/nvim-dap',
    config = function()

      local dap = require("dap")
      -- setup adapter
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }

      -- config 
      -- this can also be configured via the launch file in .vscode
      -- Path to codelldb executable

      local current_directory = vim.fn.getcwd()
      local name = get_name()
      if name ~= nil then
        dap.configurations.rust = {
          {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = current_directory .. "/target/debug/" .. name,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
          },
        }
      end


      -- Keybindings or commands to start debugging sessions
      vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<S-F11>', '<cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
      
      -- These are to override the default highlight groups for catppuccin (see https://github.com/catppuccin/nvim/#special-integrations)
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
  end
  },
  {
'rcarriga/nvim-dap-ui',
config = function()
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup()
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end
}

}
