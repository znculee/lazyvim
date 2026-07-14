return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Work around a bug in lualine's built-in "fzf" extension.
    --
    -- When an fzf-lua picker window (filetype=fzf) is focused, lualine renders
    -- its statusline via that extension. Its `fzf_element` component returns
    -- `fzf.path.entry_to_file(selected).path`. For the blines/lines pickers the
    -- entries are raw buffer lines, and when a line has no ":" the parser falls
    -- back to treating the *whole line* as the path. lualine then writes that
    -- text into 'statusline' without escaping "%", so a line containing a
    -- printf specifier (e.g. `os._exit(%d)`) makes Vim parse `%d` as a
    -- statusline item and raise `E539: Illegal character <d>`.
    --
    -- The fzf picker is a floating window, so its statusline isn't really
    -- visible anyway; just drop the extension.
    opts.extensions = vim.tbl_filter(function(ext)
      return ext ~= "fzf"
    end, opts.extensions or {})
  end,
}
