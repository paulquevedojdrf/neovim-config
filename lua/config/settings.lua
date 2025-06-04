local global = vim.g
local o = vim.opt

vim.cmd.colorscheme('pquevedo') -- ~/.config/nvim/colors
vim.cmd("syntax enable") -- Enable syntax highlighting
vim.cmd("filetype plugin indent on") -- Enable file type detection and plugins

-- Editor options
-------------------------------------------------------------------------------------------------------
o.number = false -- Print the line number in front of each line
o.relativenumber = false -- Show the line number relative to the line with the cursor in front of each line.
o.clipboard = "unnamedplus" -- uses the clipboard register for all operations except yank.
o.autoindent = true -- Copy indent from current line when starting a new line.
o.smartindent = true -- When on, Vim will try to be smart about indenting.
o.cursorline = false -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
o.shiftround = true -- When on, the indent of a line is changed to the indent of the line above it.
o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
o.softtabstop = 4 -- Number of spaces that a <Tab> counts for while editing.
o.smarttab = true -- When on, <Tab> and <BS> will use the same number of spaces as 'shiftwidth' for indenting.
o.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
o.ruler = true -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "" -- If "a" then the mouse can be used to enter visual mode but you loose the ability to highlight text to copy so use "" instead
o.title = true -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = "split" -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.splitright = true
o.splitbelow = true -- When on, splitting a window will put the new window below the current one
o.termguicolors = false -- Disable 24-bit RGB color in the TUI
o.wildmode = "longest,list,full" -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.ignorecase = true -- When on, case is ignored in file names and search patterns
o.smartcase = true -- unless the search pattern contains upper case characters. In that case, the search is case sensitive.
o.wrap = false -- When on, long lines are not wrapped and can be scrolled horizontally.
o.laststatus = 2 -- When set to 2, the last window will always have a status line.
o.tags = "./tags;/" -- This will look in the current directory for <tags>, and work up the tree towards root until one is found.
o.incsearch = true -- When on, the search command will show matches for each typed character.
o.backup = true -- When on, a backup file is created when a file is edited.
o.backspace = { "indent", "eol", "start" } -- This option controls how Vim handles backspacing over autoindent, line breaks and start of insert.
o.hlsearch = true -- When on, all search patterns are highlighted.
o.numberwidth = 6 -- Set the width of the number column to 6 characters
o.list = true -- Show whitespace characters
o.listchars = { tab = "▸ ", trail = "·" } -- Show whitespace characters
o.encoding = 'utf-8' -- Set the encoding to UTF-8
o.fileencoding = 'utf-8' -- Set the file encoding to UTF-8
o.formatoptions:append("o") -- When on, pressing <Enter> in Insert mode will start a new line and insert the same text as the previous line.

-- Status line
-------------------------------------------------------------------------------------------------------
o.statusline = table.concat({
  "%{fugitive#statusline()}",        -- Git info from Fugitive
  " %<%F%*",                          -- Full path, truncate if too long
  "%m%*",                             -- Modified flag
  "%=%P ",                            -- Percentage through file
  "%1*%5l%*",                         -- Current line number
  "%2*/%L%*",                         -- Total lines
  "%4v%*",                            -- Virtual column number
  "  %{&ff}%*",                       -- File format
  "%y%*"                              -- File type
})

-- Keymaps
-------------------------------------------------------------------------------------------------------
vim.keymap.set('n', '<F12>', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<F9>", ":setlocal spell! spelllang=en_us<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F3>", ":set invnumber<CR> :set invcursorline<CR>", { noremap = true, silent = true })
-- More tolerant tag lookup instead of just jumping to first available option
vim.keymap.set('n', '<C-]>', 'g<C-]>', { noremap = true })

-- Insert a divider comment line
vim.keymap.set('i', '<C-l>', '/******************************************************************************/', { noremap = true })
-- Insert a block header comment
vim.keymap.set('i', '<C-b>', '/*******************************************************************************\n\x0d\x08\x08\x08 *\n\x08\x08\x08 *******************************************************************************/', { noremap = true })

-- Global renaming of text under the cursor
vim.keymap.set('n', 'gr', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true, silent = false })

-- Autocommands
-------------------------------------------------------------------------------------------------------

-- When opening a file jump to the last known cursor position (if available)
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Remove trailing whitespace for each line on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

-- Register .tpp files as C++ files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.tpp",
    callback = function()
        vim.bo.filetype = "cpp"
    end,
})
