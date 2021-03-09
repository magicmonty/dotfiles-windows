call plug#begin('~/.vim/plugged')

" Blog

Plug 'cakebaker/scss-syntax.vim'
Plug 'parkr/vim-jekyll'
Plug 'plasticboy/vim-markdown', { 'on': [] }
Plug 'nelstrom/vim-markdown-folding', { 'on': [] }
Plug 'MikeCoder/markdown-preview.vim', { 'on': [] }
augroup load_markdown_plugs
  autocmd!
  autocmd FileType markdown call plug#load('vim-markdown', 'vim-markdown-folding', 'markdown-preview.vim') | autocmd! load_markdown_plugs
augroup END

" Colors
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

" dotnet
"Plug 'OrangeT/vim-csharp', { 'on': [] }
"augroup load_csharp_plugs
"  autocmd!
"  autocmd FileType csharp,cs call plug#load('omnisharp-vim', 'vim-csharp') | autocmd! load_csharp_plugs
"augroup END

Plug 'w0rp/ale'

" General
Plug 'zhaocai/GoldenView.Vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Traap/vim-helptags'
Plug 'jlanzarotta/bufexplorer'
Plug 'ervandew/supertab'
" Plug 'itchyny/lightline.vim'
" Plug 'deens/lightline_gruvbox_theme'
Plug 'tpope/vim-commentary'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'coderifous/textobj-word-column.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
if has('python') || has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'kshenoy/vim-signature'
Plug 'wellle/targets.vim'
Plug 'tommcdo/vim-exchange'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Dev
Plug 'editorconfig/editorconfig-vim'
Plug 'aklt/plantuml-syntax', { 'on': [] }
augroup load_plantuml_plugs
  autocmd!
  autocmd FileType plantuml call plug#load('plantuml-syntax') | autocmd! load_plantuml_plugs
augroup END

Plug 'tpope/vim-cucumber'
if executable('go')
  Plug 'fatih/vim-go'
endif
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'sheerun/vim-polyglot'
if executable('bibtex')
  Plug 'lervag/vimtex'
endif
Plug 'iwataka/gitignore.vim'

" Git
if executable('git')
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/gv.vim'
endif

" Windows
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }
augroup load_ps1_plugs
  autocmd!
  autocmd FileType ps1 call plug#load('vim-ps1') | autocmd! load_ps1_plugs
augroup END

Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'

Plug 'kien/rainbow_parentheses.vim', { 'on': [] }
Plug 'vim-scripts/VimClojure', { 'on': [] }
Plug 'tpope/vim-fireplace', { 'on': [] }
Plug 'vim-scripts/paredit.vim', { 'on': [] }

augroup load_clojure_plugs
  autocmd!
  autocmd FileType clojure call plug#load('rainbow_parentheses.vim', 'VimClojure', 'vim-fireplace', 'paredit.vim') | autocmd! load_clojure_plugs
augroup END


Plug 'glacambre/firenvim', { 'do': function('firenvim#install') }

" Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()

