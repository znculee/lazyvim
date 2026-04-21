return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- lua
      "lua-language-server",
      "stylua",

      -- python
      "black",
      "isort",
      "ty",

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
