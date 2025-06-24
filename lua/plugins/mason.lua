return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local compile_commands = require("utils.compile_commands")

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local function find_root(fname)
        local util = require("lspconfig.util")
        return util.root_pattern(".west")(fname)
            or util.find_git_ancestor(fname)
            or vim.loop.cwd()
      end

      local function on_attach(client, bufnr)
        print("clangd attached to buffer", bufnr)
        if client.name == "clangd" then
          local root_dir = client.config.root_dir
          local merged_file = compile_commands.get_merged_compile_commands_file(root_dir)
          if merged_file then
            vim.notify("Using merged compile_commands.json at " .. merged_file)
          else
            vim.notify("No compile_commands.json files found to merge.")
          end
        end
      end

      lspconfig.clangd.setup({
        capabilities = capabilities,
        root_dir = find_root,
        on_attach = on_attach,
        cmd = (function()
            local root_dir = find_root(vim.api.nvim_buf_get_name(0))
            local merged_file = compile_commands.get_merged_compile_commands_file(root_dir)
            if merged_file then
                local merged_dir = vim.fn.fnamemodify(merged_file, ":h")
                return {
                    "clangd",
                    "--compile-commands-dir=" .. merged_dir,
                }
            else
                return { "clangd" }
            end
        end)(),
      })
    end,
  },
}
