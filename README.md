Neovim Configuration files
Clone into ~/.config/nvim

latest neovim ppa
- sudo add-apt-repository ppa:neovim-ppa/unstable

## Getting started

`:Lazy sync` to install plugins

## Copilot Chat

`:CopilotChat` to open a split window
- `#buffers:all` will share `a snapshot` whatever files you have open in the same window with copilot (including split windows)
- Ask it a question then `CTRL+s` to submit the question
- [Copilot KeyBindings](https://github.com/CopilotC-Nvim/CopilotChat.nvim#key-mappings)
- [Copilot Context Sharing](https://github.com/CopilotC-Nvim/CopilotChat.nvim#contexts)

`CTRL+j` to accept copilot inline suggestions as you are editing files

## Telescope

Requires `ripgrep` to be installed separately
- `sudo apt install ripgrep`

See [Telescope Keybindings](lua/plugins/telescope.lua)

Of interest:
- `<space>po` will open a list of all matches for the word under the cursor starting from your project root directory
- `<space>pf` will open a fuzzy search of all files in your project root directory
- `<space>pg` will open a live grep session starting from your project root directory

If you pick a file to open from the picker list you can use `CTRL+o` to jump back to your previous buffer

## References

- https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7
- https://thevaluable.dev/tree-sitter-neovim-overview/
- https://www.youtube.com/watch?v=u_OORAL_xSM

