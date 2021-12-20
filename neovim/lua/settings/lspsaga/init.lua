-- vim: foldlevel=99:
local map = require('vim_ext').map
local icons = require("icons")

require('lspsaga').init_lsp_saga {
  error_sign = icons.diagnostics.Error,
  warn_sign = icons.diagnostics.Warning,
  infor_sign = icons.diagnostics.Info,
  hint_sign = icons.diagnostics.Hint,
  code_action_icon = icons.diagnostics.CodeAction .. ' ',
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
map('n', '<leader>k', ':Lspsaga hover_doc<cr>', opts)
map('n', '<leader>gs', ':Lspsaga signature_help<cr>', opts)
map('n', '<leader>gh', ':Lspsaga lsp_finder<cr>', opts)
map('n', '<leader>gr', ':Lspsaga rename<cr>', opts)
map('n', '<C-r><C-r>', ':Lspsaga rename<cr>', opts)
map('n', '<leader>ca', ':Lspsaga code_action<cr>', opts)
