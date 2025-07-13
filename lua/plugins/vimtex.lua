return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = { out_dir = "out" }
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_activate = 0
      vim.g.vimtex_view_skim_reading_bar = 0
      vim.g.vimtex_syntax_conceal = {
        math_bounds = 0,
        math_super_sub = 0,
      }
    end,
  },
}
