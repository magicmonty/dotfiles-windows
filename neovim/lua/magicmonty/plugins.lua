require('magicmonty.plug').init(function(use)
  -- Git support
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'lewis6991/gitsigns.nvim'

  -- Bracket auto closing
  use 'windwp/nvim-autopairs'

  -- Color scheme
  use 'EdenEast/nightfox.nvim'

  -- Nice status line
  use 'hoob3rt/lualine.nvim'
  use 'kdheepak/tabline.nvim'
  use 'nvim-lua/lsp-status.nvim'

  -- Auto comment line
  use 'numToStr/Comment.nvim'

  -- LSP/Completion config
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
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
  use ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
  use 'nvim-treesitter/playground'
  use ('nvim-treesitter/nvim-treesitter-textobjects')
  use 'nvim-treesitter/nvim-treesitter-angular'
  use 'p00f/nvim-ts-rainbow'
  use 'David-Kunz/treesitter-unit'

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-project.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'AckslD/nvim-neoclip.lua'
  use 'jvgrootveld/telescope-zoxide'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use ('groenewege/vim-less', { ['for'] = 'less' })

  use 'norcalli/nvim-colorizer.lua'
  use 'voldikss/vim-floaterm'
  use 'editorconfig/editorconfig-vim'
  use 'amadeus/vim-convert-color-to'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'rcarriga/nvim-notify'
  use 'kyazdani42/nvim-tree.lua'
  use 'cakebaker/scss-syntax.vim'

  -- Rust support
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'

  -- Org Mode support
  use 'kristijanhusak/orgmode.nvim'
  use 'dhruvasagar/vim-table-mode'
  use 'akinsho/org-bullets.nvim'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Debug support
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'nvim-telescope/telescope-dap.nvim'

end)

-- vim: foldlevel=99

