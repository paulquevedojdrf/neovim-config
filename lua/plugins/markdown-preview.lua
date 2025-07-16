return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = "cd app && npm install",
  config = function()
    vim.g.mkdp_auto_start = 0           -- Don't start automatically on file open
    vim.g.mkdp_auto_close = 1           -- Auto-close when buffer is deleted
    vim.g.mkdp_refresh_slow = 0         -- Auto-refresh on text change
    vim.g.mkdp_command_for_global = 0
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_browser = ""             -- Use system default browser
    vim.g.mkdp_theme = "dark"           -- or "light"
  end,
  cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" }
}
