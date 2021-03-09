" vim: foldmethod=marker
set nocompatible  " Vim (not vi) settings. Set early for side effects.

" Encoding. {{{
if has("vim_starting")
  " Changing encoding in Vim at runtime is undefined behavior
  set encoding=utf-8
  set fileencoding=utf-8
  set fileformats=dos,unix,mac
endif

" this command has to be after 'set encoding'
scriptencoding utf-8
" }}}

if has("win32")
  source ~/.vim/plugins.vim
  
  " runtime map_option_highlighting_keys.vim
  " runtime win32_mappings.vim
endif 

let mapleader=" "
let maplocalleader=" "
let g:mapleader=" "
set noundofile          " disable the persistent Undo function (and the corresponding .un~ file)
set showmode            " show the input mode in the footer
set shortmess+=I        " Don't show the Vim welcome screen.
set shortmess+=c        " Don't pass messages into |ins-completion-menu|.
set signcolumn=yes
set autoindent          " Copy indent from current line for new line.
set nosmartindent       " 'smartindent' breaks right-shifting of # lines.

set hidden              " Keep changed buffers without requiring saves.

set history=5000        " Remember this many command lines.

set ruler               " Always show the cursor position.
set showcmd             " Display incomplete commands.
set incsearch           " Do incremental searching.
set hlsearch            " Highlight latest search pattern.
set number              " Display line numbers.
set relativenumber      " show line numbers centred around the current line
set numberwidth=4       " Minimum number of columns to show for line numbers.
set laststatus=2        " Always show a status line.
set visualbell t_vb=    " Use null visual bell (no beeps or flashes).

set scrolloff=3         " Context lines at top and bottom of display.
set sidescrolloff=5     " Context columns at left and right
set sidescroll=1        " Number of chars to scroll when scrolling sideways.

set nowrap              " Don't wrap the display of long lines.
set linebreak           " Wrap at 'breakat' char vs display edge if 'wrap' on.
set display=lastline    " Display as much of a window's last line as possible.



set expandtab           " Insert spaces for <Tab> press; use spaces to indent.
set smarttab            " Tab respects 'shiftwidth', 'tabstop', 'softtabstop'.
set tabstop=2           " Set the visible width of tabs.
set softtabstop=2       " Edit as if tabs are 2 characters wide.
set shiftwidth=2        " Number of spaces to use for indent and unindent.
set shiftround          " Round indent to a multiple of 'shiftwidth'.

set ignorecase          " Ignore case for pattern matches (\C overrides).
set smartcase           " Override 'ignorecase' if pattern contains uppercase.
set wrapscan            " Allow searches to wrap around EOF.

set cursorline          " highlight the current screen line...
set nocursorcolumn      " ...or screen column...
set colorcolumn=        " ...or margins (but see toggle_highlights.vim).

set virtualedit=block   " Allow virtual editing when in Visual Block mode.

set foldcolumn=3        " Number of columns to show at left for folds.
set foldnestmax=3       " Only allow 3 levels of folding.
set foldlevelstart=99   " Start with all folds open.

set whichwrap+=<,>,[,]  " Allow left/right arrows to move across lines.

" set nomodeline          " Ignore modelines.
set nojoinspaces        " Don't get fancy with the spaces when joining lines.
set textwidth=0         " Don't auto-wrap lines except for specific filetypes.

" Turn 'list' off by default, since it interferes with 'linebreak' and
" 'breakat' formatting (and it's ugly and noisy), but define characters to use
" when it's turned on.

set nolist
set listchars =tab:>-           " Start and body of tabs
set listchars +=trail:.         " Trailing spaces
set listchars +=extends:>       " Last column when line extends off right
set listchars +=precedes:<      " First column when line extends off left
set listchars +=eol:$           " End of line

set backspace=indent,eol,start  " Backspace over everything in Insert mode

set noshowmatch                 " Don't jump to matching characters
set matchpairs=(:),[:],{:},<:>  " Character pairs for use with %, 'showmatch'
set matchtime=1                 " In tenths of seconds, when showmatch is on

set wildmenu                    " Use menu for completions
set wildmode=full

if has("multi_byte") 
  setglobal nobomb              " dont write a UTF-8 BOM 
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf8,latin1
endif

" Enable mouse support if it's available.
if has('mouse')
  set mouse=a
endif

set nobackup
set nowritebackup

" Update the swap file every 20 characters. I don't like to lose stuff.
set updatecount=20

" Switch on syntax highlighting when the terminal has colors, or when running
" in the GUI. Set the do_syntax_sel_menu flag to tell $VIMRUNTIME/menu.vim
" to expand the syntax menu.
"
" Note: This happens before the 'Autocommands' section below to give the syntax
" command a chance to trigger loading the menus (vs. letting the filetype
" command do it). If do_syntax_sel_menu isn't set beforehand, the syntax menu
" won't get populated.
"
if &t_Co > 2 || has("gui_running")
    let do_syntax_sel_menu=1
    syntax on
endif

if has('gui_running')
  set guifont=Monoid_NF:h9:cANSI
  set go-=m
  set go-=T
  set go-=r
  set go-=L
  let g:solarized_menu=0
  au GUIEnter * simalt ~x
  if has('windows')
    set renderoptions=type:directx
  end
endif

if has("autocmd") && !exists("autocommands_loaded")

  " Set a flag to indicate that autocommands have already been loaded,
  " so we only do this once. I use this flag instead of just blindly
  " running `autocmd!` (which removes all autocommands from the
  " current group) because `autocmd!` breaks the syntax highlighting /
  " syntax menu expansion logic.
  "
  let autocommands_loaded = 1

  " Enable filetype detection, so language-dependent plugins, indentation
  " files, syntax highlighting, etc., are loaded for specific filetypes.
  "
  " Note: See $HOME/.vim/ftplugin and $HOME/.vim/after/ftplugin for
  " most local filetype autocommands and customizations.
  "
  filetype off
  filetype plugin indent off

  set runtimepath+=$GOROOT/misc/vim

  filetype on
  syntax on
  filetype plugin indent on

  " When editing a file, always jump to the last known cursor
  " position. Don't do it when the position is invalid or when inside
  " an event handler (happens when dropping a file on gvim).
  "
  autocmd BufReadPost *
      \   if line("'\"") > 0 && line("'\"") <= line("$") |
      \       exe "normal g`\"" |
      \   endif

  " Resize Vim windows to equal heights and widths when Vim itself
  " is resized.
  autocmd VimResized * wincmd =

  " Treat buffers from stdin (e.g.: echo foo | vim -) as scratch buffers.
  autocmd StdinReadPost * :set buftype=nofile

  augroup vimrcEx
    autocmd!

    autocmd BufRead,BufNewFile	*.build		setfiletype xml
    autocmd BufRead,BufNewFile	*.targets	setfiletype xml
    autocmd BufRead,BufNewFile	*.nunit		setfiletype xml
    autocmd BufRead,BufNewFile	*.config	setfiletype xml
    autocmd BufRead,BufNewFile	*.xaml		setfiletype xml
    autocmd BufRead,BufNewFile	*.DotSettings		setfiletype xml

    autocmd FocusLost * silent! :wa
  augroup END

endif " has("autocmd")

augroup git
  autocmd!

  " Open quickfix and fugitive's git commit windows at full horizontal
  " width. Via http://nosubstance.me/articles/2013-09-21-my-vim-gems/
  "
  autocmd FileType qf,gitcommit wincmd J
augroup END

"""
""" Key mappings
"""

if has("win32")
  behave mswin
else
  " Set 'selection', 'selectmode', 'mousemodel' and 'keymodel' to make
  " both keyboard- and mouse-based highlighting behave more like Windows
  " and OS X. (These are the same settings you get with `:behave mswin`.)
  "
  " Note: 'selectmode', 'keymodel', and 'selection' are also set within
  " map_movement_keys.vim, since they're critical to the behavior of those
  " mappings (although they should be set to the same values there as here.)
  "
  " Note: Under MacVim, `:let macvim_hig_shift_movement = 1` will cause MacVim
  " to set selectmode and keymodel. See `:help macvim-shift-movement` for
  " details.
  "
  set selectmode=mouse,key
  set keymodel=startsel,stopsel
  set selection=exclusive
  set mousemodel=popup
endif

" Backspace in Visual mode deletes selection.
"
vnoremap <BS> d

" Tab/Shift+Tab indent/unindent the highlighted block (and maintain the
" highlight after changing the indentation). Works for both Visual and Select
" modes.
"
vnoremap <Tab>    >gv
vnoremap <S-Tab>  <gv

" Map Control+Up/Down to move lines and selections up and down.
"
runtime map_line_block_mover_keys.vim
if has("vim-fireplace")
  runtime vim-fireplace-mappings.vim
endif

" Disable paste-on-middle-click.
"
map  <MiddleMouse>    <Nop>
map  <2-MiddleMouse>  <Nop>
map  <3-MiddleMouse>  <Nop>
map  <4-MiddleMouse>  <Nop>
imap <MiddleMouse>    <Nop>
imap <2-MiddleMouse>  <Nop>
imap <3-MiddleMouse>  <Nop>
imap <4-MiddleMouse>  <Nop>

" Center the display line after searches. (This makes it *much* easier to see
" the matched line.)
"
" More info: http://www.vim.org/tips/tip.php?tip_id=528
"
nnoremap n   nzz
nnoremap N   Nzz
nnoremap *   *zz
nnoremap #   #zz
nnoremap g*  g*zz
nnoremap g#  g#zz

" Edit user's vimrc in new tabs.
"
if has('nvim')
  nnoremap <leader>ev :tabedit ~/_vimrc<CR>
else
  nnoremap <leader>ev :tabedit $MYVIMRC<CR>
endif
nnoremap <leader>ep :tabedit ~/.vim/plugins.vim<CR>
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC 
  au BufWritePost .gvimrc,_gvimrc,gvimrc so $MYGVIMRC 
augroup END

" Make page-forward and page-backward work in insert mode.
"
inoremap <C-F>  <C-O><C-F>
inoremap <C-B>  <C-O><C-B>

" Make Alt+Up/Down work as PageUp and PageDown
"
nnoremap    <M-Up>      <PageUp>
inoremap    <M-Up>      <PageUp>
vnoremap    <M-Up>      <PageUp>
nnoremap    <M-Down>    <PageDown>
inoremap    <M-Down>    <PageDown>
vnoremap    <M-Down>    <PageDown>

" Overload Control+L to clear the search highlight as it's redrawing the screen.
"
nnoremap <C-L> :nohlsearch<CR><C-L>
inoremap <C-L> <Esc>:nohlsearch<CR><C-L>a
vnoremap <C-L> <Esc>:nohlsearch<CR><C-L>gv

" Keep the working line in the center of the window. This is a toggle, so you
" can bounce between centered-working-line scrolling and normal scrolling by
" issuing the keystroke again.
"
" From this message on the MacVim mailing list:
" http://groups.google.com/group/vim_mac/browse_thread/thread/31876ef48063e487/133e06134425bda1?hl=enÂ¿e06134425bda1
"
nnoremap <Leader>zz  :let &scrolloff=999-&scrolloff<CR>

"
" Make it easy to :Tabularize
"
nmap <leader>aa :Tabularize /\|/l0<CR>
vmap <leader>aa :Tabularize /\|/l0<CR>

" Make the dot command operate over a Visual range.
" (Excellent tip from Drew Neil's Vim Masterclass.)
"
xnoremap .  :normal .<CR>

" Shortcuts to commonly-used fugitive.vim features
"
nnoremap <Leader>gs  :Gstatus<CR>
nnoremap <Leader>gd  :Gdiff<CR>

""" Abbreviations
"""
runtime set_abbreviations.vim

if exists(":RainbowParenthesesToggle")
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
endif

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

nnoremap <leader><Tab> :tabNext<cr>

" UltiSnips
if has("python") || has("python3")
  let g:UltiSnipsExpandTrigger="<c-n>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
endif

noremap <leader>bn :bn<cr>
noremap <leader>bp :bp<cr>

set t_Co=256
highlight clear SignColumn

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Remap common typo
map q: :q

" Quickly change indent settings
command! SetIndent2Spaces set nopi shiftwidth=2 softtabstop=2
command! SetIndent4Spaces set nopi shiftwidth=4 softtabstop=4

map <leader>i2 :SetIndent2Spaces<CR>
map <leader>i4 :SetIndent4Spaces<CR>

" Toggle folding
nnoremap <leader>mm za
vnoremap <leader>mm za

" Toggle relative number
map <leader>rn :set relativenumber!<cr>

" comment line/block
map <leader># gcc

" exit insert mode quickly
inoremap jj <Esc>
inoremap jk <Esc>

" GitGutter related
highlight GitGutterAdd ctermfg=darkgreen
highlight GitGutterChange ctermfg=darkyellow
highlight GitGutterDelete ctermfg=darkred
highlight GitGutterChangeDelete ctermfg=darkyellow
highlight SignColumn ctermbg=black

map <leader>gg :GitGutterToggle<CR>
map <leader>gp :GitGutterPreviewHunk<CR>
map <leader>gr :GitGutterUndoHunk<CR>

"Super tab settings - uncomment the next 4 lines
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

set completeopt=longest,menuone,preview

" C-d duplicates line or visual selection (cursor stays in position in normal and insert mode)
nmap <C-d> mg""yyp`g:delm g<cr>
imap <C-d> <C-O>mg<C-O>""yy<C-O>p<C-O>`g<C-O>:delm g<cr>
vmap <C-d> ""y<up>""p

let g:vim_markdown_formatter = 1
let g:vim_markdown_folding_level = 3
let g:vim_markdown_folding_disabled = 1

" Disable ex mode
:map Q <Nop>

" make column 120 visible
if (exists('+colorcolumn'))
  set colorcolumn=120
  highlight ColorColumn ctermbg=10
endif

set diffexpr=MyDiff()

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g_ctrlp_use_caching = 0
endif

set wildignore+=*/.git/*,*/tmp/*,*.swp,*/.fake/*

set statusline+=%#warningmsg#
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set omnifunc=syntaxcomplete#Complete

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" vim-fsharp plugin
let g:syntastic_fsharp_checkers=['syntax']
let g:fsharp_xbuild_path="C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional\\MSBuild\\15.0\\Bin\\msbuild.exe"
let g:fsharp_interactive_bin="C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional\\Common7\\IDE\\CommonExtensions\\Microsoft\\FSharp\\fsi.exe"

" Control+S saves the current file (if it's been changed).
"
noremap  <C-S>  :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" AutoComplete with C-Space
"
inoremap <C-space> <C-x><C-o>

let g:plantuml_executable_script='plantuml'

nnoremap <F5> :w<CR> :silent make<CR>
inoremap <F5> <Esc>:w<CR>:silent make<CR>
vnoremap <F5> :<C-U>:w<CR>:silent make<CR>

set noshowmode
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \  'left': [ ['mode', 'paste'],
      \            ['gitbranch', 'readonly', 'filename', 'modified' ] ],
      \  'right': [ [ 'lineinfo' ],
      \             [ 'percent' ],
      \             [ 'fileformat',  'fileencoding', 'filebom','filetype' ] ]
      \ },
      \ 'component': {
      \   'gitbranch': '%{exists("*fugitive#head")?fugitive#head():""}',
      \   'readonly':  '%{&filetype=="help"?"":&readonly?"\ue0a2":""}',
      \   'modified':  '%{&filetype=="help"?"":&modified?"\ue0a0":&modifiable?"":"-"}',
      \   'filebom':   '%{(exists("+bomb") && &bomb)?"BOM":""}'
      \ },
      \ 'component_visible_condition' : {
      \   'gitbranch': '(exists("*fugitive#head") && ""!=fugitive#head())',
      \   'readonly':  '(&filetype!="help" && &readonly)',
      \   'modified':  '(&filetype!="help" &&(&modified||!&modifiable))',
      \   'filebom':   '((exists("+bomb") && &bomb))'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

set laststatus=2
set statusline=
" left side
set statusline+=\ %{StatuslineMode()} " Mode
set statusline+=%{strlen(b:gitbranch)?'\ \ >\ ':''} " Separator git branch
set statusline+=%{strlen(b:gitbranch)?b:gitbranch:''} " Git branch
set statusline+=%{&filetype=='help'?'':&readonly?'\ \ >\ [RO]':''} " readonly
set statusline+=\ >\ %f " file name
set statusline+=%{&filetype=='help'?'':&modified?'\ [+]':&modifiable?'':'\ [-]'} " modified

set statusline+=%=
" right side
set statusline+=%{&ff} " file format
set statusline+=%{!exists('+bomb')?'':&bomb?'\ \ <\ BOM':''} " file BOM
set statusline+=%{strlen(&fenc)?'\ \ <\ ':''} " separator file encoding
set statusline+=%{strlen(&fenc)?&fenc:''} " file encoding
set statusline+=\ <\ %y " File type
set statusline+=\ <\ %2P " percent
set statusline+=\ <%3c:%-4l/%4L " line info
set statusline+=\  " final space


function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

let b:gitbranch=""
function! StatuslineGitBranch()
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '
        ', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END



silent! colorscheme nord
" silent! colorscheme gruvbox
" set background=dark

" if has("gui_running")
  " let g:gruvbox_bold=1
  " let g:gruvbox_italic=1
  " let g:gruvbox_underline=1
  " let g:gruvbox_undercurl=1
" else
  " let g:gruvbox_italic=0
  " let g:gruvbox_bold=0
  " let g:gruvbox_underline=0
  " let g:gruvbox_undercurl=0
" endif

" let g:gruvbox_improved_strings=0
" let g:gruvbox_contrast_dark='hard'

" specific settings for ConEMU
if !has("gui_running") && !empty($ConEmuANSI)
  echom "Running in conemu"
  set termencoding=utf8
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"

  set mouse=a
  set nocompatible
  inoremap <Esc>[62~ <C-X><C-E>
  inoremap <Esc>[63~ <C-X><C-Y>
  nnoremap <Esc>[62~ <C-E>
  nnoremap <Esc>[63~ <C-Y>
endif

function! DeleteLineNotContaining(word)
  let command = join(['g/^\(\(', a:word, '\)\@!.\)*$/d'], "")
  execute command
endfunction

function! DeleteLineContaining(word)
  let command = join(['g/^.*', a:word, '.*$/d'], "")
  execute command
endfunction

function! GetWorkItems()
  let @t='02dlwd$i,'
  :g/^- \d\+ - /norm @t
  :g/^$/d
  :v/^\d\+,\s*/d
  let @t='gg100Jgg'
  :norm @t
  :%s: ::g
  let @t='"*y$'
  :norm @t
endfunction

nnoremap <leader>nn :call GetWorkItems()<CR>

let g:date_regex = '[0-9]\{2\}\.[0-9]\{2\}\.[0-9]\{4\}'
let g:time_regex = '[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\}'
let g:timestamp_regex = join([g:date_regex, g:time_regex], " ")
let g:logline_regex = join([g:timestamp_regex, '|'], "")

nnoremap <leader>dd :call DeleteLineNotContaining(g:logline_regex)<CR>

function! PrettyPrintJSON()
  :%!python -m json.tool
endfunction

autocmd FileType json nnoremap <leader>pp :call PrettyPrintJSON()<CR>

" Configuration for dhruvasagar/vim-table-mode
" Make markdown compatible tables
let g:table_mode_corner='|'

if &diff
  set diffopt+=iwhite " ignore whitespaces on diff
  set cursorline      " show current line
  " remap next change
  map < ]c           
  " remap previous change
  map > [c
  " change highlight colors
  hi DiffAdd ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
  hi DiffChange ctermbg=white guibg=#ececec gui=none cterm=none
  hi DiffText ctermfg=233 ctermbg=yellow guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

if has('python')
  let g:python_host_prog='C:\\Python27\\python.exe'
endif
if has('python3')
  let g:python3_host_prog='C:\\Python37\\python.exe'
endif

if !has('nvim')
  set pyxversion=3
endif
set viminfo='1,:1,<0,@0,f0

let g:PluginDir = 'C:\Users\mgondermann\.vim\plugged\markdown-preview.vim'
map <leader>p :MarkdownPreview github<CR>

" split handling
"
set splitright          " Split new vertical windows right of current window.
set splitbelow          " Split new horizontal windows under current window.

nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>s :split<cr>
nmap <silent> <leader>o :only<cr>

" zoom a pane, minus to zoom, underscore to rebalance
nnoremap <leader>- <silent> :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>_ <silent> :wincmd =<cr>

" resize panes
nnoremap <silent> <C-A-Left> :vertical resize +5<cr>
nnoremap <silent> <C-A-Right> :vertical resize -5<cr>
nnoremap <silent> <C-A-Down> :resize +5<cr>
nnoremap <silent> <C-A-Up> :resize -5<cr>

if has('windows')
  nnoremap è <C-w>h
  nnoremap ê <C-w>j
  nnoremap ë <C-w>k
  nnoremap ì <C-w>l

  nnoremap È <C-w>H
  nnoremap Ê <C-w>J
  nnoremap Ë <C-w>K
  nnoremap Ì <C-w>L

  inoremap è <Esc><C-w>h
  inoremap ê <Esc><C-w>j
  inoremap ë <Esc><C-w>k
  inoremap ì <Esc><C-w>l

  inoremap È <Esc><C-w>H
  inoremap Ê <Esc><C-w>J
  inoremap Ë <Esc><C-w>K
  inoremap Ì <Esc><C-w>L
endif

map ' `

nnoremap <leader>sw :cd C:\Projects\speedway<cr>

let g:goldenview__enable_default_mapping = 0


" Toggle quickfix window with 'qo'
function! s:redir(cmd)
  redir => res
  execute a:cmd
  redir END
  
  return res
endfunction

function! s:toggle_qf_list()
  let bufs = s:redir('buffers')
  let l = matchstr(split(bufs, '\n'), '[\t ]*\d\+.\+"\[Quickfix.\+"')
 
  let winnr = -1
  if !empty(l)
    let bufnbr = matchstr(l, '[\t ]*\zs\d\+\ze[\t ]\+')
    let winnr = bufwinnr(str2nr(bufnbr, 10))
  endif
  
  if winnr == -1
    if !empty(getqflist())
      copen
    endif
  else
    cclose
  endif
endfunction

nnoremap <silent> qo :<C-u>silent call <SID>toggle_qf_list()<cr>

if (!has('gui'))
  " Copy yank buffer to system clipboard
  " Use OSC52 to put things into the system clipboard, works over SSH!
  function! Osc52Yank()
    let buffer=system('base64 -w0', @0) " -w0 do disable 76 char line wrapping
    let buffer='\ePtmux;\e\e]52;c;'.buffer.'\x07\e\\'
    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
  endfunction

  nnoremap <leader>y :call Osc52Yank()<cr>
endif

nnoremap <silent> <leader>. :Files<cr>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)


command! Vterm :vs|:term ++curwin

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
