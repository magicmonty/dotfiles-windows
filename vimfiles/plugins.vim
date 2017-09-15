call plug#begin('~/vimfiles/plugged')

" Blog
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/liquid.vim'
Plug 'vim-scripts/liquidfold.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'parkr/vim-jekyll'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'KabbAmine/vCoolor.vim'

" Colors
Plug 'morhetz/gruvbox'

" dotnet
Plug 'OrangeT/vim-csharp'
Plug 'fsharp/vim-fsharp'
if !has('nvim')
  Plug 'OmniSharp/omnisharp-vim'
endif

" General
Plug 'Traap/vim-helptags'
Plug 'jlanzarotta/bufexplorer'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ervandew/supertab'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
if has('python') || has('python3')
  Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'scrooloose/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'kshenoy/vim-signature'
Plug 'wellle/targets.vim'
Plug 'tommcdo/vim-exchange'

" Dev
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-syntastic/syntastic'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-cucumber'
Plug 'fatih/vim-go'
Plug 'lambdatoast/elm.vim'
Plug 'freitass/todo.txt-vim'
Plug 'dag/vim-fish'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" Completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'fszymanski/deoplete-emoji'

  function! BuildDeopleteFSharp(info)
    ' info is a dictionary with 3 fields
    ' - name:   name of the plugin
    ' - status: 'installed', 'updated', or 'unchanged'
    ' - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
      !install.cmd
      :UpdateRemotePlugins
    endif
  endfunction

  Plug 'callmekohei/deoplete-fsharp', { 'do': function('BuildDeopleteFSharp') }
else
	Plug 'Shougo/neocomplete.vim'
endif

" Windows
Plug 'PProvost/vim-ps1'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'

call plug#end()
