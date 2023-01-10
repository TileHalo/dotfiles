-- Neovimpager config
-- MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
HOME = os.getenv("HOME")
vim.opt.autowrite = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8

if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end


vim.opt.termguicolors = true
require('plugins')
vim.cmd('colorscheme solarized')
