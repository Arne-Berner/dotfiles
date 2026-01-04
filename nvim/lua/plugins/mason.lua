return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({ ensure_installed={"pyright", "rust_analyzer", "wgsl_analyzer", "tinymist" }})
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require('mason-nvim-dap').setup({ ensure_installed={"codelldb"}})
    end
  }
}
