local nvim_tree = require('nvim-tree')
local tree_cb = require('nvim-tree.config').nvim_tree_callback
local icons = require('icons')

vim.keymap.set('n', '<leader>.', require('nvim-tree.api').tree.toggle, { noremap = true, silent = true })

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  open_on_setup = false,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = 'all',
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = 'after',
      glyphs = {
        default = '',
        symlink = '',
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
        folder = {
          arrow_open = '',
          arrow_closed = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Info,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },
  view = {
    width = 50,
    adaptive_size = true,
    mappings = {
      list = {
        { key = 'cd', cb = tree_cb('cd') },
        { key = { '<C-s>', '<C-x>', '<C-h>' }, cb = tree_cb('split') },
      },
    },
  },
  actions = {
    open_file = {
      -- false by default, closes the tree when you open a file
      quit_on_open = true,
      window_picker = {
        exclude = {
          filetype = { 'packer', 'vim-plug', 'qf', 'notify' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },
})
