local cb = require('diffview.config').diffview_callback
local diffview = require('diffview')
local map = vim.keymap.set
local opts = { silent = true, remap = false }

map('n', '<leader>gdo', function()
  diffview.open()
end, opts)
map('n', '<leader>gdh', function()
  diffview.file_history()
end, opts)

diffview.setup({
  diff_binaries = false, -- Show diffs for binaries
  enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true, -- Requires nvim-web-devicons
  icons = { -- Only applies when use_icons is true.
    folder_closed = '',
    folder_open = '',
  },
  signs = {
    fold_closed = '',
    fold_open = '',
  },
  file_panel = {
    position = 'left', -- One of 'left', 'right', 'top', 'bottom'
    width = 35, -- Only applies when position is 'left' or 'right'
    height = 10, -- Only applies when position is 'top' or 'bottom'
    listing_style = 'tree', -- One of 'list' or 'tree'
    tree_options = { -- Only applies when listing_style is 'tree'
      flatten_dirs = true, -- Flatten dirs that only contain one single dir
      folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
    },
  },
  file_history_panel = {
    position = 'bottom',
    width = 35,
    height = 16,
    log_options = {
      max_count = 256, -- Limit the number of commits
      follow = true, -- Follow renames (only for single file)
      all = false, -- Include all refs under 'refs/' including HEAD
      merges = false, -- List only merge commits
      no_merges = false, -- List no merge commits
      reverse = false, -- List commits in reverse order
    },
  },
  default_args = { -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {}, -- See ':h diffview-config-hooks'
  key_bindings = {
    disable_defaults = true, -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ['<tab>'] = cb('select_next_entry'), -- Open the diff for the next file
      ['<s-tab>'] = cb('select_prev_entry'), -- Open the diff for the previous file
      ['gf'] = cb('goto_file'), -- Open the file in a new split in previous tabpage
      ['q'] = ':DiffviewClose<CR>', -- Close the diff
    },
    file_panel = {
      ['j'] = cb('next_entry'), -- Bring the cursor to the next file entry
      ['<down>'] = cb('next_entry'),
      ['k'] = cb('prev_entry'), -- Bring the cursor to the previous file entry.
      ['<up>'] = cb('prev_entry'),
      ['<cr>'] = cb('select_entry'), -- Open the diff for the selected entry.
      ['o'] = cb('select_entry'),
      ['<2-LeftMouse>'] = cb('select_entry'),
      ['-'] = cb('toggle_stage_entry'), -- Stage / unstage the selected entry.
      ['S'] = cb('stage_all'), -- Stage all entries.
      ['U'] = cb('unstage_all'), -- Unstage all entries.
      ['X'] = cb('restore_entry'), -- Restore entry to the state on the left side.
      ['R'] = cb('refresh_files'), -- Update stats and entries in the file list.
      ['<tab>'] = cb('select_next_entry'),
      ['<s-tab>'] = cb('select_prev_entry'),
      ['gf'] = cb('goto_file'),
      ['i'] = cb('listing_style'), -- Toggle between 'list' and 'tree' views
      ['f'] = cb('toggle_flatten_dirs'), -- Flatten empty subdirectories in tree listing style.
      ['q'] = ':DiffviewClose<CR>', -- Close the diff
    },
    file_history_panel = {
      ['g!'] = cb('options'), -- Open the option panel
      ['<C-A-d>'] = cb('open_in_diffview'), -- Open the entry under the cursor in a diffview
      ['y'] = cb('copy_hash'), -- Copy the commit hash of the entry under the cursor
      ['j'] = cb('next_entry'),
      ['<down>'] = cb('next_entry'),
      ['k'] = cb('prev_entry'),
      ['<up>'] = cb('prev_entry'),
      ['<cr>'] = cb('select_entry'),
      ['o'] = cb('select_entry'),
      ['<2-LeftMouse>'] = cb('select_entry'),
      ['<tab>'] = cb('select_next_entry'),
      ['<s-tab>'] = cb('select_prev_entry'),
      ['gf'] = cb('goto_file'),
      ['<leader>e'] = cb('focus_files'),
      ['<leader>b'] = cb('toggle_files'),
      ['q'] = ':DiffviewClose<CR>', -- Close the diff
    },
    option_panel = {
      ['<tab>'] = cb('select'),
      ['q'] = ':DiffviewClose<CR>', -- Close the diff
    },
  },
})
