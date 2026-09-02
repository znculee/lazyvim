-- Pick a branch with fzf-lua and hand the resolved ref to `cb`
local function pick_branch(prompt, cb)
  require("fzf-lua").git_branches({
    prompt = prompt,
    actions = {
      ["default"] = function(selected)
        -- Entries look like "  branch", "* branch", "+ branch" or "  remotes/origin/branch"
        local branch = require("fzf-lua.utils").strip_ansi_coloring(selected[1]):match("^[%*+]*%s*[(]?([^%s)]+)")
        if not branch then
          return
        end
        cb(branch:match("^remotes/(.+)$") or branch)
      end,
    },
  })
end

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

-- Diff current buffer against a branch picked from the branch list
vim.keymap.set("n", "<leader>gdb", function()
  pick_branch("Diff@branch> ", function(branch)
    vim.cmd("Gvdiffsplit! " .. vim.fn.fnameescape(branch))
  end)
end, { desc = "Git Diff (pick branch)", silent = true })

-- Pick a branch, browse every file that differs from it, then open one
vim.keymap.set("n", "<leader>gde", function()
  pick_branch("Compare@branch> ", function(branch)
    local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    -- Compare against the fork point so files changed on the branch itself don't show up
    local base = vim.fn.systemlist({ "git", "-C", root, "merge-base", "HEAD", branch })[1]
    if vim.v.shell_error ~= 0 or not base or base == "" then
      base = branch
    end
    -- -C keeps the pathspecs root-relative even when nvim's cwd is a subdirectory
    local git = "git -C " .. vim.fn.shellescape(root) .. " "
    require("fzf-lua").fzf_exec(git .. "diff --name-only " .. vim.fn.shellescape(base), {
      prompt = "Files vs " .. branch .. "> ",
      preview = git .. "diff --color=always " .. vim.fn.shellescape(base) .. " -- {}",
      actions = {
        ["default"] = function(files)
          vim.cmd("edit " .. vim.fn.fnameescape(root .. "/" .. files[1]))
        end,
      },
    })
  end)
end, { desc = "Git Diff (open file changed vs branch)", silent = true })

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
