return {
  "inkarkat/vim-mark",
  dependencies = { "inkarkat/vim-ingo-library" },
  config = function()
    vim.g.mw_max_markers = 10 -- Maximum number of markers to track

    -- Add keymap to toggle a marker under the cursor using <CR>(Enter)
    vim.keymap.set("n", "<CR>", function()
      local word = vim.fn.expand("<cword>")
      if word ~= "" then
        vim.cmd("Mark " .. word)
      end
    end, { noremap = true, silent = true })
  end
}
