Neovim Configuration files
Clone into ~/.config/nvim

latest neovim ppa
- sudo add-apt-repository ppa:neovim-ppa/unstable

## Getting started

`:Lazy sync` to install plugins

## Copilot

the `Copilot` plugin adds suggestions from copilot as you type. Press `CTRL+j` to accept the suggestions.
- [Copilot KeyBindings](https://github.com/CopilotC-Nvim/CopilotChat.nvim#key-mappings)

This plugin is configured to be `lazy` loaded. To enable it first type `:Copilot`
- Once the plugin is loaded it spawns a language-server process which can be a drain on system resources if its
  spawned for every neovim instance opened.

## Copilot Chat

`:CopilotChat` to open a split window
- `#buffers:all` will share `a snapshot` whatever files you have open in the same window with copilot (including split windows)
- Ask it a question then `CTRL+s` to submit the question
- [Copilot Context Sharing](https://github.com/CopilotC-Nvim/CopilotChat.nvim#contexts)

`CTRL+j` to accept copilot inline suggestions as you are editing files

## Telescope

Requires `ripgrep` to be installed separately
- `sudo apt install ripgrep`

See [Telescope Keybindings](lua/plugins/telescope.lua)

Of interest:
- `<space>pp` will open a list of all matches for the word under the cursor starting from your project root directory
- `<space>pf` will open a fuzzy search of all files in your project root directory
- `<space>pg` will open a live grep session starting from your project root directory

If you pick a file to open from the picker list you can use `CTRL+o` to jump back to your previous buffer

## pyright LSP

`pyright` is used as the python LSP for static analysis and code-completion (`lua/plugins/lsp.lua`).
For it to work correctly you first need to install `pyright` globally using `npm`
- `npm install -g pyright`

npm can be installed as a system package. On ubuntu use `apt install nodejs npm`

To view error details error details hover over the error with your cursor and press `\e`
- This keybinding is configured under `lua/config/settings.lua`.

## References

- https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7
- https://thevaluable.dev/tree-sitter-neovim-overview/
- https://www.youtube.com/watch?v=u_OORAL_xSM

