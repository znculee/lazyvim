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
opt.textwidth = 79
