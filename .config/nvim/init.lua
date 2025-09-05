-- Neovim config
-- MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>

ISWIN = vim.fn.has("windows") == 1 and vim.fn.has("wsl") == 0
ISLINUX = vim.fn.has("linux") == 1
ISWSL = vim.fn.has("wsl") == 1
if ISWIN then
  USER = vim.env.USERNAME
  HOME = vim.env.USERPROFILE
else
  USER = vim.env.USER
  HOME = os.getenv("HOME")
end
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

vim.opt.diffopt        = vim.opt.diffopt + "algorithm:patience"
vim.opt.path           = vim.opt.path + "**"
vim.opt.shortmess      = vim.opt.shortmess + "A"

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.showcmd        = true
vim.opt.lazyredraw     = true
vim.opt.cursorline     = true
vim.opt.wildmenu       = true
vim.opt.showmatch      = true
vim.opt.breakindent    = true
vim.opt.list           = true
vim.opt.smartindent    = true
vim.opt.autoindent     = true
vim.opt.incsearch      = true
vim.opt.hlsearch       = true
vim.opt.smartcase      = true
-- vim.opt.browsedir = 'buffer'

vim.opt.termguicolors  = true


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

-- Some vimtex stuff
vim.g.vimtex_view_method = "sioyek"
if ISWSL or ISWIN then
  vim.g.vimtex_view_enabled = "false"
end

vim.cmd([[
let g:vimtex_quickfix_ignore_filters = [
\ "Overfull",
\ "Underfull",
\]
]])
vim.g.polyglot_disabled = { "ftdetect", "sensible" };
vim.g.snips_author = string.gsub(vim.fn.system("git config user.name"), "[\r\n]", "")
vim.g.snips_email = string.gsub(vim.fn.system("git config user.email"), "[\r\n]", "")
vim.g.snips_github = "https://github.com/TileHalo"

-- Plugins

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
vim.cmd('colorscheme solarized')

vim.notify = require 'notify'
local map = require 'cartographer'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local lspkind = require('lspkind')
local dap = require('dap')
local dapui = require('dapui')
local path = require "mason-core.path"
-- local configs = require 'lspconfig.configs'

-- Basic keybindings
map.n.nore.silent['<leader><leader>'] = ':nohlsearch<CR>'
map.n.nore.silent['<leader>cd'] = ':lcd %:h<CR>'
map.n.nore.silent['bt'] = ':bnext<CR>'
map.n.nore.silent['bT'] = ':bprevious<CR>'
map['<S-Left>'] = ':vertical resize -1<cr>'
map['<S-Down>'] = ':resize +1<cr>'
map['<S-Up>'] = ':resize -1<cr>'
map['<S-Right>'] = ':vertical resize +1<cr>'

-- Polyglot
require 'Comment'.setup()

require 'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = false,
  ignore_install = { "javascript" },
  modules = {},
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
    "yaml",
    "vim",
    "vimdoc",
    "python",
  },
  highlight = {
    enable = true,
    disable = { "tex", "latex" },
  },
  indent = {
    enable = true,
    disable = { "c" }
  },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
  },

}
require 'treesitter-context'.setup {
  enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false,     -- Enable multiwindow support.
  max_lines = 0,           -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 3, -- Maximum number of lines to show for a single context
  trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,     -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
-- Automatically install LSP and other good stuff
require 'mason'.setup {
  ui = {
    border = "rounded"
  }
}

require 'mason-lspconfig'.setup {
  ensure_installed = {
    'bashls',
    'clangd',
    'texlab',
    'lua_ls',
    'pylsp',
  },
}

vim.lsp.enable("djlsp")
require 'referencer'.setup {}

-- require 'mason-tool-installer'.setup {
--   ensure_installed = {
--     'debugpy',
--     'bash-debug-adapter',
--     'luacheck',
--     'editorconfig-checker',
--     'flake8',
--     'black',
--     'goimports',
--     'fixjson',
--     'beautysh'
--   },
--   auto_update = false,
--   run_on_start = true
-- }



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



local ls = require("luasnip")

local snippath = "$HOME/.local/share/nvim/lazy/vim-snippets/snippets"

require 'luasnip.loaders.from_snipmate'.lazy_load({ path = snippath })
vim.keymap.set({ "i" }, "<C-h>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lsp configs
require 'lazydev'.setup {}
map.n.nore.silent['<leader>e'] = '<Cmd>lua vim.diagnostic.open_float()<CR>'
map.n.nore.silent['[d'] = '<Cmd>lua vim.diagnostic.goto_prev()<CR>'
map.n.nore.silent[']d'] = '<Cmd>lua vim.diagnostic.goto_next()<CR>'
map.n.nore.silent['<leader>q'] = '<Cmd>lua vim.diagnostic.setloclist()<CR>'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local mml = map.nore.silent['buffer' .. bufnr]
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

vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
          refreshSupport = false,
          disabled = { "unresolved-proc-macro" },
          enableExperimental = true,
        },
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}


require 'lualine'.setup {
  options = {
    theme = 'solarized_dark'
  }
}

require 'neogit'.setup {}

-- Debugging

-- require 'mason-nvim-dap'.setup {
--   ensure_installed = { 'python', 'delve', 'cpptools' },
--   automatic_installation = false
-- }

map.n['<leader>dk'] = '<Cmd>lua require("dap").continue()<CR>'
map.n['<leader>dl'] = '<Cmd>lua require("dap").run_last()<CR>'
map.n['<leader>b'] = '<Cmd>lua require("dap").toggle_breakpoint()<CR>'
map.n['<F2>'] = '<Cmd>lua require("dapui").toggle({})<CR>'
map.n['<leader>n'] = '<Cmd>lua require("dap").step_over()<CR>'
map.n['<leader>s'] = '<Cmd>lua require("dap").step_into()<CR>'
map.n['<F5>'] = '<Cmd>lua require("dap").step_over()<CR>'
map.n['<F6>'] = '<Cmd>lua require("dap").step_into()<CR>'
map.n['<F7>'] = '<Cmd>lua require("dap").step_out()<CR>'

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
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
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
map.n.nore['<leader>nr'] = '<Cmd>lua require("neotest").run.run()<CR>'
map.n.nore['<leader>no'] = '<Cmd>lua require("neotest").output.open()<CR>'
map.n.nore['<leader>ns'] = '<Cmd>lua require("neotest").summary.toggle()<CR>'

require 'coverage'.setup {}
require 'neotest'.setup {
  adapters = {
    require 'neotest-python',
    require 'neotest-go',
    require 'neotest-rust',
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
vim.api.nvim_create_augroup("linter", { clear = true })
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

-- require 'nvim-lightbulb'.setup { autocmd = { enabled = true } }

map.x.n['ga'] = '<Plug>(EasyAlign)'


-- vi: ft=lua sw=2 ts=2 expandtab
