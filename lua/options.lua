vim.g.loaded_netwr = 1
vim.g.loaded_netwrPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false --text wrapup instead of continious offscreen

vim.opt.expandtab = true 
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.clipboard = "unnamedplus" --cpy newest from clipboard -> needs "wl-clipboard for wayland"
vim.opt.scrolloff = 999 -- after x interval numbers in middle

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split" --shows what will be changed at the bottom instead of not showing
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.INFO]  = "",
        [vim.diagnostic.severity.HINT]  = "",
      }
    } 
  })
