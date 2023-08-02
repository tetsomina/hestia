-- ---------
--  Options
-- ---------
vim.loader.enable() -- Performance booster
vim.o.termguicolors = false
vim.o.guicursor = "a:blinkon100"
vim.cmd([[colorscheme alduin]])
vim.o.mouse = "a"
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.o.clipboard = "unnamedplus"
vim.wo.number = true
vim.wo.cursorline = true
vim.o.showmode = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.breakindent = true
vim.o.autochdir = true
vim.o.showbreak = ".."
vim.o.fillchars = "eob: " -- Hide ~ at end of buffer
vim.o.spell = false -- Re-enable whenever built-in spellsitter works

vim.g.mapleader = " "

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smarttab = true

-- Colorscheme edits
-- vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "TabLineFill", { link = "Normal" })
vim.api.nvim_set_hl(0, "SignColumn", { fg = "#87875f", ctermfg = 101, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "HopNextKey", { fg = "#af5f5f", bg = "#262626", ctermfg = 1, ctermbg = 0 })
vim.api.nvim_set_hl(0, "HopNextKey1", { fg = "#ffdf87", bg = "#262626", ctermfg = 7, ctermbg = 0 })
vim.api.nvim_set_hl(0, "HopNextKey2", {fg = "#af5f00", bg = "#262626", ctermfg = 130, ctermbg = 0 })
vim.api.nvim_set_hl(0, "GitSignsAdd", {  fg = "#008787", ctermfg = 30, ctermbg = "NONE"  })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#005f5f", ctermfg = 23, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#af5f5f", ctermfg = 131, ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "fidgetTitle", { fg = "#dfdfaf" })
