-- Add indentation guides even on blank lines
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '┊',
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      exclude = {
        filetypes = {
          'dashboard',
          'help',
          'alpha',
          'neo-tree',
          'NvimTree',
          'Trouble',
          'lazy',
          'mason',
          'null-ls-info',
        },
      },
      scope = {
        enabled = false,
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '┊',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'NvimTree', 'Trouble', 'lazy', 'mason', 'null-ls-info' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end,
  },
}
