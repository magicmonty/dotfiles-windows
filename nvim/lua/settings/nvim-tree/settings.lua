local nvim_tree = require('nvim-tree')
local tree_cb = require('nvim-tree.config').nvim_tree_callback
local map = require('vim_ext').map
local icons = require('icons')

vim.cmd [[
  let g:nvim_tree_indent_markers = 1
  let g:nvim_tree_git_hl = 1
  let g:nvim_tree_highlight_opened_files = 3

  let g:nvim_tree_icons = {
      \ 'default': '',
      \ 'symlink': '',
      \ 'git': {
      \   'unstaged': "✗",
      \   'staged': "✓",
      \   'unmerged': "",
      \   'renamed': "➜",
      \   'untracked': "★",
      \   'deleted': "",
      \   'ignored': "◌"
      \   },
      \ 'folder': {
      \   'arrow_open': "",
      \   'arrow_closed': "",
      \   'default': "",
      \   'open': "",
      \   'empty': "",
      \   'empty_open': "",
      \   'symlink': "",
      \   'symlink_open': "",
      \   }
      \ }
]]

vim.keymap.set('n', '<leader>.', ':NvimTreeFindFileToggle<cr>', { noremap = true, silent = true })

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  auto_close = true,
  hijack_cursor = true,
  open_on_setup = false,
  update_cwd = false,
  update_focused_file = {
    enable = true,
    update_cwd = false
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Info,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    }
  },
  git = {
    ignore = true
  },
  view = {
    mappings = {
      list = {
        { key = 'cd', cb = tree_cb("cd") },
        { key = { '<C-s>', '<C-x>', '<C-h>' }, cb = tree_cb("split") },
      }
    }
  },
  actions = {
    open_file = {
      -- false by default, closes the tree when you open a file
      quit_on_open = true ,
      window_picker_exclude = { 
        filetype = { "packer", "vim-plug", "qf" } 
      }
    }
  }
})
