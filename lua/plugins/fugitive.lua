-- Diff current buffer against the working tree / index
vim.keymap.set("n", "<leader>gdw", "<cmd>Gvdiffsplit!<cr>", { desc = "Git Diff (working tree)", silent = true })

-- Diff current buffer against a commit picked from this file's history
vim.keymap.set("n", "<leader>gdc", function()
  require("fzf-lua").git_bcommits({
    actions = {
      ["default"] = function(selected)
        local commit = require("fzf-lua.utils").strip_ansi_coloring(selected[1]):match("^%S+")
        vim.cmd("Gvdiffsplit! " .. commit)
      end,
    },
  })
end, { desc = "Git Diff (pick commit)", silent = true })

return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
}
