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
        auto_insert_mode = true,

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
        }
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
