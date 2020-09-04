" ________
" vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'

call plug#end()


" ____
" Main
syntax on
set termguicolors

color dracula
hi link haskellIdentifier DraculaGreen

set number
set relativenumber

set title
set splitright
set splitbelow
set noshowmode
set hidden

set mouse=a
set scrolloff=5
set clipboard+=unnamedplus
"set signcolumn=yes:1

set shada="NONE"
set history=0
set nobackup
set nowritebackup
set noswapfile
set noundofile

set tabstop=8
set expandtab
set shiftwidth=2
set softtabstop=2

set ignorecase
set smartcase

"set spell spelllang=en_us

autocmd BufWritePre * %s/\s\+$//e


" ___________
" Keybindings
noremap <C-c> <Esc>
inoremap <C-c> <Esc>

noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
inoremap <Up> <Nop>
inoremap <Right> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>

map q <Nop>

map H ^
map L $

nnoremap <silent><Space> :nohl<CR>

nnoremap <silent><C-j> :m+1<CR>==
nnoremap <silent><C-k> :m-2<CR>==
inoremap <silent><C-j> <Esc>:m+1<CR>==i
inoremap <silent><C-k> <Esc>:m-2<CR>==i

nnoremap <silent><C-w> :bd<CR>

autocmd filetype haskell
  \ nnoremap <C-l> :w<CR>:! ormolu --mode inplace %<CR>:e<CR>


" _____________
" lightline.vim
let g:lightline = {
  \ 'colorscheme': 'dracula',
  \ }


" _______
" fzf.vim
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :GFiles<CR>

" Hide statusline
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noruler
    \| autocmd BufLeave <buffer> set laststatus=2 ruler
endif
