" VIMRC
"
" MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
" Basic config {{{
let mapleader=" "

" This thing is bugged in neovim. Use sudoedit command
if !has('nvim')
  cnoremap W w !sudo tee > /dev/null %
endif

set encoding=utf8
set autoread
set autowrite
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
set formatoptions-=l
set textwidth=80

" Ctags
if executable('ctags')
  set tags+=.git/tags,../.git/tags,../**/.git/tags
  set tags+=.git/tags_dir/prj_tags,../.git/tags_dir/prj_tags,
  set tags+=../**/.git/tags_dir/prj_tags
endif

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
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif
" }}}
" Basic UI {{{
set number
set relativenumber
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

map <Left> :vertical resize -1<cr>
map <Down> :resize +1<cr>
map <Up> :resize -1<cr>
map <Right> :vertical resize +1<cr>

" }}}
" Plugins {{{
if !has('nvim')
  call plug#begin("~/.vim/plugged")
else
  call plug#begin("~/.local/share/nvim/plugged")
endif
  " Languages
  " Rust
  Plug 'rust-lang/rust.vim'

  " Scala
  Plug 'derekwyatt/vim-scala'
  Plug 'derekwyatt/vim-sbt'
  if has('python')
    Plug 'ktvoelker/sbt-vim'
  endif

  " HTML
  Plug 'mattn/emmet-vim'

  " Pug
  Plug 'digitaltoad/vim-pug'

  " Snippets
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'honza/vim-snippets'

  " Commenting
  Plug 'tpope/vim-commentary'

  " Surrounding
  Plug 'tpope/vim-surround'
  
  " Tag generation
  Plug 'jsfaint/gen_tags.vim'

  " Vimwiki
  Plug 'vimwiki/vimwiki'

  " Colourscheme
  Plug 'altercation/vim-colors-solarized'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " Distraction free writing
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

call plug#end()

filetype plugin indent on
syntax enable
" }}}
" And their configuration {{{

" gen_tags {{{
let g:gen_tags#use_cache_dir=0
let g:gen_tags#blacklist=['$HOME']
" }}}
" Snippets {{{


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
" Completion {{{

set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,noinsert,
set complete=.,w,b,u,i
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

augroup Goyo
  autocmd!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

augroup Ctags
  autocmd!
  autocmd FileType c,cpp,go 
        \ autocmd BufWritePost <buffer> :GenCtags
augroup END

augroup Quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
"  }}}
"  Grepping {{{
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr system(&grepprg . ' ' . shellescape(<q-args>))
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr system(&grepprg . ' ' . shellescape(<q-args>))
"  }}}
"  Spelling {{{
set spelllang="en_gb"
"  }}}
