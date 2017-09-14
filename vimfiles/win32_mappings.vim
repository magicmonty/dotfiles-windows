if has("win32")
    if has("gui_running")
      " GUI is running or is about to start.
    
      " Maximize GVim Window on start
      " au GUIEnter * simalt ~x 
    endif

    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X>      "+x
    vnoremap <S-Del>    "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C>      "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>           "+gP
    map <S-Insert>      "+gP

    cmap <C-V>          <C-R>+
    cmap <S-Insert>     <C-R>+

    " Pasting blockwise and linewise selections is not possible in Insert and
    " Visual mode without the +virtualedit feature.  They are pasted as if
    " they were characterwise instead. Uses the paste.vim autoload script.
    "
    exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

    imap <S-Insert>     <C-V>
    vmap <S-Insert>     <C-V>

    " For CTRL-V to work autoselect must be off.
    " On Unix we have two selections, autoselect can be used.
    "
    if !has("unix")
        set guioptions-=a
    endif

    " Use CTRL-Q to do what CTRL-V used to do
    "
    noremap <C-Q>       <C-V>

    " CTRL-F4 is Close window
    "
    noremap  <C-F4>     <C-W>c
    inoremap <C-F4>     <C-O><C-W>c
    cnoremap <C-F4>     <C-C><C-W>c
    onoremap <C-F4>     <C-C><C-W>c

    " Control+Tab moves to the next window.
    "
    noremap  <C-Tab>    <C-W>w
    inoremap <C-Tab>    <C-O><C-W>w
    cnoremap <C-Tab>    <C-C><C-W>w
    onoremap <C-Tab>    <C-C><C-W>w

    " Alt-Space is System menu
    "
    if has("gui")
        noremap  <M-Space> :simalt ~<CR>
        inoremap <M-Space> <C-O>:simalt ~<CR>
        cnoremap <M-Space> <C-C>:simalt ~<CR>
    endif

endif " has("win32")
