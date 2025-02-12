vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.yaml",
  callback = function()
    vim.bo.syntax = "on"
  end,
})

return {}
