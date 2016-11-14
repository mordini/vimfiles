set nocompatible
"source $VIMRUNTIME/vimrc_example.vim

set guioptions-=m  "remove menu bar
set guioptions-=M  "don't load menu script
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar


set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
noremap  <Up>    <NOP>
noremap  <Down>  <NOP>
noremap  <Left>  <NOP>
noremap  <Right> <NOP>

" vim-plug begin
" let g:plug_url_format = 'git@github.com:%s.git'
filetype off
call plug#begin('~/vimfiles/bundle')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'crusoexia/vim-monokai'
Plug 'airblade/vim-rooter'
Plug 'gavinbeatty/dragvisuals.vim'
Plug 'datawraith/auto_mkdir'
call plug#end()
filetype on

set guifont=Consolas
syntax on
colorscheme monokai
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
set ignorecase
set smartcase
set hlsearch
set incsearch
autocmd! GUIEnter * set noerrorbells
nnoremap <Leader>b :ls<CR>:b
autocmd! BufRead * set hidden
autocmd! BufRead *.rep set ft=xml
set tabstop=2
nnoremap <leader><leader> <c-^>

" Dragvisuals Plugin Begin
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
"##     " Remove any introduced trailing whitespace after moving...     ##
let g:DVB_TrimWS = 1
" end Dragvisuals Plugin

set directory=~/vimfiles/swapfiles
set backupdir=~/vimfiles/backups
set undodir=~/vimfiles/undofiles
