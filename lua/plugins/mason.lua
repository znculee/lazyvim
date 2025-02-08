return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- lua
      "lua-language-server",
      "stylua",

      -- python
      "black",
      "isort",
      "pyright",

      -- shell
      "shellcheck",
      "shfmt",

      -- rust
      "rust-analyzer",

      -- markdown
      "markdownlint-cli2",
      "markdown-toc",
    },
  },
}
