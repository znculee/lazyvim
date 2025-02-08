return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "pylint", "mypy" },
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
          "W1203,C0103,C0114,C0115,C0116,R0913,R0914",
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
        },
        parser = require("lint.linters.mypy").parser,
      },
    },
  },
}
