# 💤 LazyVim

Personal [neovim](https://neovim.io) config built on [LazyVim](https://lazyvim.github.io/).

## Setup

- [tokyonight_moon.itermcolors](https://github.com/folke/tokyonight.nvim/blob/main/extras/iterm/tokyonight_moon.itermcolors)
- [FiraCode Nerd Font](https://formulae.brew.sh/cask/font-fira-code-nerd-font#default)
  ```bash
  brew install --cask font-fira-code-nerd-font
  ```
- backup
  ```bash
  mv ~/.config/nvim{,.bak}
  mv ~/.local/share/nvim{,.bak}
  mv ~/.local/state/nvim{,.bak}
  mv ~/.cache/nvim{,.bak}
  ```
- install
  ```bash
  cd /path/to/repos
  git clone git@github.com:znculee/lazyvim.git
  cd ~/.config
  ln -s /path/to/repos/lazyvim nvim
  ```

## Tips

- [Project specific configurations in LazyVim with `.lazy.lua`](https://kezhenxu94.me/blog/lazyvim-project-specific-settings)

## Troubleshooting

- Test with clean config
  ```bash
  nvim --clean
  ```
- Clear Tree-sitter parsers and queries
  ```bash
  rm -rf ~/.local/share/nvim/site/parser ~/.local/share/nvim/site/queries
  ```
- Clear cache and data
  ```bash
  rm -rf ~/.cache/nvim ~/.local/share/nvim
  ```
- Check health
  ```bash
  :checkhealth nvim-treesitter
  ```
