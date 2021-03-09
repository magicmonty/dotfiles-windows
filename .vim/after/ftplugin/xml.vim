" XML/XSL formatting
setlocal shiftwidth=2

" Use the open source tool to veryify XML/XSL
compiler xmllint

setlocal equalprg=xmllint\ --format\ --recover\ -

" Use the open source tool to reformat the document
" Double quote the filename if on windows
if has('win32')
    vnoremap <buffer> <Leader>xf :!xmllint --format --recover "-"<CR> 
    nnoremap <buffer> <Leader>xf :.,.!xmllint --format --recover "-"<CR> 
else
    vnoremap <buffer> <Leader>xf :!xmllint --format --recover -<CR> 
    nnoremap <buffer> <Leader>xf :.,.!xmllint --format --recover -<CR> 
endif
noremap zz za

let g:syntastic_xml_checkers = [ 'xmllint' ]
let g:xml_syntax_folding=1
setlocal foldmethod=syntax
setlocal foldnestmax=10
setlocal foldminlines=0
syntax on
