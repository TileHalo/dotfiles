-- Packages
return {
  'wbthomason/packer.nvim',
  'nvim-lua/plenary.nvim',
  'mcauley-penney/tidy.nvim',
  'nvim-tree/nvim-web-devicons',
  'Iron-E/nvim-cartographer',

  {
    'Fymyte/mbsync.vim',
    ft = 'mbsync',
  },


  -- Telescope
  { 'nvim-telescope/telescope.nvim', version = '0.1.6' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'luc-tielen/telescope_hoogle',
  'nvim-telescope/telescope-ui-select.nvim',
  { 'LinArcX/telescope-ports.nvim',
    dependencies = {
      { 'rcarriga/nvim-notify', branch = 'master' },
    },
  },


  'sheerun/vim-polyglot',
  'ishan9299/nvim-solarized-lua',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  'm-demare/hlargs.nvim',

  {
      'numToStr/Comment.nvim',
      lazy = false,
  },
  'jghauser/mkdir.nvim',
  'nvim-lualine/lualine.nvim',

  -- Mason
  'williamboman/mason.nvim',
  'jayp0521/mason-nvim-dap',
  'williamboman/mason-lspconfig.nvim',
  'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- Debugging
  'mfussenegger/nvim-dap',
  {'rcarriga/nvim-dap-ui',
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
    },
  },
  'theHamsta/nvim-dap-virtual-text',


  -- Completion, snippets and LSP
  'L3MON4D3/LuaSnip',
  'honza/vim-snippets',
  'amarakon/nvim-cmp-lua-latex-symbols',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-omni',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/nvim-cmp',
  'neovim/nvim-lspconfig',
  'onsails/lspkind.nvim',
  'ray-x/lsp_signature.nvim',
  'junegunn/vim-easy-align',
  'simrat39/symbols-outline.nvim',
  {
    'kosayoda/nvim-lightbulb',
    dependencies = 'antoinemadec/FixCursorHold.nvim',
  },

  -- Comment generation
  { 'danymat/neogen', dependencies = 'nvim-treesitter/nvim-treesitter' },

  -- Testing
  'andythigpen/nvim-coverage',
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-go',
      'rouge8/neotest-rust',
      'MrcJkb/neotest-haskell',
    },
  },

  -- Making
  'neomake/neomake',

  -- Latex
  {'lervag/vimtex', version = 'v2.15'},

  -- Haskell
  {
    'MrcJkb/haskell-tools.nvim',

    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },

  -- Rust
  'simrat39/rust-tools.nvim',

  -- Linting and formatting
  'mfussenegger/nvim-lint',
  'folke/neodev.nvim',

  -- Various utilities
  'gennaro-tedesco/nvim-peekup',
  'tpope/vim-unimpaired',
  'kylechui/nvim-surround',
  'tpope/vim-endwise',
  'windwp/nvim-autopairs',
  'gpanders/editorconfig.nvim',
  {
    'romgrk/barbar.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim' },
  },
  {
    'sudormrfbin/cheatsheet.nvim',

    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
  },

  -- git
  { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },

  { 'junegunn/fzf',
    build = function()
      vim.fn['fzf#install']()
    end
  },
}
