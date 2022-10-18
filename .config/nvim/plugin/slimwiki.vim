
nnoremap <Plug>(diary_open) :e ~/wiki/diaries/`date +\%d.\%m.\%Y`.md<CR>
nnoremap <Plug>(todo_open) :e ~/wiki/todos/list.md<CR>
nnoremap <Plug>(index_open) :e ~/wiki/README.md<CR>
nnoremap <Plug>(create_index) i<c-r>glob('**/*')<cr><Esc>

command! -nargs=+ Tags call s:GrepTags(<f-args>)

function! s:GrepTags(...)
  execute 'vimgrep `\['.join(a:000).'\]` ~/wiki/**/*.md'
endfunction
