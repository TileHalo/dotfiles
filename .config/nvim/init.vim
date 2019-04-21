" VIMRC
" MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
" Basic config {{{
let mapleader=" "

" This thing is bugged in neovim. Use sudoedit command
if !has('nvim')
  cnoremap W w !sudo tee > /dev/null %
endif

set encoding=utf8
set autoread
set scrolloff=5
set hidden
runtime macros/matchit.vim

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=500
set undoreload=500

" Backup
set backupdir=~/.vim/tmp

" Swap file
set directory=~/.vim/swap/
set completeopt-=preview
set formatoptions-=l
set textwidth=80

" Setting up ignores
set wildignore+=*/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
set wildignore+=*.wav,*.mp4,*.mp3
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=_pycache_,.DS_Store,.vscode,.localized
set wildignore+=.cache,node_modules,package-lock.json,yarn.lock,dist,.git,Cargo.lock

if executable('/usr/local/bin/python3.7')
  let g:python3_host_prog = '/usr/local/bin/python3.7'
elseif executable('python3.7')
  let g:python3_host_prog='python3.7'
elseif has('nvim')
  echo "Missing python 3.7. Neovim won't work normally"
endif

if executable('rg')
  set grepprg=rg\ --vimgrep\ --noheading\ --smart-case
endif
" }}}
" Basic UI {{{
set number
set showcmd
set lazyredraw
set cursorline
set wildmenu
set showmatch

" }}}
" Indent options {{{
set autoindent
" }}}
" Search options {{{
set incsearch
set hlsearch
set smartcase
" }}}
" Basic keybindings {{{

nnoremap <leader><leader> :nohlsearch<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext <cr>

map <leader>h :<C-u>split<CR>
map <leader>v :<C-u>vsplit<CR>
" }}}
" Plugins {{{
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')

  " Denite
  call dein#add('Shougo/denite.nvim')

  " Deoplete
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  " And its sources
  call dein#add('Shougo/neco-syntax')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/neco-vim')
  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next',
        \ 'build': 'bash install.sh'}, )
  call dein#add('Shougo/deoplete-clangx')

  " Languages
  " Golang
  call dein#add('fatih/vim-go', {'build': ':GoUpdateBinaries'})
  call dein#add('zchee/deoplete-go', {'build': ':!go get -u github.com/mdempsky/gocode'})

  " Rust
  call dein#add('rust-lang/rust.vim')

  " Scala
  call dein#add('ensime/ensime-vim')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('derekwyatt/vim-sbt')
  call dein#add('ktvoelker/sbt-vim')

  " C/C++

  " HTML
  call dein#add('mattn/emmet-vim')

  " Pug
  call dein#add('digitaltoad/vim-pug')

  " Snippets
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')

  " Commenting
  call dein#add('tpope/vim-commentary')

  " Surrounding
  call dein#add('tpope/vim-surround')
  
  " Builder
  call dein#add('neomake/neomake')

  " Tag generation
  call dein#add('jsfaint/gen_tags.vim')

  " Tmux
  call dein#add('ericpruitt/tmux.vim', {'rtp': 'vim/'})

  " Vimwiki
  call dein#add('vimwiki/vimwiki')

  " Linter
  call dein#add('w0rp/ale')

  " Colourscheme
  call dein#add('altercation/vim-colors-solarized')

  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " Distraction free writing
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/limelight.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
" }}}
" And their configuration {{{
" Denite {{{
call denite#custom#var('file_rec', 'command',
\ ['rg', '--files', '--glob', '!.git'])

call denite#custom#map('insert', 
      \ '<C-k>', 
      \ '<denite:move_to_previous_line>', 
      \ 'noremap')  

call denite#custom#map('insert', 
      \ '<C-j>', 
      \ '<denite:move_to_next_line>', 
      \ 'noremap')  

nnoremap <leader>d :Denite
nnoremap <leader>db :Denite buffer<cr>
nnoremap <leader>dch :Denite change<cr>
nnoremap <leader>dco :Denite colorscheme<cr>
nnoremap <leader>dcm :Denite command<cr>
nnoremap <leader>dcmh :Denite command_history<cr>
nnoremap <leader>dd :Denite dein<cr>
nnoremap <leader>ddr :Denite directory_rec<cr>
nnoremap <leader>df :Denite file<cr>
nnoremap <leader>dfo :Denite file_old<cr>
nnoremap <leader>dfp :Denite file_point<cr>
nnoremap <leader>dft :Denite filetype<cr>
nnoremap <leader>dg :Denite grep<cr>
nnoremap <leader>dh :Denite help<cr>
nnoremap <leader>dj :Denite jump<cr>
nnoremap <leader>dl :Denite line<cr>
nnoremap <leader>dm :Denite menu<cr>
nnoremap <leader>do :Denite outline<cr>
nnoremap <leader>dr :Denite register<cr>
nnoremap <leader>dt :Denite tag<cr>
" }}}
" Deoplete {{{
" Language Client {{{
let g:LanguageClient_serverCommands = {
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
  \ 'javascript': ['/home/leo/.nvm/version/node/v11.2.0/bin/javascript-typescript-stdio'],
  \ 'python': ['/usr/local/bin/pyls'],
  \ 'ruby': ['/usr/local/bin/solargraph stdio']
\ }

function! EnableLC()
  let lckeys = keys(g:LanguageClient_serverCommands)
  for key in lckeys
    if key == &filetype
      call LC_maps()
    endif
  endfor
endfunction

function! LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    
    nnoremap <F5> :call LanguageClient_contextMenu()<CR>

    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <silent> <leader>gd :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <buffer> <silent> <leader>gf :call LanguageClient#textDocument_formatting()<CR>
    nnoremap <buffer> <silent> gff :call LanguageClient#textDocument_rangeFormatting()<CR>

    nnoremap <buffer> <silent> <leader>gr :Denite references<CR>
    nnoremap <buffer> <silent> <leader>gs :Denite documentSymbol<CR>
  endif
endfunction


" }}}
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')

let g:deoplete#enable_at_startup=1
" }}}
" Vim-go {{{
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

" }}}
" Neomake {{{
call neomake#configure#automake('w')
" }}}
" gen_tags {{{
let g:gen_tags#gtags_auto_gen = 1
let g:gen_tags#gtags_default_map = 1

" }}}
" fakeclip {{{
let g:vim_fakeclip_tmux_plus=1 
" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

" }}}
" Goyo {{{
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  set spell
endfunc"ion

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  call SetStatus()
endfunction
" }}}
" Limelight {{{
let g:limelight_conceal_ctermfg = 245  " Solarized Base1
let g:limelight_conceal_guifg = '#8a8a8a'  " Solarized Base1
" }}}
" }}}
" Colours {{{

" Colourscheme
set background=dark
colorscheme solarized
" Statusline 


function! GitHead()
  let git = fugitive#head()
  if git != ''
    return ' :: ' . git 
  else
    return ''
  endif
endfunction

function! Modified()
  if &mod == 1
    return ' :: [+] '
  else
    return ''
  endif
endfunction

function! SetStatus()
  set laststatus=2
  set statusline=
  set statusline+=\ \ <\ %f%{Modified()}%{GitHead()}\ ::\ %y>
  " switching to right side
  set statusline+=%=
  set statusline+=<\ %n\ ::\ %l\ ::\ %L\ >

  hi! StatusLine ctermfg=0
  hi! StatusLine ctermbg=1

  hi! StatusLineNC ctermfg=0
  hi! StatusLineNC ctermbg=02

  " Separator
  hi VertSplit ctermfg=1
  hi VertSplit ctermbg=235
endfunction

call SetStatus()
" }}}
" Autogroups {{{
augroup Help
  autocmd FileType help wincmd L
  autocmd FileType * call EnableLC()
augroup END
augroup GOYO
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END
"  }}}
"  Spelling {{{
set spelllang="en_gb"
"  }}}
" vim:foldmethod=marker:foldlevel=0:expandtab:shiftwidth=2:cc=81
