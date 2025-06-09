return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<leader>fp",
      function()
        require("fzf-lua").files({
          file_icons = false, -- disable the devicons prefix
          git_icons = false, -- (optional) disable git‐status glyphs
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
