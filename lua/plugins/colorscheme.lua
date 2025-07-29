--[[
return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark" -- Set to dark mode
      require("gruvbox").setup({
        contrast = "hard",      -- Options: "soft", "medium", "hard"
        italic = {
          strings = false,
          comments = true,
          operators = false,
          folds = true,
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
]]

return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme carbonfox")
    end,
  },
}
