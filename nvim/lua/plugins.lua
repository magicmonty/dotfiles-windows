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
        require('plugins.web-devicons.config')
      end,
    })

    -- Color scheme
    use({
      'EdenEast/nightfox.nvim',
      config = function()
        require('plugins.nightfox.config')
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
        require('plugins.notify.config')
      end,
      requires = 'EdenEast/nightfox.nvim',
    })

    -- Tree view
    use({
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('plugins.nvim-tree.config')
      end,
      requires = {
        'EdenEast/nightfox.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    })

    -- Statusline
    use('arkav/lualine-lsp-progress')

    use({
      'nvim-lualine/lualine.nvim',
      config = function()
        require('plugins.lualine.config')
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
        require('plugins.barbar.config')
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
        require('plugins.neogit.config')
      end,
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
      },
    })

    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugins.gitsigns.config').setup()
      end,
      requires = 'nvim-lua/plenary.nvim',
    })

    use({
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.diffview.config')
      end,
    })

    -- Auto commenter
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('plugins.comment.config')
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

    -- Better Diagnostic Virtual texts
    use({
      'Maan2003/lsp_lines.nvim',
      config = function()
        local installed, lsp_lines = pcall(require, 'lsp_lines')
        if not installed then
          return
        end

        lsp_lines.setup()
      end,
    })

    -- LSP/Completion config
    use({
      'junnplus/lsp-setup.nvim',
      config = function()
        require('plugins.lsp-setup.config')
      end,
      requires = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim',
        'kyazdani42/nvim-web-devicons',
        'folke/lsp-colors.nvim',
      },
    })

    use({
      'lvimuser/lsp-inlayhints.nvim',
      config = function()
        require('plugins.inlayhints.config')
      end,
    })

    use({
      'ray-x/lsp_signature.nvim',
      config = function()
        require('plugins.lsp-signature.config')
      end,
    })

    -- LSP loading display
    --[[ use({
      'j-hui/fidget.nvim',
      config = function()
        require('plugins.fidget.config')
      end,
    }) ]]

    -- Code formatter
    --[[ use({
      'mhartington/formatter.nvim',
      config = function()
        require('plugins.formatter.config')
      end,
    })
]]
    use({
      'folke/lsp-colors.nvim',
      config = function()
        require('plugins.lsp-colors.config')
      end,
      requires = 'EdenEast/nightfox.nvim',
    })

    use({
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require('plugins.null-ls.config')
      end,
    })

    use({
      'hrsh7th/nvim-cmp',
      config = function()
        require('plugins.cmp.config')
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
            require('plugins.lspkind.config')
          end,
        },
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require('plugins.luasnip.config')
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
            require('plugins.autopairs.config').setup()
          end,
        },
      },
    })

    -- Telescope
    use({
      'nvim-telescope/telescope.nvim',
      config = function()
        require('plugins.telescope.config')
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
        require('plugins.floaterm.config')
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
        require('plugins.dressing.config')
      end,
    })
    use({
      'ahmedkhalf/project.nvim',
      config = function()
        require('plugins.project.config')
      end,
    })

    -- SCSS syntax support
    use('cakebaker/scss-syntax.vim')

    use('dhruvasagar/vim-table-mode')

    -- Markdown support
    use({
      'davidgranstrom/nvim-markdown-preview',
    })

    -- Orgmode
    use({
      'nvim-orgmode/orgmode',
      config = function()
        require('plugins.orgmode.config').setup()
      end,
    })

    -- Dashboard
    use({
      'glepnir/dashboard-nvim',
      config = function()
        require('plugins.dashboard.config').setup()
      end,
    })
    use({
      'narutoxy/silicon.lua',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        local silicon = require('silicon')
        silicon.setup({})
        -- Generate image of lines in a visual selection
        vim.keymap.set('v', '<Leader>s', function()
          silicon.visualise_api({})
        end)
        -- Generate image of a whole buffer, with lines in a visual selection highlighted
        vim.keymap.set('v', '<Leader>bs', function()
          silicon.visualise_api({ to_clip = true, show_buf = true })
        end)
        -- Generate visible portion of a buffer
        vim.keymap.set('n', '<Leader>s', function()
          silicon.visualise_api({ to_clip = true, visible = true })
        end)
        -- Generate current buffer line in normal mode
        vim.keymap.set('n', '<Leader>s', function()
          silicon.visualise_api({ to_clip = true })
        end)
      end,
    })

    use('mg979/vim-visual-multi')

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
