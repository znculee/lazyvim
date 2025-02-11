vim.keymap.set("n", "<leader>gd", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(":Gvdiffsplit! ", true, false, true), "n")
end, { desc = "Git Diff", silent = true })

return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
}
