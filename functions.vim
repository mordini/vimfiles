" Run Python scripts and put results in new split window
function! RunPython()
				new
				0read !python #:p
				wincmd j 
endfun

" Change X/Y coordinates mathematically
function! ChangeCoords()
				"s/\vy\=\"\d.{-}\"/ "technical debt: make it recognise y= d | y =d | y = d
				s/\vy\=\"\d.{-}\"=Sum(submatch(0))/
endfun

" Add amount to numbers
let g:S = 0 "result in global variable S
function! Sum(number)
				let g:S = g:S + a:number
				return a:number
endfunction

" Subtract amount to numbers
let g:S = 0 "result in global variable S
function! Sub(number)
				let g:S = g:S - a:number
				return a:number
endfunction

