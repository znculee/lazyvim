local ruff = require("lint").linters.ruff
ruff.condition = function() ---@diagnostic disable-line
  return vim.fn.executable("ruff") == 1
end

local mypy = require("lint").linters.mypy
table.insert(mypy.args, "--check-untyped-defs")
table.insert(mypy.args, "--ignore-missing-imports")
mypy.condition = function() ---@diagnostic disable-line
  return vim.fn.executable("mypy") == 1
end

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "ruff", "pylint", "mypy" },
      markdown = {},
    },
    linters = {
      pylint = {
        cmd = "pylint",
        stdin = false,
        ignore_exitcode = true,
        args = {
          "--output-format",
          "json",
          "--max-line-length",
          "120",
          "--disable",
          table.concat({
            "e1101",
            "w1203",
            "c0103,c0114,c0115,c0116",
            "r0913,r0914",
          }, ","),
        },
        parser = require("lint.linters.pylint").parser,
        condition = function()
          return vim.fn.executable("pylint") == 1
        end,
      },
    },
  },
}
