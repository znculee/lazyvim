return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = function()
        return vim.fn.executable("ruff") == 1 and { "ruff_format", "ruff_fix" } or { "isort", "black" }
      end,
      sh = { "shfmt" },
    },
  },
}
