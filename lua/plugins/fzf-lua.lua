return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<c-x><c-f>",
      function()
        require("fzf-lua").files({
          file_icons = false,
          git_icons = false,
          actions = {
            ["default"] = function(selected)
              local path = selected[1]
              vim.api.nvim_put({ path }, "", true, true)
              vim.api.nvim_feedkeys("a", "n", false)
            end,
          },
        })
      end,
      desc = "Complete file names",
      mode = "i",
    },
    { "<leader>sb", "<cmd>FzfLua blines<cr>", mode = { "n" }, desc = "Current Buffer Lines" },
    { "<leader>sB", "<cmd>FzfLua lines<cr>", mode = { "n" }, desc = "All Buffer Lines" },
  },
}
