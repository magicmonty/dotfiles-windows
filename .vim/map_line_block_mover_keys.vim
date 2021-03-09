" map_line_block_mover_keys.vim
"
" Map Control+Up/Down to move lines and selections up and down.
"
" Based on http://vim.wikia.com/wiki/VimTip646
"

"
" Define maps for Normal and Visual modes, then re-use
" them for Insert and Select.
"

" Normal mode
nnoremap <silent>  <C-S-Up>    :move -2<CR>
nnoremap <silent>  <C-S-Down>  :move +<CR>

" Visual mode (only; does not include Select mode)
xnoremap <silent>  <C-S-Up>    :move '<-2<CR>gv
xnoremap <silent>  <C-S-Down>  :move '>+<CR>gv

" Insert mode
imap     <silent>  <C-S-Up>    <C-O><C-S-Up>
imap     <silent>  <C-S-Down>  <C-O><C-S-Down>

" Select mode
smap     <silent>  <C-S-Up>    <C-G><C-Up><C-G>
smap     <silent>  <C-S-Down>  <C-G><C-Down><C-G>

" end map_line_block_mover_keys.vim
