local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim.git',
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

local packer_user_config_group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
  group = packer_user_config_group,
})

return require('packer').startup({
  function(use)
    use('wbthomason/packer.nvim')
    use('lewis6991/impatient.nvim') -- fast startup
    use('nvim-lua/popup.nvim')
    use('nvim-lua/plenary.nvim')

    -- Loads a lot of filetypes faster
    use({
      'nathom/filetype.nvim',
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    })

    -- Nice icons for different plugins
    use({
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('settings.web-devicons.settings')
      end,
    })

    -- Display keybindings
    use({
      'folke/which-key.nvim',
      config = function()
        require('settings.which-key.settings')
      end,
    })

    -- Color scheme
    use({
      'EdenEast/nightfox.nvim',
      config = function()
        require('settings.nightfox.settings')
      end,
      requires = {
        'kyazdani42/nvim-web-devicons',
        'lukas-reineke/indent-blankline.nvim',
      },
    })

    -- Nice notification windows
    use({
      'rcarriga/nvim-notify',
      config = function()
        require('settings.notify.settings')
      end,
      requires = 'EdenEast/nightfox.nvim',
    })

    -- Tree view
    use({
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('settings.nvim-tree.settings')
      end,
      requires = {
        'EdenEast/nightfox.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    })

    -- Statusline
    use({
      'nvim-lualine/lualine.nvim',
      config = function()
        require('settings.lualine.settings')
      end,
      requires = {
        'EdenEast/nightfox.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    })

    -- Clickable tab bar
    use({
      'romgrk/barbar.nvim',
      config = function()
        require('settings.barbar.settings')
      end,
      requires = {
        'EdenEast/nightfox.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    })

    -- Git support
    use({
      'TimUntersberger/neogit',
      config = function()
        require('settings.neogit.settings')
      end,
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
      },
    })

    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('settings.gitsigns.settings').setup()
      end,
      requires = 'nvim-lua/plenary.nvim',
    })

    use({
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('settings.diffview.settings')
      end,
    })

    -- Auto commenter
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('settings.comment.settings')
      end,
    })

    -- Treesitter Syntax highlighting and more
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      -- config is done in after/plugin/treesitter.lua because it
      -- doesn't seem to work otherwise on first opened file in Windows
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
        'windwp/nvim-ts-autotag',
        'p00f/nvim-ts-rainbow',
        'David-Kunz/treesitter-unit',
        'folke/lsp-colors.nvim',
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
    })

    -- LSP/Completion config
    use({
      'junnplus/nvim-lsp-setup',
      config = function()
        require('settings.lsp-setup.settings')
      end,
      requires = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/lua-dev.nvim',
        'kyazdani42/nvim-web-devicons',
        'folke/lsp-colors.nvim',
      },
    })

    -- LSP loading display
    use({
      'j-hui/fidget.nvim',
      config = function()
        require('settings.fidget.settings')
      end,
    })

    -- Code formatter
    use({
      'mhartington/formatter.nvim',
      config = function()
        require('settings.formatter.settings')
      end,
    })

    use({
      'folke/lsp-colors.nvim',
      config = function()
        require('settings.lsp-colors.settings')
      end,
      requires = 'EdenEast/nightfox.nvim',
    })

    --[[
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("settings.null-ls.settings")
			end,
		})
		]]

    use({
      'hrsh7th/nvim-cmp',
      config = function()
        require('settings.cmp.settings')
      end,
      requires = {
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-path',
        'ray-x/cmp-treesitter',
        {
          'onsails/lspkind-nvim',
          config = function()
            require('settings.lspkind.settings')
          end,
        },
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require('settings.luasnip.settings')
          end,
          requires = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
          },
        },
        -- Bracket auto closing
        {
          'windwp/nvim-autopairs',
          config = function()
            require('settings.autopairs.settings').setup()
          end,
        },
      },
    })

    -- Telescope
    use({
      'nvim-telescope/telescope.nvim',
      config = function()
        require('settings.telescope.settings')
      end,
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-telescope/telescope-project.nvim' },
        { 'jvgrootveld/telescope-zoxide' },
        {
          'AckslD/nvim-neoclip.lua',
          config = function()
            require('neoclip').setup()
          end,
        },
      },
    })

    -- Better Terminal
    use({
      'voldikss/vim-floaterm',
      config = function()
        require('settings.floaterm.settings')
      end,
    })

    -- Generic helpers
    use('tpope/vim-surround')
    use('tpope/vim-repeat')
    use({
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end,
    })
    use('editorconfig/editorconfig-vim')
    use({
      'stevearc/dressing.nvim',
      config = function()
        require('settings.dressing.settings')
      end,
    })

    -- SCSS syntax support
    use('cakebaker/scss-syntax.vim')

    use('dhruvasagar/vim-table-mode')

    -- Markdown support
    use({
      'davidgranstrom/nvim-markdown-preview',
    })

    -- Dashboard
    use({
      'glepnir/dashboard-nvim',
      config = function()
        require('settings.dashboard.settings').setup()
      end,
    })

    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    max_jobs = 8,
    display = {
      open_fn = require('packer.util').float,
    },
  },
})
