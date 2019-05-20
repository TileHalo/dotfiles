

augroup Ctags
  autocmd!
  autocmd BufWritePost <buffer> :GenCtags
augroup END
