set formatprg=prettier\ --no-config\ --stdin\ --parser=babel
set expandtab
set shiftwidth=2
set tabstop=2

set path=.,front/src/js/,src/
setlocal suffixesadd+=.js
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)

augroup Ctags
  autocmd!
  autocmd BufWritePost <buffer> :GenCtags
augroup END
