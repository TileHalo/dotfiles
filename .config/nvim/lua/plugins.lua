local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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
return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nathom/filetype.nvim'
  use 'nvim-tree/nvim-web-devicons'

  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

  use 'sheerun/vim-polyglot'
  use { 'ishan9299/nvim-solarized-lua', config = function()
    vim.cmd('colorscheme solarized')
  end }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'b3nj5m1n/kommentary'
  use 'jghauser/mkdir.nvim'
  use 'nvim-lualine/lualine.nvim'

  -- Mason
  use 'williamboman/mason.nvim'
  use 'jayp0521/mason-nvim-dap'
  use 'williamboman/mason-lspconfig.nvim'

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'


  -- Completion, snippets and LSP
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'honza/vim-snippets'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use {'simrat39/rust-tools.nvim', ft = 'rust'}

  -- Linting and formatting
  use 'mfussenegger/nvim-lint'
  use 'mhartington/formatter.nvim'

  -- Various utilities
  use 'gennaro-tedesco/nvim-peekup'
  use 'tpope/vim-unimpaired'
  use 'kylechui/nvim-surround'
  use 'windwp/nvim-autopairs'
  use 'gpanders/editorconfig.nvim'
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
    'sudormrfbin/cheatsheet.nvim',

    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  -- LaTeX and like
  use {'frabjous/knap', ft = 'tex'}

  -- git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  use {'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = function ()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

