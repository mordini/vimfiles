set nocompatible
source ~/vimfiles/functions.vim

if has('win32') || has ('win64')
    let $VIMHOME = $HOME."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif
    
set guioptions-=m  "remove menu bar
set guioptions-=M  "don't load menu script
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

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
Plug 'godlygeek/tabular'
Plug 'leafgarland/typescript-vim'
Plug 'vim-scripts/visSum.vim'
" Plug 'tpope/vim-surround'
call plug#end()
filetype on

set guifont=Consolas
syntax on
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
colorscheme monokai
set ignorecase
set smartcase
set hlsearch
set incsearch
set showcmd
autocmd! BufEnter * silent! lcd %:p:h
autocmd! GUIEnter * set noerrorbells
nnoremap <Leader>b :ls<CR>:b
nnoremap <Leader>d :%d<CR>
nnoremap <Leader>c :call LoadMyJavaClass()<CR>
nnoremap <Leader>j :call RunMyJava(0)<CR>
nnoremap <Leader>je :call RunMyJava(1)<CR>
nnoremap <Leader>s :call HandleDuplicateLines("show")<CR>
nnoremap <Leader>y :%y+<CR>
nnoremap <Leader>w :normal "+yy :command+<CR>
nnoremap <Leader>] gg=G``:retab!<CR>
nnoremap <CR> G
nnoremap <silent> <C-k> :call AddHTMLComments()<CR>
nnoremap <silent> <C-l> :call DelHTMLComments()<CR>
autocmd! BufRead * set hidden
autocmd! BufRead *.rep set ft=xml
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
nnoremap <leader><leader> <c-^>
nnoremap <silent> <Leader>, :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

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

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" map running python scripts to F5
" experimenting with different settings
" section to be cleared with just one, or possibly with if statement per OS
"au FileType python map <silent> <F5> :!clear && python %<CR><CR>
"au FileType python exec 'map <F5> :!clear && python %<CR><CR>'
" au FileType python exec 'map <F5> :0read !start python %<CR><CR>'
"au FileType python map <F5> :!python %<CR>

" testing these
" first two to put into buffer
" second two to merely echo the output
"au! WinEnter *.py exec 'map <F5> new | 0read !python '.expand('#:p').'<CR><CR>'
au! BufWinEnter *.py map <F5> :call RunPython()<CR>
au! WinEnter *.py map <F5> :call RunPython()<CR>
"au WinEnter *.py exec 'map <silent> <F5> :echo system("python ".expand("%"))<CR>'
"au BufWinEnter *.py exec 'map <silent> <F5> :echo system("python ".expand("%"))<CR>'
