local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>ca",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set("n", 'gD',
  function()
   vim.lsp.buf.declaration()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", 'gd',
  function()
    vim.lsp.buf.definition()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", 'gi',
  function()
    vim.lsp.buf.implementation()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<C-k>',
  function()
    vim.lsp.buf.signature_help()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<leader>wa',
  function()
    vim.lsp.buf.add_workspace_folder()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<leader>wr',
  function()
    vim.lsp.buf.remove_workspace_folder()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<leader>wl',
  function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<leader>D',
  function()
    vim.lsp.buf.type_definition()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<leader>rn',
  function()
    vim.lsp.buf.rename()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", 'gr',
  function()
    vim.lsp.buf.references()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", '<leader>F',
  function()
    vim.lsp.buf.format()
  end,
  { silent = true, buffer = bufnr }
)
