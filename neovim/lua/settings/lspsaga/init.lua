-- vim: foldlevel=99:
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
  finder_action_keys= {
    open = '<CR>',
    vsplit = 'v',
    split = 's',
    quit = '<Esc>',
    scroll_down = 'f',
    scroll_up = 'b'
  },
  code_action_keys = {
    quit = '<Esc>',
    exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<Esc>',
    exec = '<CR>'
  }
}
