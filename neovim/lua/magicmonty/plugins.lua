require('magicmonty.plug').init(function(use)
  -- Git support
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'lewis6991/gitsigns.nvim'

  -- Bracket auto closing
  -- use 'cohama/lexima.vim'

  -- Color scheme
  use 'EdenEast/nightfox.nvim'

  -- Nice status line
  use 'hoob3rt/lualine.nvim'

  -- Auto comment line
  use 'tpope/vim-commentary'

  -- LSP/Completion config
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'ray-x/cmp-treesitter'
  -- use 'glepnir/lspsaga.nvim'
  use 'tami5/lspsaga.nvim'
  use 'folke/lsp-colors.nvim'
  use 'onsails/lspkind-nvim'
  use 'folke/trouble.nvim'
  use 'folke/lua-dev.nvim'

  -- Treesitter
  use ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
  use 'nvim-treesitter/playground'
  use ('nvim-treesitter/nvim-treesitter-textobjects', { branch = '0.5-compat' })
  use 'nvim-treesitter/nvim-treesitter-angular'
  use 'p00f/nvim-ts-rainbow'
  use 'David-Kunz/treesitter-unit'

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  use ('groenewege/vim-less', { ['for'] = 'less' })

  use 'norcalli/nvim-colorizer.lua'
  use 'voldikss/vim-floaterm'
  use 'editorconfig/editorconfig-vim'
  use 'amadeus/vim-convert-color-to'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'rcarriga/nvim-notify'

  -- Rust support
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'

  -- Org Mode support
  use 'kristijanhusak/orgmode.nvim'
  use 'dhruvasagar/vim-table-mode'

end)

