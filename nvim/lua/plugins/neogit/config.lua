local has_neogit, neogit = pcall(require, 'neogit')
if not has_neogit then
  return
end

neogit.setup({
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  auto_refresh = true,
  disable_builtin_notifications = false,
  use_magit_keybindings = false,
  kind = 'tab',
  commit_popup = {
    kind = 'split',
  },
  popup = {
    kind = 'split',
  },
  signs = {
    -- { CLOSED, OPENED }
    section = { '>', 'v' },
    item = { '>', 'v' },
    hunk = { '', '' },
  },
  integrations = {
    diffview = true,
  },
  sections = {
    untracked = {
      folded = false,
    },
    unstaged = {
      folded = false,
    },
    staged = {
      folded = false,
    },
    stashes = {
      folded = true,
    },
    unpulled = {
      folded = true,
    },
    unmerged = {
      folded = false,
    },
    recent = {
      folded = false,
    },
  },
})

vim.keymap.set('n', '<leader>gs', neogit.open)

local g = vim.api.nvim_create_augroup('CustomNeoGitEvents', { clear = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'NeogitPushComplete',
  group = g,
  callback = neogit.close,
})
