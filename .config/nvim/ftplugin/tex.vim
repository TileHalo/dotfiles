setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
lua << EOF
local cmp = require('cmp')
cmp.setup.buffer({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  })
})
EOF
