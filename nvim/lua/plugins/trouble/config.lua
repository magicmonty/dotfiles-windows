local installed, trouble = pcall(require, 'trouble')

if not installed then
  return
end

local icons = require('magicmonty.theme').icons.diagnostics

trouble.setup({
  position = 'bottom',
  height = 10,
  width = 50,
  icons = true,
  mode = 'document_diagnostics',
  fold_open = '', -- icon used for open folds
  fold_closed = '', -- icon used for closed folds
  group = true,
  padding = true,
  action_keys = {
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = 'q', -- close the list
    cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
    refresh = 'r', -- manually refresh
    jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
    open_split = { '<c-x>' }, -- open buffer in new split
    open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
    open_tab = { '<c-t>' }, -- open buffer in new tab
    jump_close = { 'o' }, -- jump to the diagnostic and close the list
    toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = 'P', -- toggle auto_preview
    hover = 'K', -- opens a small popup with the full multiline message
    preview = 'p', -- preview the diagnostic location
    close_folds = { 'zM', 'zm' }, -- close all folds
    open_folds = { 'zR', 'zr' }, -- open all folds
    toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
    previous = 'k', -- previous item
    next = 'j', -- next item
  },
  indent_lines = true, -- add an indent guide below the fold icons
  auto_open = true, -- automatically open the list when you have diagnostics
  auto_close = true, -- automatically close the list when you have no diagnostics
  auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false, -- automatically fold a file trouble list at creation
  auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
  signs = {
    -- icons / text used for a diagnostic
    error = icons.Error,
    warning = icons.Warning,
    hint = icons.Hint,
    information = icons.Information,
    other = '﫠',
  },
  use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
})

vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { remap = false, silent = true })
