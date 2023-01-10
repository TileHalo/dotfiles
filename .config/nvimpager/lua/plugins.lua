local data = vim.fn.stdpath('data') .. 'pager'
local config = vim.fn.stdpath('data') .. 'pager'
local cache = vim.fn.stdpath('cache') .. 'pager'
local ensure_packer = function()
  local fn = vim.fn
  local install_path = data .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Packages
return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'

  use 'sheerun/vim-polyglot'
  use 'ishan9299/nvim-solarized-lua'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    snapshot_path = cache .. '/packer.nvim',
    package_root = data .. '/site/pack',
    compile_path = config .. '/plugin/packer_compiled.lua',
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
