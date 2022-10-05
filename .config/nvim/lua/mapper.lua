function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = false })
end

function noremap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

function smap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = true })
end

function snoremap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
