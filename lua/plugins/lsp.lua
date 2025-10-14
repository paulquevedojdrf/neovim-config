return {
  {
      "mason-org/mason.nvim",
      opts = {
          ui = {
              icons = {
                  package_installed = "✓",
                  package_pending = "➜",
                  package_uninstalled = "✗"
              },
          },
      },
  },
  {
      "mason-org/mason-lspconfig.nvim",
      opts = {
          ensure_installed = {
              "pyright",
              "clangd"
          },
          auto_install = true,
      },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    -- Ensures it attaches to the LSP server when opening a .py file.
    -- I'm not entirely sure why this is needed but things randomly stopped working
    -- after an update and this fixed it :shrug:
    ft = { "python", "c", "cpp" },

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local compile_commands = require("extras.compile_commands")
      local compile_commands_dir = compile_commands.get_compile_commands_dir()

      require("extras.tagjump").setup()

      -- Connect pyright to the nvim lsp client for completion
      -- pyright needs to be installed externally first via npm
      --    npm install -g pyright
      if vim.lsp.config then
        vim.lsp.config('pyright', {
          capabilities = capabilities,
          filetypes = { "python" },
        })
        vim.lsp.config('clangd', {
          capabilities = capabilities,
          filetypes = { "c", "cpp" },
          cmd = { "clangd", "--compile-commands-dir=" .. compile_commands_dir },
        })
        vim.lsp.enable('pyright')
        vim.lsp.enable('clangd')
      else
        -- Fallback to older lspconfig API
        require("lspconfig").pyright.setup({capabilities = capabilities })
      end
    end
  },
}
