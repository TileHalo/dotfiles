setlocal cinkeys-=0#
setlocal cinoptions=l1,:0
packadd termdebug

" My cheapshot snippets
iabbrev <buffer> inc #include <.h><Esc>Ba
iabbrev <buffer> incl #include ".h"<Esc>Ba
iabbrev <buffer> fori for (i = 0; i < ; i++) {<CR>}<Esc>k2==02f;i
iabbrev <buffer> forj for (j = 0; j < ; j++) {<CR>}<Esc>k2==k00f;i
iabbrev <buffer> switch switch () {<CR>default:<CR>}<Esc>2k3==0f)i
iabbrev <buffer> if if () {<CR>}<Esc>k2==0f)i
iabbrev <buffer> elif else if () {<CR>}<Esc>k2==f)i
iabbrev <buffer> else else {<CR>}<Esc>=kA
iabbrev <buffer> prti int ();<Esc>Bi
iabbrev <buffer> prt void ();<Esc>Bi
iabbrev <buffer> sprti static int ();<Esc>Bi
iabbrev <buffer> sprt static void ();<Esc>Bi
iabbrev <buffer> license /* See LICENSE file for copyright and license details. */<CR>

augroup C
  autocmd!
  autocmd BufWritePre * call g:TrimWhitespace()
augroup END
