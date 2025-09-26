return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",

    -- lazy load CopilotChat. This avoids spawning the github/copilot.vim pluging until needed
    cmd = "CopilotChat",
    lazy = true,

    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
        -- model = 'gpt-4.1', -- AI model to use
        model = 'claude-sonnet-4',
        temperature = 0.1, -- Lower = focused, higher = creative
        chat_autocomplete = false,

        headers = {
            user = '👤 You',
            assistant = '🤖 Copilot',
            tool = '🔧 Tool',
        },

        separator = '━━',
        auto_fold = true, -- Automatically folds non-assistant messages

        prompts = {
            PyTest = {
                prompt = "#buffers:all\n" ..
                         "Write unit-tests for this code using the unittest framework\n" ..
                         "Ensure at least 80% code coverage"
            },
            GTest = {
                prompt = "#buffers:all\n" ..
                         "Write unit-tests for this code using the googletest framework\n" ..
                         "Ensure at least 80% code coverage"
            }
        },
        mappings = {
            -- press ss to add the text "#buffers:all` into the chat window
            share_buffer = {
                normal = 'ss',
                callback = function()
                    local copilot = require("CopilotChat")

                    local text = "#buffers:all"
                    local row,col = unpack(vim.api.nvim_win_get_cursor(copilot.chat.winnr))
                    vim.api.nvim_buf_set_lines(copilot.chat.bufnr, row-1, row, false, {text,""})
                    vim.api.nvim_win_set_cursor(copilot.chat.winnr, {row+1, col})
                end
            },
        },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
