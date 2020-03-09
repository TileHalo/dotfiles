set formatprg=goimports
set makeprg=go\ test

set complete+=t

let s:gopath = $GOPATH

let g:go_fmt_command = "goimports"
