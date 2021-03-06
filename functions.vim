function! HandleDuplicateLines(action)
  echom a:action
  if a:action == "show"
    echom "hey it was show"
    call search('/^\(.*\)\n\1$')
  else
    echom "wtf i shouldn't be here"
    "  g/^\(.*\)$\n\1$/d
    "  "diff method
    "  ":%s/^\(.*\)\n\1$/\1/
  endif
endfun

function! MakeQuery()
  norm "+p
  :%s/\[/varchar\(max\)\='
  :%s/\]/'
  :%s/\:/\@/g
  :silent %s/'false'/0
  :silent %s/'true'/1
  norm {odeclare
  norm dapggO
  norm ggPggddvap
  :'<,'>s/,//
endfun

function! LoadMyJavaClass()
  r$VIMHOME/customsnippets/javaclass.java
  norm ggddfSdw
  put=expand('%:t:r')
  norm d$k$pjddjj
endfun

function! RunMyJava(assert)
  let filename = expand('%:t')
  echom "filename: ".filename

  let compjava = 'javac '.filename
  echom "compile command: ".compjava

  lcd %:p:h
  let result = system(compjava)

  if !v:shell_error
    echom "Compilation succeeded, running program."
    if a:assert == 1
      exec '!java -ea' expand('%:t:r')
    else 
      exec '!java' expand('%:t:r')
    endif
  else
    echom "Compilation failed:"
    echom result
  endif

endfun

" Add HTML Comments to line
function! AddHTMLComments()
  exe 's/^/<!--/'
  exe 's/$/-->/'
  norm j
endfun

" Add HTML Comments to line
function! DelHTMLComments()
  exe 's/\S\{4\}//'
  exe 's/.\{3}$//'
  norm j
endfun

" Run Python scripts and put results in new split window
function! RunPython()
  new
  0read !python #:p
  wincmd j 
endfun

"" Change X/Y coordinates mathematically
function! ChangeCoords2(axis,oper,num)
  "s/\vy\=\"\d.{-}\"/ "technical debt: make it recognise y= d | y =d | y = d
  :call FixCoords(a:axis)
  exe
        \'%s/\('.a:axis.'="\)\(\d*\)/\=submatch(1).float2nr(submatch(2)'
        \.a:oper.a:num.')/gc'
endfun

"" Fix Coordinates to not have spaces between Coord, =, ", and NUM
function! FixCoords(axis)
  exe ':silent! %s/'.a:axis.'\s*=\s*"\s*\(\d*\)\s*"/'
        \.toupper(a:axis).'="\1"/g'
endfun

function! ChangeCoords()
  "s/\vy\=\"\d.{-}\"/ "technical debt: make it recognise y= d | y =d | y = d
  s/\vy\=\"\d.{-}\"=Sum(submatch(0))/
endfun

" Add amount to numbers
let g:S = 0 "result in global variable S
function! Sum(number, incAmount)
  let g:S = ''
  let g:S = a:number + a:incAmount
  echo g:S
  return g:S
endfunction

" Subtract amount to numbers
let g:S = 0 "result in global variable S
function! Sub(number, decAmount)
  let g:S = ''
  let g:S = a:number - a:decAmount
  echo g:S
  return g:S
endfunction

function! CustomTabularPatterns()
  if exists('g:tabular_loaded')
    AddTabularPattern! symbols / :/l0
    AddTabularPattern! hash /^[^>]*\zs=>/
    AddTabularPattern! chunks / \S\+/l0
    AddTabularPattern! assignment / = /l0
    AddTabularPattern! comma /^[^,]*,/l1
    AddTabularPattern! colon /:\zs /l0
    AddTabularPattern! options_hashes /:\w\+ =>/
  endif
endfunction

autocmd VimEnter * call CustomTabularPatterns()
map <Leader>t :Tabularize<space>/
vmap <Leader>t :Tabularize<space>/

" Is this even used right now?
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
