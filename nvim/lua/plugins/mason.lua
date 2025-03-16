return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require('mason-nvim-dap').setup({ ensure_installed={"codelldb"} })
    end
  }
}
