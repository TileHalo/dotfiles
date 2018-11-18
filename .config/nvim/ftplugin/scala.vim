augroup scala
  autocmd BufWritePost *.scala silent :EnTypeCheck
augroup END

nnoremap <leader>t :EnType<CR>
