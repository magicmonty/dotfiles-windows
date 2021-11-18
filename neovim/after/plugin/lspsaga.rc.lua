-- vim: foldlevel=99:

local status, saga = pcall(require, 'lspsaga')
if not status then return end

local map = require('vim_ext').map

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  infor_sign = '',
  hint_sign = '',
  code_action_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = false
  },
  border_style = "round",
  finder_action_keys = {
    quit = '<Esc>'
  },
  code_action_keys = {
    quit = '<Esc>'
  },
  rename_action_keys = {
    quit = '<Esc>'
  }
}

local opts = { silent = true, noremap = true }
map('n', '<M-End>', ':Lspsaga diagnostic_jump_next<cr>', opts)
map('n', '<S-M-Right>', ':Lspsaga diagnostic_jump_next<cr>', opts)
map('n', '<M-Home>', ':Lspsaga diagnostic_jump_prev<cr>', opts)
map('n', '<S-M-Left>', ':Lspsaga diagnostic_jump_prev<cr>', opts)
map('n', 'k', ':Lspsaga hover_doc<cr>', opts)
map('n', '<leader>gs', ':Lspsaga signature_help<cr>', opts)
map('n', '<leader>gh', ':Lspsaga lsp_finder<cr>', opts)
map('n', '<leader>gr', ':Lspsaga rename<cr>', opts)
map('n', '<C-r><C-r>', ':Lspsaga rename<cr>', opts)
map('n', '<leader>ca', ':Lspsaga code_action<cr>', opts)
