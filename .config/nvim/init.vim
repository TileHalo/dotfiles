" VIMRC
" MAINTAINER: Leo Lahti <leo.lahti1@gmail.com>
" Basic config {{{
let mapleader=" "

" This thing is slightly bugged
cnoremap W w !sudo tee > /dev/null %

set encoding=utf8
set autoread

nnoremap <leader>w :w<CR>

" Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=500
set undoreload=500

" Backup
set backupdir=~/.vim/tmp

" Swap file
set directory=~/.vim/swap/
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
nnoremap <s-tab> ?
inoremap <c-c> <Esc>

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
  call dein#add('zchee/deoplete-clang')
  call dein#add('clojure-vim/async-clj-omni')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('eagletmt/neco-ghc', {'build': 'cabal install ghc-mod'})
  call dein#add('carlitux/deoplete-ternjs', { 'build': 'npm install -g tern' })
  call dein#add('Shougo/neco-vim')
  call dein#add('phpactor/phpactor', {'build': 'composer install', 'for': 'php'})
  call dein#add('kristijanhusak/deoplete-phpactor')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('racer-rust/vim-racer')

  " Languages
  " Golang
  call dein#add('fatih/vim-go', {'build': ':GoUpdateBinaries'})

  " Rust
  call dein#add('rust-lang/rust.vim')

  " Scala
  call dein#add('ensime/ensime-vim')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('derekwyatt/vim-sbt')
  call dein#add('ktvoelker/sbt-vim')

  " Pug
  call dein#add('digitaltoad/vim-pug')

  " Snippets
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')

  " Commenting
  call dein#add('tpope/vim-commentary')
  
  " User interface
  call dein#add('chriskempson/base16-vim')

  " Builder
  call dein#add('neomake/neomake')

  " Tag generation
  call dein#add('jsfaint/gen_tags.vim')

  " Better clipboard
  call dein#add('cazador481/fakeclip.neovim')

  " Tmux
  call dein#add('ericpruitt/tmux.vim', {'rtp': 'vim/'})

  " Vimwiki
  call dein#add('vimwiki/vimwiki')

  " Linter
  call dein#add('w0rp/ale')

  " Colourscheme
  call dein#add('altercation/vim-colors-solarized')

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
" clang {{{
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.8/lib/clang'
" }}}
" clojure {{{
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
" }}}
" Go {{{
" }}}
" GHC {{{
let g:necoghc_enable_detailed_browse=1
" }}}
" JS {{{
" }}}
" neco-vim {{{
" }}}
" phpactor {{{
" }}}
" jedi {{{
let g:python3_host_prog = '/usr/bin/python3'
" }}}
" Rust {{{
" let g:deoplete#sources#rust#racer_binary='/home/leo/.cargo/bin/racer'
let g:racer_cmd = "/home/leo/.cargo/bin/racer"
let g:deoplete#sources#rust#rust_source_path=system('echo `rustc --print sysroot`/lib/rustlib/src/rust/src')

augroup RUST
  au FileType rust nmap gd <Plug>(rust-def)
  au FileType rust nmap gs <Plug>(rust-def-split)
  au FileType rust nmap gx <Plug>(rust-def-vertical)
  au FileType rust nmap <leader>gd <Plug>(rust-doc)
augroup END

" General Rust
let g:rustfmt_autosave = 1
" }}}
let g:deoplete#enable_at_startup=1
" }}}
" Neomake {{{
call neomake#configure#automake('w')
" }}}
" gen_tags {{{
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

" }}}
" }}}
" Colorscheme {{{
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
"   hi StatusLine ctermbg=18
" endif
set background=dark
colorscheme solarized
" }}}
" Autogroups {{{
augroup Help
  autocmd FileType help wincmd L
augroup END
"  }}}

 
" vim:foldmethod=marker:foldlevel=0:expandtab:shiftwidth=2:cc=81
