-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        path_display = { "smart" },
        -- ignore .git, __pycache__, env*, venv*
        file_ignore_patterns = { ".git/", "__pycache__/", "^env.*", "^venv.*" },
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
      },
      pickers = {
        find_files = {
          -- use ripgrep and ignore .git, __pycache__, env*, venv*
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob", "!**/.git/*",
            "--glob", "!**/__pycache__/*",
            "--glob", "!**/env*/**",
            "--glob", "!**/venv*/**",
          },
        },
      },
    })

    -- get project root: try `west topdir` → git root → cwd
    local function get_project_root()
      local west_root = vim.fn.systemlist("west topdir")[1]
      if vim.v.shell_error == 0 and west_root ~= "" then
        return west_root
      end

      local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      if vim.v.shell_error == 0 and git_root ~= "" then
        return git_root
      end

      return vim.loop.cwd()
    end

    -- Telescope pickers with project root cwd
    local function project_files()
      local ok = pcall(builtin.git_files, { show_untracked = true, cwd = get_project_root() })
      if not ok then
        builtin.find_files({ cwd = get_project_root() })
      end
    end

    -- Live grep session from the project root directory
    local function live_grep_project_root()
      builtin.live_grep({ cwd = get_project_root() })
    end

    -- Live grep through all matches for the word currently under the cursor
    local function grep_word_under_cursor()
      local word = vim.fn.expand("<cword>") -- word under cursor
      if word == "" then return end
      builtin.grep_string({ cwd = get_project_root(), search = word })
    end

    -- Keymaps (Note: Leader is typically set to `space`)
    -- After picking a file, if you want to jump back to the previous location, use `<C-o>` in normal mode.
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "[F]ind by [G]rep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "[F]ind [B]uffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>pf", project_files,          { desc = "[P]roject [F]iles (from project root)" })
    vim.keymap.set("n", "<leader>pg", live_grep_project_root, { desc = "[P]roject [G]rep (from project root)" })
    vim.keymap.set("n", "<leader>po", grep_word_under_cursor, { desc = "[P]roject grep [O]n Cursor (from project root)" })
  end,
}

