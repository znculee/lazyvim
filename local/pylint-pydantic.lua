return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        pylint = {
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
              "r0904,r0912,r0913,r0914,r0915,r0917",
            }, ","),
            "--extension-pkg-whitelist",
            "pydantic",
            "--load-plugins",
            "pylint_pydantic",
          },
        },
      },
    },
  },
}
