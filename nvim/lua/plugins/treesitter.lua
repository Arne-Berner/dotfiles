return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false, -- since you already set events, you can set lazy=true or remove events; either way is fine
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.filetype.add({ extension = { wesl = "wesl" } })

    vim.treesitter.language.register("wgsl", "wesl", "lua")

    require("nvim-treesitter.configs").setup({
      ensure_installed = { "wgsl" },
      highlight = { enable = true },
    })
  end,
}
