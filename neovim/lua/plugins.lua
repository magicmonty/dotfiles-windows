local fn = vim.fn
local au = require('vim_ext').au
local augroup = require('vim_ext').augroup
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim.git', install_path})
  vim.cmd [[packadd packer.nvim]]
end

augroup('packer_user_config',  {
 au({'BufWritePost', 'plugins.lua', ':PackerCompile'})
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Color scheme
  use { 'EdenEast/nightfox.nvim', config = "require('settings.nightfox')" }

  -- Bracket auto closing
  use { 'windwp/nvim-autopairs', config = "require('settings.autopairs')" }

  -- Tree view
  use { 'kyazdani42/nvim-tree.lua', config = "require('settings.nvim-tree')" }

  -- Statusline / Tabline
  use { 'nvim-lua/lsp-status.nvim', config = "require('settings.lsp-status')" }
  use { 'hoob3rt/lualine.nvim', config = "require('settings.lualine')" }
  use { 'kdheepak/tabline.nvim' }

  -- Git support
  use 'tpope/vim-fugitive'
  use { 'lewis6991/gitsigns.nvim', config = "require('settings.git')" }

  -- Auto commenter
  use { 'numToStr/Comment.nvim', config = "require('settings.comment')" }

  -- Treesitter
  use { 
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate', 
    config = "require('settings.treesitter')" ,
    requires = {
      { 'nvim-treesitter/playground' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-angular' },
      { 'p00f/nvim-ts-rainbow' },
      { 'David-Kunz/treesitter-unit' }
    }
  }

  -- LSP/Completion config
  use {
    'williamboman/nvim-lsp-installer',
    config = "require('settings.lsp-installer')",
    requires = {
      "neovim/nvim-lspconfig",
      "folke/lua-dev.nvim",
      { "kyazdani42/nvim-web-devicons", config = "require('settings.web-devicons')" }
    }
  }

  use { 'tami5/lspsaga.nvim', config = "require('settings.lspsaga')" }
  use { 'folke/lsp-colors.nvim', config = "require('settings.lsp-colors')" }
  use { 'folke/trouble.nvim', config = "require('settings.trouble')" }

  use { 
    'hrsh7th/nvim-cmp',
    config = "require('settings.cmp')",
    requires = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'ray-x/cmp-treesitter',
      {
        'onsails/lspkind-nvim',
        config = "require('settings.lspkind')"
      },
      { 
        'L3MON4D3/LuaSnip',
        config = "require('settings.luasnip')",
        requires = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets'
        }
      }
    }
  }

  -- Telescope
  use { 
    'nvim-telescope/telescope.nvim',
    config = "require('settings.telescope')",
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-project.nvim',
      {
        'nvim-telescope/telescope-dap.nvim',
        requires = {
          { 
            'mfussenegger/nvim-dap', 
            config = "require('settings.nvim-dap')",
            requires = {
              'rcarriga/nvim-dap-ui',
              'theHamsta/nvim-dap-virtual-text'
            }
          }
        }
      },
      'jvgrootveld/telescope-zoxide',
      { 'AckslD/nvim-neoclip.lua', config = "require('settings.neoclip')" }
    }
  }

  -- Nice notification windows
  use { 'rcarriga/nvim-notify', config = "require('settings.notify')" }

  -- Better Terminal
  use { 'voldikss/vim-floaterm', config = "require('settings.floaterm')" }

  -- Generic helpers
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'norcalli/nvim-colorizer.lua'
  use 'amadeus/vim-convert-color-to'
  use 'editorconfig/editorconfig-vim'
  use 'lukas-reineke/indent-blankline.nvim'

  -- SCSS syntax support
  use 'cakebaker/scss-syntax.vim'

  -- Rust support
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'

  -- Org Mode support
  use {
    'kristijanhusak/orgmode.nvim',
    requires = {
      'dhruvasagar/vim-table-mode',
      'akinsho/org-bullets.nvim'
    }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
