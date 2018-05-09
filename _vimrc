set nocompatible  " Vim (not vi) settings. Set early for side effects.

if has("win32")
  source ~/vimfiles/plugins.vim
  
  runtime map_option_highlighting_keys.vim
  runtime win32_mappings.vim
endif 

let mapleader=" "
let maplocalleader=" "
let g:mapleader=" "
set noundofile          " disable the persistent Undo function (and the corresponding .un~ file)
set showmode            " show the input mode in the footer
set shortmess+=I        " Don't show the Vim welcome screen.
" set clipboard=unnamedplus " use system clipboard with * register

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

set splitright          " Split new vertical windows right of current window.
set splitbelow          " Split new horizontal windows under current window.

set winminheight=0      " Allow windows to shrink to status line.
set winminwidth=0       " Allow windows to shrink to vertical separator.

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

set nomodeline          " Ignore modelines.
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

" Enable mouse support if it's available.
if has('mouse')
  set mouse=a
endif

set backup
" Remove the current directory from the backup directory list.
set backupdir-=.

if has("win32")
  set grepprg=internal        " Windows findstr.exe just isn't good enough.

  " Save backup files in the current user's TEMP directory
  " (that is, whatever the TEMP environment variable is set to).
  set backupdir^=$TEMP

  " Put swap files in TEMP, too.
  set directory=$TEMP\\\\
endif


if has("unix") " (including OS X)
  " Save backup files in the current user's ~/tmp directory, or in the
  " system /tmp directory if that's not possible.
  "
  set backupdir^=~/tmp,/tmp

  " Try to put swap files in ~/tmp (using the munged full pathname of
  " the file to ensure uniqueness). Use the same directory as the
  " current file if ~/tmp isn't available.
  "
  set directory=~/tmp//,.
endif

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

  " Create the hook for the per-window configuration. Both WinEnter
  " and VimEnter are used, since WinEnter doesn't fire for the first
  " window.
  "
  " Based on ideas from here:
  " http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
  "
  autocmd WinEnter,VimEnter * call s:ConfigureWindow()

  " Resize Vim windows to equal heights and widths when Vim itself
  " is resized.
  "
  autocmd VimResized * wincmd =

  " Open quickfix and fugitive's git commit windows at full horizontal
  " width. Via http://nosubstance.me/articles/2013-09-21-my-vim-gems/
  "
  autocmd FileType qf,gitcommit wincmd J

  " Treat buffers from stdin (e.g.: echo foo | vim -) as scratch buffers.
  "
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

" F7 formats the current/highlighted paragraph.
"
" XXX: Consider changing this to gwap to maintain logical cursor position.
"
nnoremap <F7>   gqap
inoremap <F7>   <C-O>gqap
vnoremap <F7>   gq

" Q does the same thing as <F7> (except in Insert mode, of course). I'm
" retraining myself to use Q instead of a function key, since it's kind
" of a de facto standard keystroke.
"
nnoremap Q  gqap
xnoremap Q  gq

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

if has("unix")
  " Control+Backslash toggles a lot of useful, but visually-noisy, features
  " (like search/match highlighting, 'list', and 'cursorline', etc.). Note the
  " :execute (vs. :call); see ToggleHighlight() for details.
  "
  runtime toggle_highlights.vim
  nnoremap <silent> <C-Bslash>  :execute ToggleHighlights()<CR>
  imap     <silent> <C-BSlash>  <Esc><C-BSlash>a
  vmap     <silent> <C-BSlash>  <Esc><C-BSlash>gv
endif

" Control+Hyphen (yes, I know it says underscore) repeats the character above
" the cursor.
"
inoremap <C-_>  <C-Y>

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

" Draw lines of dashes or equal signs based on the length of the line
" immediately above.
"
"   k       Move up 1 line
"   yy      Yank whole line
"   p       Put line below current line
"   ^       Move to beginning of line
"   v$      Visually highlight to end of line
"   r-      Replace highlighted portion with dashes / equal signs
"   j       Move down one line
"   a       Return to Insert mode
"
" XXX: Convert this to a function and make the symbol a parameter.
" XXX: Consider making abbreviations/mappings for ---<CR> and ===<CR>
"
inoremap <C-U>- <Esc>kyyp^v$r-ja
inoremap <C-U>= <Esc>kyyp^v$r=ja

" Edit user's vimrc in new tabs.
"
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>ep :tabedit ~/vimfiles/plugins.vim<CR>
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC 
  au BufWritePost .gvimrc,_gvimrc,gvimrc so $MYGVIMRC 
augroup END

" Make page-forward and page-backward work in insert mode.
"
inoremap <C-F>  <C-O><C-F>
inoremap <C-B>  <C-O><C-B>

" Make Option+Up/Down work as PageUp and PageDown
"
nnoremap    <M-Up>      <PageUp>
inoremap    <M-Up>      <PageUp>
vnoremap    <M-Up>      <PageUp>
nnoremap    <M-Down>    <PageDown>
inoremap    <M-Down>    <PageDown>
vnoremap    <M-Down>    <PageDown>

" Overload Control+L to clear the search highlight as it's redrawing the screen.
"
nnoremap <C-L>  :nohlsearch<CR><C-L>
inoremap <C-L>  <Esc>:nohlsearch<CR><C-L>a
vnoremap <C-L>  <Esc>:nohlsearch<CR><C-L>gv


" Insert spaces to match spacing on first previous non-blank line.
"
runtime insert_matching_spaces.vim
inoremap <expr> <S-Tab>  InsertMatchingSpaces()

" Keep the working line in the center of the window. This is a toggle, so you
" can bounce between centered-working-line scrolling and normal scrolling by
" issuing the keystroke again.
"
" From this message on the MacVim mailing list:
" http://groups.google.com/group/vim_mac/browse_thread/thread/31876ef48063e487/133e06134425bda1?hl=enÂ¿e06134425bda1
"
nnoremap <Leader>zz  :let &scrolloff=999-&scrolloff<CR>

" Toggle wrapping the display of long lines (and display the current 'wrap'
" state once it's been toggled).
"
nnoremap <Leader>w  :set invwrap<BAR>set wrap?<CR>

"
" Make it easy to :Tabularize
"
nnoremap <leader><Tab> <Esc>:Tabularize /
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

"""
""" Local Functions
"""

function! s:ConfigureWindow()

    " Only do this once per window.
    "
    if exists('w:windowConfigured')
        return
    endif

    let w:windowConfigured = 1

    " Highlight trailing whitespace, except when typing at the end of a line.
    " More info: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    "
    " XXX: Disabled for now, since it's distracting during demos and classes.
    "
    "call matchadd('NonText', '\s\+\%#\@<!$')

    " Highlight the usual to-do markers (including my initials and Michele's
    " initials), even if the current syntax highlighting doesn't include them.
    "
    call matchadd('Todo', 'XXX')
    call matchadd('Todo', 'BUG')
    call matchadd('Todo', 'HACK')
    call matchadd('Todo', 'FIXME')
    call matchadd('Todo', 'TODO')
    call matchadd('Todo', 'WNO:')
    call matchadd('Todo', 'MRB:')

endfunction

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

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
      \ "\<lt>C-n>" :
      \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
      \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
      \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

nnoremap <leader><Tab> :tabNext<cr>

" UltiSnips
if has("python") || has("python3")
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
endif

noremap <leader>bn :bn<cr>
noremap <leader>bp :bp<cr>
imap <buffer> <C-e> <Esc><Esc>ms[[cpp`sl
nmap <buffer> <C-e> ms[[cpp`s
let g:airline_powerline_fonts = 1

set t_Co=256
highlight clear SignColumn

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

let g:user_emmet_mode='a'
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall
"let g:user_emmet_leader_key='<C-SPC>'

" Various helpers
noremap H 0
noremap L $
map q: :q

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Indent guides
map <leader>ii :IndentGuidesToggle<cr>


command! SetIndent2Spaces set nopi shiftwidth=2 softtabstop=2
command! SetIndent4Spaces set nopi shiftwidth=4 softtabstop=4
command! SetIndentTabs set noet ci pi sts=0 sw=4 ts=4

map <leader>i2 :SetIndent2Spaces<CR>
map <leader>i4 :SetIndent4Spaces<CR>
map <leader>it :SetIndentTabs<CR>

nnoremap <leader><space> :noh<cr> " clear highlighted search results

" Unimpaired mappings for Non US keyboards
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

noremap <C-<> <<
noremap <C->> >>
noremap <leader>D VGdo<Esc>
nnoremap <leader>c za " toggle fold
vnoremap <leader>c za " toggle fold
map <leader>rn :set relativenumber!<cr>
map <leader>wr :set wrap!<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :hsplit<cr>
if has("unix")
  nnoremap <leader>da :Dash<cr>
endif
map <leader># gcc
inoremap jj <Esc>
inoremap jk <Esc>

" GitGutter related
highlight GitGutterAdd ctermfg=darkgreen
highlight GitGutterChange ctermfg=darkyellow
highlight GitGutterDelete ctermfg=darkred
highlight GitGutterChangeDelete ctermfg=darkyellow
highlight SignColumn ctermbg=black

map <leader>gg :GitGutterToggle<CR>
"map <leader>gp :GitGutterPreviewHunk<CR>
"map <leader>gr :GitGutterRevertHunk<CR>

" indent guide plugin
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup=1

"Super tab settings - uncomment the next 4 lines
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

set completeopt=longest,menuone,preview

" yy should work with clipboard=unnamedplus
" nnoremap yy "*yy

" C-d duplicates line or visual selection (cursor stays in position in normal and insert mode)
nmap <C-d> mg""yyp`g:delm g<cr>
imap <C-d> <C-O>mg<C-O>""yy<C-O>p<C-O>`g<C-O>:delm g<cr>
vmap <C-d> ""y<up>""p

let g:vim_markdown_formatter = 1
let g:vim_markdown_folding_level = 3
let g:vim_markdown_folding_disabled = 1

" Elm binding
autocmd FileType elm nnoremap <leader>el :ElmEvalLine<CR>
autocmd FileType elm vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
autocmd FileType elm nnoremap <leader>em :ElmMakeCurrentFile<CR>

" Disable ex mode
:map Q <Nop>

" make column 120 visible
if (exists('+colorcolumn'))
  set colorcolumn=120
  highlight ColorColumn ctermbg=10
endif

" Setup Rainbow parentheses for clojure
autocmd BufEnter *.cljs,*.clj,*.cljs.hl setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:

" Fix Rainbow parentheses for solarized
" let g:rbpt_colorpairs = [
"         \ ['darkyellow',  'RoyalBlue3'],
"         \ ['darkgreen',   'SeaGreen3'],
"         \ ['darkcyan',    'DarkOrchid3'],
"         \ ['Darkblue',    'firebrick3'],
"         \ ['DarkMagenta', 'RoyalBlue3'],
"         \ ['darkred',     'SeaGreen3'],
"         \ ['darkyellow',  'DarkOrchid3'],
"         \ ['darkgreen',   'firebrick3'],
"         \ ['darkcyan',    'RoyalBlue3'],
"         \ ['Darkblue',    'SeaGreen3'],
"         \ ['DarkMagenta', 'DarkOrchid3'],
"         \ ['Darkblue',    'firebrick3'],
"         \ ['darkcyan',    'SeaGreen3'],
"         \ ['darkgreen',   'RoyalBlue3'],
"         \ ['darkyellow',  'DarkOrchid3'],
"         \ ['darkred',     'firebrick3'],
"         \ ]

set diffexpr=MyDiff()

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

set wildignore+=*/.git/*,*/tmp/*,*.swp,*/.fake/*

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


set omnifunc=syntaxcomplete#Complete

if has("python")
  " OmniSharp
  " let g:OmniSharp_server_type = 'roslyn'
  " let g:OmniSharp_server_path = 'C:/Users/mgondermann/Portable/omnisharp-roslyn/OmniSharp.exe'
  let g:OmniSharp_server_type = 'v1'
  let g:OmniSharp_host = "http://localhost:2000" "This is the default value, setting it isn't actually necessary
  let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim

  let g:OmniSharp_timeout = 1 "Timeout in seconds to wait for a response from the server
  let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

  augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>
    autocmd FileType cs set tabstop=4
    autocmd FileType cs set softtabstop=4
    autocmd FileType cs set shiftwidth=4
  augroup END

  set updatetime=500 " this setting controls how long to wait (in ms) before fetching type / symbol information.
  set cmdheight=2 " Remove 'Press Enter to continue' message when type information is longer than one line.

  nnoremap <leader><space> :OmniSharpGetCodeActions<cr> " Contextual code actions (requires CtrlP or unite.vim)
  vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr> " Run code actions with text selected in visual mode to extract method
  nnoremap <leader>nm :OmniSharpRename<cr> " rename with dialog
  nnoremap <F2> :OmniSharpRename<cr>

  command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>") " rename without dialog - with cursor on the symbol to rename... ':Rename newname'

  nnoremap <leader>rl :OmniSharpReloadSolution<cr> " Force OmniSharp to reload the solution. Useful when switching branches etc.
  nnoremap <leader>cf :OmniSharpCodeFormat<cr>

  nnoremap <leader>tp :OmniSharpAddToProject<cr> " Load the current .cs file to the nearest project

  " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
  nnoremap <leader>ss :OmniSharpStartServer<cr>
  nnoremap <leader>sp :OmniSharpStopServer<cr>

  nnoremap <leader>th :OmniSharpHighlightTypes<cr> " Add syntax highlighting for types and interfaces
endif

set encoding=utf-8
set fileencoding=utf-8

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction

function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction

" autocmd FocusLost * call ToggleRelativeOn()
" autocmd FocusGained * call ToggleRelativeOn()
" autocmd InsertEnter * call ToggleRelativeOn()
" autocmd InsertLeave * call ToggleRelativeOn()

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quickly close windows
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q<cr>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <C-A-Left> :vertical resize +5<cr>
nnoremap <silent> <C-A-Right> :vertical resize -5<cr>
nnoremap <silent> <C-A-Down> :resize +5<cr>
nnoremap <silent> <C-A-Up> :resize -5<cr>


" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction



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

" Control+Z is Undo, in Normal and Insert mode.
"
noremap  <C-Z>  u
inoremap <C-Z>  <C-O>u

" F2 inserts the date and time at the cursor.
"
inoremap <F2>   <C-R>=strftime("%c")<CR>
nmap     <F2>   a<F2><Esc>


" AutoComplete with C-Space
" "
inoremap <C-space> <C-x><C-o>


let g:plantuml_executable_script='plantuml'

nnoremap <F5> :w<CR> :silent make<CR>
inoremap <F5> <Esc>:w<CR>:silent make<CR>
vnoremap <F5> :<C-U>:w<CR>:silent make<CR>


let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

silent! colorscheme gruvbox
let g:gruvbox_improved_strings=0
let g:gruvbox_contrast_dark='hard'

if has("gui_running")
let g:gruvbox_bold=1
 let g:gruvbox_italic=1
 let g:gruvbox_underline=1
 let g:gruvbox_undercurl=1
else
 let g:gruvbox_italic=0
 let g:gruvbox_bold=0
 let g:gruvbox_underline=0
 let g:gruvbox_undercurl=0
endif

" silent! colorscheme apprentice
set background=dark

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


" Calendar.vim
let g:calendar_google_calendar = 1
let g:calendar_google_task = 0
let g:calendar_time_zone = "+0100"
let g:calendar_view = "week"
let g:calendar_week_number = 1

autocmd BufEnter calender :set nonu

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

nnoremap <leader>. :NERDTreeToggle<cr>
nnoremap <leader>/ :NERDTreeFind<cr>

let g:NERDTreeWinSize = '40'
let g:NERDTreeMapOpenVSplit = 's'
let g:NERDTreeMapOpenSplit = 'i'
let g:NERDTreeMapCloseChildren = 'X' " Recursively closes all children of the selected directory.
let g:NERDTreeMapJumpRoot = 'P'     " Jump to the tree root.
let g:NERDTreeMapJumpParent = 'p'   " Jump to the parent node of the selected node.
let g:NERDTreeMapChdir = 'C'        " Make the selected directory node the new tree root
let g:NERDTreeMapUpdir = 'u'        " Move the tree root up a dir (like doing a 'cd ..').
let g:NERDTreeMapUpdirKeepOpen = 'U' " Like 'u' but leave old tree root open
let g:NERDTreeMapToggleHidden = 'I' " Toggles whether hidden files are displayed.

" leave vim if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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

