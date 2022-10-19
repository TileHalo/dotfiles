-- Neovim config
-- MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
require('mapper')
HOME = os.getenv("HOME")
vim.opt.autowrite = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.shiftwidth = 8

-- Persistent undo
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.undoreload = 500
vim.opt.undodir = HOME .. "/.vim/undo"

-- Backup
vim.opt.backupdir = HOME .. "/.vim/backup"

-- Swap file
vim.opt.directory = HOME .. "/.vim/swap"

-- Line width helper
vim.opt.cc = "80"

if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

-- Bunch of wildignore stuff, can't be bothered to port to Lua
vim.cmd([[
set diffopt+=algorithm:patience
" Setting up ignores and path
set path+=**

map <S-Left> :vertical resize -1<cr>
map <S-Down> :resize +1<cr>
map <S-Up> :resize -1<cr>
map <S-Right> :vertical resize +1<cr>
  ]])

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.showmatch = true
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.browsedir = 'buffer'

vim.opt.termguicolors = true

-- Basic keybindings
noremap("n", "<leader><leader>", ":nohlsearch<CR>")
noremap("n", "<leader>cd", ":lcd %:h<CR>")
snoremap('n', "bt", ":BufferNext<CR>")
snoremap('n', "bT", ":BufferPrevious<CR>")

-- File browser
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

-- NetRW
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = "netrw_gitignore#Hide()"

-- Plugins
require('plugins')

vim.notify = require 'notify'

-- Polyglot
vim.g.polyglot_disabled = { "ftdetect" };
-- Kommentary
require('kommentary.config').configure_language("default", {
  prefer_single_line_comments = true,
})

-- Make to be as tpope/commentary
noremap("n", "gcc", "<Plug>kommentary_line_default")
noremap("n", "gc", "<Plug>kommentary_motion_default")
noremap("v", "gc", "<Plug>kommentary_visual_default<C-c>")

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c",
    "lua",
    "rust",
    "bash",
    "bibtex",
    "make",
    "go",
    "latex",
    "toml",
    "verilog",
    "yaml",
    "vim"
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true,
    disable = { "c" }
  }
}
-- Automatically install LSP and other good stuff
require 'mason'.setup {
  ui = {
    border = "rounded"
  }
}

require 'mason-lspconfig'.setup {
  ensure_installed = { 'clangd',
    'bashls',
    'gopls',
    'hls',
    'texlab',
    'sumneko_lua',
    'rust_analyzer',
    'verible',
    'pylsp',
    'arduino_language_server',
  },
}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'cpptools',
    'debugpy',
    'bash-debug-adapter',
    'luacheck',
    'editorconfig-checker',
    'flake8',
    'black',
    'goimports',
    'fixjson',
    'beautysh'
  },
  auto_update = false,
  run_on_start = true
}


local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local util = require 'packer.util'
local snippath = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
snippath = util.join_paths(snippath, 'packer', 'start', 'vim-snippets')
require 'luasnip.loaders.from_snipmate'.lazy_load({ path = snippath })

vim.cmd([[
  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  " -1 for jumping backwards.
  inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

  snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

  " For changing choices in choiceNodes (not strictly necessary for a basic setup).
  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lsp configs
require 'neodev'.setup {}
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require 'lspconfig'.clangd.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.bashls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.gopls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.hls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.texlab.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
require 'lspconfig'.verible.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.pylsp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require 'lspconfig'.arduino_language_server.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = {
    "arduino-language-server",
    "-cli-config", HOME .. "/.arduino15/arduino-cli.yaml",
    "-fqbn", "arduino:avr:uno",
    "-cli", "arduino-cli",
    "-clangd", "clangd"
  }
}
require 'lspconfig'.asm_lsp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

require 'lsp_signature'.setup {
  bind = true,
  handler_opts = {
    border = "rounded"
  }
}


require 'lualine'.setup {
  options = {
    theme = 'solarized_dark'
  }
}

-- Debugging

require 'mason-nvim-dap'.setup {
  ensure_installed = { 'python', 'delve', 'cpptools' }
}

local dap = require('dap')
local dapui = require('dapui')
local path = require "mason-core.path"

vim.keymap.set('n', '<leader>dk', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<F2>', function() require('dapui').toggle({}) end)
vim.keymap.set('n', '<F5>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_out() end)

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = false,
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
--[[ dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
en ]]
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end


dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = path.concat { vim.fn.stdpath "data", "mason", "bin", "OpenDebugAD7" },
}

dap.configurations.c = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
require 'nvim-dap-virtual-text'.setup {}

-- LaTeX and KNAP
local kmap = vim.keymap.set

kmap('i', '<F8>', function() require("knap").toggle_autopreviewing() end)
kmap('v', '<F8>', function() require("knap").toggle_autopreviewing() end)
kmap('n', '<F8>', function() require("knap").toggle_autopreviewing() end)

require 'texview'.texview()

-- Git signs
require 'gitsigns'.setup()

-- Formatting
require 'tidy'.setup {
  filetype_exclude = { 'markdown', 'diff' },
}

-- Testing
require 'coverage'.setup {}
require 'neotest'.setup {
  adapters = {
    require 'neotest-python',
    require 'neotest-go',
    require 'neotest-rust',
    require 'neotest-haskell'
  }
}

-- Linters
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end
})

-- Telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', 'fm', builtin.man_pages, {})
vim.keymap.set('n', 'fbb', builtin.builtin, {})


require 'telescope'.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
}

require 'telescope'.load_extension('fzf')
require 'telescope'.load_extension('hoogle')
require 'telescope'.load_extension('ui-select')
-- require 'telescope'.load_extension('scout')


require 'nvim-surround'.setup {}

require 'symbols-outline'.setup {}
require 'nvim-lightbulb'.setup { autocmd = { enabled = true } }

-- vi: ft=lua sw=2 ts=2 expandtab
