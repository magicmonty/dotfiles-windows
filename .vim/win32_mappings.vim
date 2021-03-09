if has("win32")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X>      "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C>      "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>           "+gP
    cmap <C-V>          <C-R>+

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

endif " has("win32")
