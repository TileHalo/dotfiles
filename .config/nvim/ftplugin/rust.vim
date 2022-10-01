setlocal makeprg=cargo\ build
setlocal formatprg=rustfmt

iabbrev srt #[derive(Debug, Clone)]<CR>pub struct  {<CR>}<ESC>k0t{i
iabbrev enm #[derive(Debug, Clone)]<CR>pub enum  {<CR>}<ESC>k0t{i
iabbrev func #[derive(Debug, Clone)]<CR>pub func  () -> {<CR>}<ESC>k0t(i

if executable('ctags')
  setlocal complete+=t
  setlocal tags+=$RUST_SRC_PATH/rusty-tags.vi
  augroup Rustytags
    autocmd!
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir" . expand('%:p:h') . "&" | redraw!
  augroup END
endif

