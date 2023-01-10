-- Neovim config
-- MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
HOME = os.getenv("HOME")
vim.opt.autowrite = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8

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
augroup ftdetect
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END
  ]])

vim.opt.diffopt  = vim.opt.diffopt + "algorithm:patience"
vim.opt.path = vim.opt.path + "**"
vim.opt.shortmess = vim.opt.shortmess + "A"

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
vim.cmd('colorscheme solarized')

vim.notify = require 'notify'
local map = require 'cartographer'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local lspkind = require('lspkind')
local util = require 'packer.util'
local snippath = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
local dap = require('dap')
local dapui = require('dapui')
local rt = require('rust-tools')
local path = require "mason-core.path"
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

-- Basic keybindings
map.n.nore.silent['<leader><leader>'] = ':nohlsearch<CR>'
map.n.nore.silent['<leader>cd'] = ':lcd %:h<CR>'
map.n.nore.silent['bt'] = ':BufferNext<CR>'
map.n.nore.silent['bT'] = ':BufferPrevious<CR>'
map['<S-Left>'] =  ':vertical resize -1<cr>'
map['<S-Down>'] = ':resize +1<cr>'
map['<S-Up>'] = ':resize -1<cr>'
map['<S-Right>'] = ':vertical resize +1<cr>'

-- Polyglot
vim.g.polyglot_disabled = { "ftdetect", "sensible" };
require 'Comment'.setup{}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
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
    enable = true,
    disable = { "tex", "latex" },
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
  ensure_installed = {
    'clangd',
    'bashls',
    'gopls',
    'hls',
    'texlab',
    'sumneko_lua',
    'rust_analyzer',
    'svls',
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



cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
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

cmp.setup.filetype('c', {
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'omni' },
  }, {
    { name = 'buffer' }
  })


})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require "cmp".setup.filetype({ "tex", "plaintex" }, {
  sources = {
    { name = "lua-latex-symbols", option = { cache = true } }
  }
})


snippath = util.join_paths(snippath, 'packer', 'start', 'vim-snippets')
require 'luasnip.loaders.from_snipmate'.lazy_load({ path = snippath })
map.i.expr.silent['<Tab>'] = 'luasnip#expand_or_jumpable() ?' ..
                            '"<Plug>luasnip-expand-or-jump" : "<Tab>"'
map.i.s.nore.silent['<S-Tab>'] = '<cmd>lua require("luasnip").jump(-1)<Cr>'
map.s.nore.silent['<Tab>'] = '<cmd>lua require("luasnip").jump(1)<Cr>'
map.i.s.expr.silent['<C-E>'] = 'luasnip#choice_active() ?' ..
                               '"<Plug>luasnip-next-choice" : "<C-E>"'

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lsp configs
require 'neodev'.setup {}
map.n.nore.silent['<leader>e'] = '<Cmd>lua vim.diagnostic.open_float()<CR>'
map.n.nore.silent['[d'] = '<Cmd>lua vim.diagnostic.goto_prev()<CR>'
map.n.nore.silent[']d'] = '<Cmd>lua vim.diagnostic.goto_next()<CR>'
map.n.nore.silent['<leader>q'] = '<Cmd>lua vim.diagnostic.setloclist()<CR>'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local mml = map.nore.silent['buffer'..bufnr]
  mml['gD'] = '<Cmd>lua vim.lsp.buf.declaration()<CR>'
  mml['gd'] = '<Cmd>lua vim.lsp.buf.definition()<CR>'
  mml['K'] = '<Cmd>lua vim.lsp.buf.hover()<CR>'
  mml['gi'] = '<Cmd>lua vim.lsp.buf.implementation()<CR>'
  mml['<C-k>'] = '<Cmd>lua vim.lsp.buf.signature_help()<CR>'
  mml['<leader>wa'] = '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'
  mml['<leader>wr'] = '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'
  mml['<leader>wl'] = '<Cmd>lua print(vim.inspect(vim.lsp.buf' ..
                      '.list_workspace_folders()))<CR>'
  mml['<leader>D'] = '<Cmd>lua vim.lsp.buf.type_definition()<CR>'
  mml['<leader>rn'] = '<Cmd>lua vim.lsp.buf.rename()<CR>'
  mml['<leader>ca'] = '<Cmd>lua vim.lsp.buf.code_action()<CR>'
  mml['gr'] = '<Cmd>lua vim.lsp.buf.references()<CR>'
  mml['<leader>F'] = '<Cmd>lua vim.lsp.buf.format()<CR>'
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  filetypes = {'cpp', 'objc', 'objcpp', 'cuda', 'proto' }
}
lspconfig.bashls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
lspconfig.gopls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
lspconfig.texlab.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
lspconfig.sumneko_lua.setup {
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
lspconfig.svls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
lspconfig.pylsp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
lspconfig.arduino_language_server.setup {
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
lspconfig.asm_lsp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

require 'haskell-tools'.setup {
  hls = {
    on_attach = on_attach,
  },
}

-- Manual lsp for vhdl_ls
if not configs.rust_hdl then
  configs.rust_hdl = {
    default_config = {
      cmd = {'vhdl_ls'};
      filetypes = { "vhdl" };
      root_dir = require 'lspconfig.util'.find_git_ancestor,
      settings = {};
    };
  }
end

-- lspconfig.rust_hdl.setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
--   capabilities = capabilities,
-- }


rt.setup {
  server = {
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
      local mml = map.nore.silent['buffer'..bufnr]
      mml['K'] = '<Cmd>RustHoverActions<CR>'

    end,
  }
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

require 'neogit'.setup {}

-- Debugging

require 'mason-nvim-dap'.setup {
  ensure_installed = { 'python', 'delve', 'cpptools' }
}

map.n['<leader>dk'] = '<Cmd>lua require("dap").continue()<CR>'
map.n['<leader>dl'] = '<Cmd>lua require("dap").run_last()<CR>'
map.n['<leader>b'] = '<Cmd>lua require("dap").toggle_breakpoint()<CR>'
map.n['<F2'] = '<Cmd>lua require("dapui").toggle({})<CR>'
map.n['<leader>n'] = '<Cmd>lua require("dap").step_over()<CR>'
map.n['<leader>s'] = '<Cmd>lua require("dap").step_into()<CR>'
map.n['<F7'] = '<Cmd>lua require("dap").step_out()<CR>'

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7") == 1,
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

require 'texview'.texview()

-- Formatting
require 'tidy'.setup {
  filetype_exclude = { 'markdown', 'diff' },
}

-- Testing
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message =
      diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)
map.n.nore['<leader>nr'] = 'require("neotest").run.run()'
map.n.nore['<leader>no'] = 'require("neotest").output.open()'
map.n.nore['<leader>ns'] = 'require("neotest").summary.toggle()'

require 'coverage'.setup {}
require 'neotest'.setup {
  adapters = {
    require 'neotest-python',
    require 'neotest-go',
    require 'neotest-rust',
    require 'neotest-haskell'
  }
}

require 'neogen'.setup {
  snippet_engine = "luasnip"
}

local neogencmd = "<Cmd>lua require('neogen').generate({ type = '%s' })<CR>"
map.n.nore.silent['<Leader>cc'] = string.format(neogencmd, 'class')
map.n.nore.silent['<Leader>ct'] = string.format(neogencmd, 'type')
map.n.nore.silent['<Leader>cf'] = string.format(neogencmd, 'func')
map.n.nore.silent['<Leader>cF'] = string.format(neogencmd, 'file')

-- Linters
--
require 'lint'.linters_by_ft = {
  markdown = {},
}
vim.api.nvim_create_augroup("linter", {clear = true})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = "linter",
  callback = function()
    require('lint').try_lint()
  end
})

-- Telescope
map.n['<leader>f'] = '<Cmd>lua require("telescope.builtin").find_files()<CR>'
map.n['<leader>g'] = '<Cmd>lua require("telescope.builtin").live_grep()<CR>'
map.n['<leader'] = '<Cmd>lua require("telescope.builtin").buffers()<CR>'
map.n['<leader>h'] = '<Cmd>lua require("telescope.builtin").help_tags()<CR>'
map.n['<leader>m'] = '<Cmd>lua require("telescope.builtin").man_pages()<CR>'
map.n['<leader>bb'] = '<Cmd>lua require("telescope.builtin").builtin()<CR>'


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
require 'telescope'.load_extension('notify')
-- require 'telescope'.load_extension('scout')


require 'nvim-surround'.setup {}

require 'symbols-outline'.setup {}
require 'nvim-lightbulb'.setup { autocmd = { enabled = true } }

map.x.n['ga'] = '<Plug>(EasyAlign)'


-- vi: ft=lua sw=2 ts=2 expandtab
