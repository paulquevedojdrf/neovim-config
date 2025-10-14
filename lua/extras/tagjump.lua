local M = {}

function M.smart_jump()
  -- Try to jump using Ctags first
  -- The 'taglist' function returns a list of tags. If a tag is found, jump to it.
  local success = vim.fn.taglist(vim.fn.expand("<cword>"))
  if #success > 0 then
    -- Jump to the tag using built-in Ctags functionality
    -- This doesnt work; Would be nice if it did though.
    -- Goal is to prefer ctags when available, LSP otherwise
    print('Jumping using ctags')
    vim.cmd('normal! g^]')
  else
    -- Fallback to LSP if Ctags fails
    print('Jumping using lsp')
    vim.lsp.buf.definition()
  end
end

function M.setup()
  -- Create an augroup to manage the LspAttach autocommands
  local lsp_augroup = vim.api.nvim_create_augroup("LspSmartJump", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_augroup,
    callback = function(args)
        local bufnr = args.buf
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

        -- Check if the filetype is C or C++
        if filetype == "c" or filetype == "cpp" then
            -- Clear the LSP's tagfunc to force Ctags usage
            vim.bo[bufnr].tagfunc = nil
        else
            -- For all other filetypes, the LSP's tagfunc will remain active.
        end

      -- Remap <C-]> to the custom smart_jump function specifically for this buffer.
      -- vim.keymap.set('n', '<C-]>', function()
      --  M.smart_jump()
      -- end, { noremap = true, buffer = args.buf, desc = "Smart jump (ctags or lsp)" })
    end,
  })
end

return M
