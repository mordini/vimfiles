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
