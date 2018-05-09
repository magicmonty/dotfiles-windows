" Vim syntax folding file
" Language: paket.dependencies 
" Maintainer: Martin Gondermann
" Latest Revision: 02 May 2018

setlocal foldmethod=expr
setlocal foldexpr=GetPaketDepsFold(v:lnum)

function! NextPaketDepsGroupLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1

  while current <= numlines
    if getline(current) =~? '\v^group .*$'
      return current
    endif

    let current += 1
  endwhile

  return -2
endfunction

function! GetPaketDepsFold(lnum)
  if getline(a:lnum) =~? '\v^group .*$'
    return '1'
  endif

  let next_group = NextPaketDepsGroupLine(a:lnum)
  let next_line = a:lnum + 1

  if next_group == next_line
    return '0'
  else
    return '1'
  endif

  return '-1'
endfunction
