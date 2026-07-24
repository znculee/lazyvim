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

-- Pick a commit, browse the files it changed, then open the working copy of one
vim.keymap.set("n", "<leader>ge", function()
  local fzf = require("fzf-lua")
  fzf.git_commits({
    actions = {
      ["default"] = function(selected)
        local sha = require("fzf-lua.utils").strip_ansi_coloring(selected[1]):match("^%S+")
        local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        fzf.fzf_exec("git diff-tree --no-commit-id --name-only -r " .. sha, {
          prompt = "Files@" .. sha .. "> ",
          preview = "git show --color=always " .. sha .. " -- {}",
          actions = {
            ["default"] = function(files)
              vim.cmd("edit " .. vim.fn.fnameescape(root .. "/" .. files[1]))
            end,
          },
        })
      end,
    },
  })
end, { desc = "Git Edit (browse commit files)", silent = true })

return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
}
