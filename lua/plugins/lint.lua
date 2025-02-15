return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "pylint", "mypy" },
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
      },
      mypy = {
        cmd = "mypy",
        stdin = false,
        stream = "both",
        ignore_exitcode = true,
        args = {
          "--show-column-numbers",
          "--show-error-end",
          "--hide-error-context",
          "--no-color-output",
          "--no-error-summary",
          "--no-pretty",
          "--check-untyped-defs",
          "--ignore-missing-imports",
        },
        parser = require("lint.linters.mypy").parser,
      },
    },
  },
}
