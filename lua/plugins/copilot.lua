return {
    "github/copilot.vim",

    -- lazy load Copilot. Once loaded several language-server processes are spawned which can be a
    -- drain on system resources if they are not actually needed.
    -- type :Copilot to load the plugin
    cmd = "Copilot",
    lazy = true,

    config = function()
        -- Map ctrl+j to accept a copilot suggestion; disable use of tab to accept
        vim.g.copilot_no_tab_map = true
        vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false
        })

        -- ALT+] go to next suggestion
        vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')

        -- ALT+[ go to previous suggestion
        vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
    end
}
