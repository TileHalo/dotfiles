function! HeaderFT()
   if filereadable(expand("%:r") . ".cpp")
     set filetype=cpp
   else
     set filetype=c
   endif
endfunction

augroup filetypedetect
  au! BufRead,BufNewFile,BufWritePost *.h call HeaderFT()
augroup END

autocmd! BufNewFile,BufRead,BufWritePost *.h call HeaderFT()
