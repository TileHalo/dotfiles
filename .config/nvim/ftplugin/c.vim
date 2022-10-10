setlocal cinkeys-=0#
setlocal cinoptions=l1,:0
setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

augroup C
  autocmd!
  autocmd BufWritePre * call g:TrimWhitespace()
augroup END
