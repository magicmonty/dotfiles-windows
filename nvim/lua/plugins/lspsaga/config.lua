local installed, saga = pcall(require, 'lspsaga')
if not installed then
  return
end

local icons = require('magicmonty.theme').icons.diagnostics

saga.init_lsp_saga({
  server_filetype_map = {},
  diagnostic_header = { icons.Error, icons.Warning, icons.Information, icons.Hint },
  code_action_icon = icons.CodeAction .. ' ',
  code_action_keys = {
    quit = { 'q', '<Esc>' },
    exec = '<CR>',
  },
  finder_action_keys = {
    edit = 'o',
    vsplit = 'v',
    split = 's',
    tabe = 't',
    quit = { 'q', '<Esc>' },
  },
})
