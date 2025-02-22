-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.relativenumber = false

opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 0
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.wrap = true
opt.breakindent = true
opt.colorcolumn = "120"
opt.textwidth = 79
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=t fo-=c fo+=q",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "tex", "help", "json" },
  command = "setlocal cc= lbr",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "gitcommit", "vim", "sh", "html", "css" },
  command = "setlocal ts=2",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "asm",
  command = "setlocal ts=8 ft=nasm",
})
