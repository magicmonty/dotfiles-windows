local fn = vim.fn
local au = require('vim_ext').au
local augroup = require('vim_ext').augroup
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim.git', install_path})
  vim.cmd [[packadd packer.nvim]]
end

augroup('packer_user_config',  {
 au({'BufWritePost', 'plugins.lua', 'source <afile> | PackerCompile'})
})

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  -- common dependencies
  use { "kyazdani42/nvim-web-devicons", config = function() require('settings.web-devicons') end }
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-lua/lsp-status.nvim', config = function() require('settings.lsp-status') end }

  -- Color scheme
  use {
    'EdenEast/nightfox.nvim',
    config = function() require('settings.nightfox') end,
    requires = "kyazdani42/nvim-web-devicons"
  }

  -- Color scheme and nice notification windows
  use {
    'rcarriga/nvim-notify',
    config = function() require('settings.notify') end,
    requires = "EdenEast/nightfox.nvim"
  }

  -- Tree view
  use {
    'kyazdani42/nvim-tree.lua',
    config = function() require('settings.nvim-tree') end,
    requires = "kyazdani42/nvim-web-devicons"
  }

  -- Statusline / Tabline
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('settings.lualine') end,
    requires = { "kyazdani42/nvim-web-devicons", "nvim-lua/lsp-status.nvim" }
  }

  use {
    'kdheepak/tabline.nvim',
      config = function ()
        require('tabline').setup( { options = { show_filename_only = true } })
      end
  }

  -- Git support
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end,
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Auto commenter
  use { 'numToStr/Comment.nvim', config = function() require('settings.comment') end }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('settings.treesitter') end,
    requires = {
      { 'nvim-treesitter/playground' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-angular' },
      { 'windwp/nvim-ts-autotag' },
      { 'p00f/nvim-ts-rainbow' },
      { 'David-Kunz/treesitter-unit' },
      { 'folke/lsp-colors.nvim' }
    }
  }

  -- LSP/Completion config
  use {
    'williamboman/nvim-lsp-installer',
    config = function() require('settings.lsp-installer') end,
    requires = {
      "neovim/nvim-lspconfig",
      "folke/lua-dev.nvim",
      "kyazdani42/nvim-web-devicons",
      "nvim-lua/lsp-status.nvim"
    }
  }

  use { 
    'folke/lsp-colors.nvim', 
    config = function() require('settings.lsp-colors') end,
    requires = "EdenEast/nightfox.nvim"
  }

  use { 'tami5/lspsaga.nvim', config = function() require('settings.lspsaga') end }
  use { 'folke/trouble.nvim', config = function() require('settings.trouble') end }

  use {
    'hrsh7th/nvim-cmp',
      config = function() require('settings.cmp') end,
      requires = {
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'ray-x/cmp-treesitter',
        { 'onsails/lspkind-nvim', config = function() require('settings.lspkind') end },
        {
          'L3MON4D3/LuaSnip',
          config = function() require('settings.luasnip') end,
          requires = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
          }
        },
        -- Bracket auto closing
        { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup({}) end }
      }
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
      config = function() require('settings.telescope') end,
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-project.nvim',
        {
          'nvim-telescope/telescope-dap.nvim',
          requires = {
            {
              'mfussenegger/nvim-dap',
              config = function() require('settings.nvim-dap') end,
              requires = {
                'rcarriga/nvim-dap-ui',
                'theHamsta/nvim-dap-virtual-text'
              }
            }
          }
        },
        'jvgrootveld/telescope-zoxide',
        { 'AckslD/nvim-neoclip.lua', config = function() require('neoclip').setup() end }
      }
  }


  -- Better Terminal
  use { 'voldikss/vim-floaterm', config = function() require('settings.floaterm') end }

  -- Generic helpers
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use 'amadeus/vim-convert-color-to'
  use 'editorconfig/editorconfig-vim'
  use 'lukas-reineke/indent-blankline.nvim'

  -- SCSS syntax support
  use 'cakebaker/scss-syntax.vim'

  -- Rust support
  use 'rust-lang/rust.vim'
  use { 'simrat39/rust-tools.nvim', ft = "rust", config = function() require("rust-tools") end }

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
end,
config = {
  display = {
    open_fn = require('packer.util').float
  }
}})
