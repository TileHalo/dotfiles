set makeprg=Cargo\ build
set formatprg=rustfmt

if executable('ctags')
  set complete+=t
  if !executable('rusty-tags') && executable('rustup')

  endif
  setlocal tags+=$RUST_SRC_PATH/rusty-tags.vi
  augroup Rustytags
    autocmd!
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir" . expand('%:p:h') . "&" | redraw!
  augroup END
endif
