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
            "w1203,c0103,c0114,c0115,c0116,r0913,r0914",
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
