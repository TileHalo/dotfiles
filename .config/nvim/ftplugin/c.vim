setlocal cinkeys-=0#
setlocal cinoptions=:0,g0,(0,Ws,l,t0
setlocal cindent

setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

function! GetDir() abort
  let dir = system("git rev-parse --show-toplevel")
  if v:shell_error != 0
    return ""
  endif
  return split(dir, "\n")[0]
endfunction

execute 'set tags+=' . GetDir() . '/tags'

if has('cscope')

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  set nocscopeverbose
  if filereadable("cscope.out")
    cs add cscope.out
  elseif filereadable(GetDir() . "cscope.out")
    execute 'cs add' . GetDir() . "/cscope.out"
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif

  set cscopeverbose

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  nnoremap gd :cs find g <C-R>=expand("<cword>")<CR><CR>
  nnoremap gr :cs find c <C-R>=expand("<cword>")<CR><CR>
endif
