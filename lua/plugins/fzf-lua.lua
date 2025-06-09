return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<leader>fp",
      function()
        require("fzf-lua").files({
          file_icons = false,
          git_icons = false,
          actions = {
            ["default"] = function(selected)
              local path = selected[1]
              vim.api.nvim_put({ path }, "", true, true)
            end,
          },
        })
      end,
      desc = "Insert file path at cursor",
    },
  },
}
