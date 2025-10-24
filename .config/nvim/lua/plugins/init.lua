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
  { 'nvim-telescope/telescope.nvim',            version = '0.1.8' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'luc-tielen/telescope_hoogle',
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'LinArcX/telescope-ports.nvim',
    dependencies = {
      { 'rcarriga/nvim-notify', branch = 'master' },
    },
  },


  'sheerun/vim-polyglot',
  'ishan9299/nvim-solarized-lua',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'm-demare/hlargs.nvim',

  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    config = function()
      local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
      require("dap-python").setup(python)
    end,
    -- Consider the mappings at
    -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#mappings
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "romus204/referencer.nvim",
  },

  {
    'mawkler/refjump.nvim',
    event = 'LspAttach', -- Uncomment to lazy load
    opts = {}
  },

  {
    'numToStr/Comment.nvim',
    lazy = false,
  },
  'jghauser/mkdir.nvim',
  'nvim-lualine/lualine.nvim',

  -- Mason
  'mason-org/mason.nvim',
  -- 'jayp0521/mason-nvim-dap',
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  -- 'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- Debugging
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
    },
  },
  'theHamsta/nvim-dap-virtual-text',

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  -- Completion, snippets and LSP
  'honza/vim-snippets',
  'amarakon/nvim-cmp-lua-latex-symbols',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-omni',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/nvim-cmp',
  'onsails/lspkind.nvim',
  'ray-x/lsp_signature.nvim',
  'junegunn/vim-easy-align',

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
    },
  },

  -- Making
  'neomake/neomake',

  -- Latex
  { 'lervag/vimtex',  version = 'v2.15' },


  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },

  -- Linting and formatting
  'mfussenegger/nvim-lint',
  {
    'folke/lazydev.nvim',
    ft = 'lua',
  },

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
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
  {
    'junegunn/fzf',
    build = function()
      vim.fn['fzf#install']()
    end
  },
}
