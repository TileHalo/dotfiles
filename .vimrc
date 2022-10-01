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
let maplocalleader=","

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
if has('cscope')
  set cscopeverbose
  set cscopetag

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  " cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

if executable('ctags')
  set nocscopetag
endif

set diffopt+=algorithm:patience
" Setting up ignores and path
set path+=**
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
python3 << endpython
import vim
from sys import version_info as v
vim.command('let python_version=%d' % (v[0] * 100 + v[1]))
endpython
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
set list
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

nnoremap <leader>cd :lcd %:h<CR>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
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
  Plug 'altercation/vim-colors-solarized'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'dkarter/bullets.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'glts/vim-magnum'
  Plug 'coreysharris/Macaulay2.vim'
  Plug 'glts/vim-radical'
  Plug 'glts/vim-textobj-comment'
  Plug 'honza/vim-snippets'
  Plug 'yinflying/matlab.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'jasonlong/vim-textobj-css' , {'for': ['css', 'scss', 'sass']}
  Plug 'jmcomets/vim-pony', {'for': 'python'}
  Plug 'ron-rs/ron.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-user'
  Plug 'lambdalisue/suda.vim'
  Plug 'lervag/vimtex', {'for': 'tex'}
  Plug 'majutsushi/tagbar'
  Plug 'matze/vim-tex-fold', {'for': 'tex'}
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'rbonvall/vim-textobj-latex', {'for': ['tex', 'latex']}
  Plug 'sheerun/vim-polyglot'
  Plug 'sirver/ultisnips'
  Plug 'guns/vim-clojure-static', {'for': 'clojure'}
  Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
  Plug 'venantius/vim-cljfmt', {'for': 'clojure'}
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-apathy'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dadbod'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-dotenv'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fireplace', {'for': ['clojure', 'scheme']}
  Plug 'tpope/vim-salve', {'for': 'clojure'}
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-haml'
  Plug 'tpope/vim-jdaddy'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-sexp-mappings-for-regular-people'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-tbone'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()

filetype plugin indent on
syntax enable

let g:vimtex_view_method = 'zathura'
" }}}
" Completion and snippets {{{
set cpt+=i,d
set omnifunc=syntaxcomplete#Complete

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" File browser {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

nnoremap <leader>nk :Lexplore<cr>
nnoremap <leader>tk :Tagbar<cr>
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
" Listchar dimming
hi SpecialKey ctermfg=10
hi Whitespace ctermfg=10
hi SignColumn ctermbg=8
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
augroup vimrc
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup end

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction

augroup ccpp
  autocmd!
  autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
augroup END

cabbrev sudo :w suda://%
" }}}
" NetRW {{{
let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}
" Termdebug {{{
hi debugPC term=reverse ctermbg=0
hi debugBreakpoint ctermbg=8 ctermfg=1
let g:termdebug_wide = 163
" }}}
" My wiki shenanigans {{{
nmap <leader>wd <Plug>(diary_open)
nmap <leader>ww <Plug>(index_open)
nmap <leader>wt <Plug>(todo_open)
nmap <leader>wci <Plug>(create_index)
" }}}
