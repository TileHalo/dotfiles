setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal spell

function! TexFormat(start, end)
  silent execute a:start.','.a:end.'s/\(e\.g\|\<al\)@<![.!?!]\zs /\r/g'
endfunction


lua << EOF
local cmp = require('cmp')
cmp.setup.buffer({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  })
})

vim.g.vimtex_quickfix_open_on_warning = false
EOF
