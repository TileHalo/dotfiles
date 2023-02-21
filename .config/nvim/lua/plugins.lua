local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
  use 'mcauley-penney/tidy.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'Iron-E/nvim-cartographer'

  use {
    'Fymyte/mbsync.vim',
    ft = 'mbsync',
  }


  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'luc-tielen/telescope_hoogle'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use { "LinArcX/telescope-ports.nvim",
    requires = {
      { 'rcarriga/nvim-notify', branch = "master" }
    }
  }


  use 'sheerun/vim-polyglot'
  use 'ishan9299/nvim-solarized-lua'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'm-demare/hlargs.nvim'

  use 'numToStr/Comment.nvim'
  use 'jghauser/mkdir.nvim'
  use 'nvim-lualine/lualine.nvim'

  -- Mason
  use 'williamboman/mason.nvim'
  use 'jayp0521/mason-nvim-dap'
  use 'williamboman/mason-lspconfig.nvim'
  use 'WhoIsSethDaniel/mason-tool-installer.nvim'

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'


  -- Completion, snippets and LSP
  use 'L3MON4D3/LuaSnip'
  use 'honza/vim-snippets'
  use "amarakon/nvim-cmp-lua-latex-symbols"
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-omni'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'junegunn/vim-easy-align'
  use 'simrat39/symbols-outline.nvim'
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  }

  use { 'simrat39/rust-tools.nvim'}

  -- Comment generation
  use { 'danymat/neogen', requires = 'nvim-treesitter/nvim-treesitter' }

  -- Testing
  use 'andythigpen/nvim-coverage'
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
      "MrcJkb/neotest-haskell",
    },
  }

  -- Making
  use 'neomake/neomake'

  -- Latex
  use 'lervag/vimtex'

  -- Haskell
  use {
    'MrcJkb/haskell-tools.nvim',

    requires = {
      'neovim/nvim-lspconfig'
    }
  }

  -- Linting and formatting
  use 'mfussenegger/nvim-lint'
  use 'folke/neodev.nvim'

  -- Various utilities
  use 'gennaro-tedesco/nvim-peekup'
  use 'tpope/vim-unimpaired'
  use 'kylechui/nvim-surround'
  use 'tpope/vim-endwise'
  use 'windwp/nvim-autopairs'
  use 'gpanders/editorconfig.nvim'
  use {
    'romgrk/barbar.nvim',

    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'sudormrfbin/cheatsheet.nvim',

    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  use { 'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
