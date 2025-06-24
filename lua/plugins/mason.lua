return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      print("mason.nvim setup")
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      print("mason-lspconfig setup")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      local function find_root(fname)
        print("find_root called for:", fname)
        local util = require("lspconfig.util")
        return util.root_pattern(".west")(fname)
          or util.find_git_ancestor(fname)
          or vim.loop.cwd()
      end

      local function on_attach(client, bufnr)
        print("on_attach")
        print("LSP attached:", client.name, "bufnr:", bufnr)
        vim.notify("LSP attached: " .. client.name)
      end

      mason_lspconfig.setup({
        ensure_installed = { "clangd" },
        handlers = {
          function(server_name)
            print("Setting up LSP server")
            print("Setting up LSP server:", server_name)
            lspconfig[server_name].setup({
              root_dir = find_root,
              on_attach = on_attach,
              capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
          end,
        },
      })
    end,
  },
}
