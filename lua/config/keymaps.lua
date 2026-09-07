-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_user_command("TrimTrailspace", function()
  vim.cmd([[%s/\s\+$//e]])
end, { desc = "Trim all trailing whitespace" })

vim.keymap.set("n", "<leader>fp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Copied: " .. vim.fn.expand("%:p"))
end, { desc = "Copy absolute file path" })

vim.keymap.set("n", "<leader>fo", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file for current buffer", vim.log.levels.WARN)
    return
  end
  vim.ui.open(file)
end, { desc = "Open file with system app" })
