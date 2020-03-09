" VIMRC

" MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
" Basic config {{{
set encoding=utf8
set autoread
set autowrite
set hidden
set exrc
runtime macros/matchit.vim

let mapleader=" "

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=500
set undoreload=500

" Backup
set backupdir=~/.vim/tmp

" Swap file
set directory=~/.vim/swap/
set cc=80

" Ctags and Cscope
if executable('ctags')
  set tags+=.git/tags,../.git/tags,../**/.git/tags
  set tags+=.git/tags_dir/prj_tags,../.git/tags_dir/prj_tags,
  set tags+=../**/.git/tags_dir/prj_tags
endif

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
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

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif
if has("python3")
  python3 import vim; from sys import version_info as v; vim.command('let python_version=%d' % (v[0] * 100 + v[1]))
else
  let python_version=0
endif

if python_version < 307
  echo printf("Neovim won't work properly %d", python_version)
else
  let g:python3_host_prog='python'
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
set backspace=indent,eol,start
set breakindent
set browsedir=buffer

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

map <Left> :vertical resize -1<cr>
map <Down> :resize +1<cr>
map <Up> :resize -1<cr>
map <Right> :vertical resize +1<cr>

vnoremap $( <esc>`>a)<esc>`<i(<esc>
vnoremap $[ <esc>`>a]<esc>`<i[<esc>
vnoremap ${ <esc>`>a}<esc>`<i{<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>
" }}}
" Plugins {{{
if empty(glob('~/.local/share/nvim/plugged')) && has('nvim')
  silent !curl -fLo ~/.local/share/nvim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif empty(glob('~/.vim/autoload/plug.vim')) && !has('nvim')
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !has('nvim')
  call plug#begin("~/.vim/plugged")
else
  call plug#begin("~/.local/share/nvim/plugged")
endif
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'glts/vim-radical'
  Plug 'glts/vim-magnum'


  Plug 'lifepillar/vim-solarized8'
  Plug 'altercation/vim-colors-solarized'
  Plug 'tikhomirov/vim-glsl'
call plug#end()

filetype plugin indent on
syntax enable
" }}}
" Completion {{{
set cpt+=i,d
set omnifunc=syntaxcomplete#Complete
" }}}
" File browser {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

nnoremap <leader>nk :Lexplore<cr>
" }}}
" Colours {{{

" Colourscheme
set background=dark
silent! colorscheme solarized
" Statusline 


function! GitHead()
  if !(exists('fugitive#head'))
    return ''
  endif
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
"  Grepping {{{
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr system(&grepprg . ' ' . shellescape(<q-args>))
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr system(&grepprg . ' ' . shellescape(<q-args>))

augroup Quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
"  }}}
"  Spelling {{{
set spelllang="en_gb"
"  }}}
" Helpers {{{

" }}}
