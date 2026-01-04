return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["<C-t>"] = false,
      ["t"] = { "actions.select", opts = { tab = true } },
      ["<space>cd"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    },
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  config = function(_, opts)
    -- Explicitly call the setup function
    require("oil").setup(opts)

    -- Optional: add a global keymap to invoke Oil
    vim.keymap.set("n", "-", function()
      require("oil").open()
    end, { desc = "Open parent directory" })
  end,
  lazy = false,
}
