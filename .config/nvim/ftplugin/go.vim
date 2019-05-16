set formatprg=goimports
set makeprg=go\ build

set complete+=t

let s:gopath = $GOPATH

augroup Ctags
  autocmd!
  autocmd BufWritePost <buffer> :GenCtags
augroup END
