return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = function(lang, buf)
                     local ft = vim.bo[buf].filetype
                    -- Disable for CopilotChat and similar non-code buffers
                    return ft == "copilot-chat" or ft == "copilot" or ft == "markdown" and vim.api.nvim_buf_get_name(buf):match("CopilotChat")
                end,
            },
            indent = {
                enable = true,
                disable = { "cmake", "copilot-chat" },
            },
            autotag = {
                enable = true,
            },
            ensure_installed = {
                "json",
                "json5",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "c",
                "cpp",
                "rust",
                "make",
                "matlab",
                "objdump",
                "proto",
                "python",
                "cmake",
                "kconfig",
                "linkerscript",
                "toml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            rainbow = {
                enable = true,
                disable = { "html" },
                extended_mode = false,
                max_file_lines = nil,
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}
