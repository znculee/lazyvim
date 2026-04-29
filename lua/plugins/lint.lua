local ruff = require("lint").linters.ruff
ruff.condition = function() ---@diagnostic disable-line
  return vim.fn.executable("ruff") == 1
end

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "ruff" },
      markdown = {},
    },
  },
}
