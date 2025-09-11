return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Connect pyright to the nvim lsp client for completion
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
      })
    end
  }
}
