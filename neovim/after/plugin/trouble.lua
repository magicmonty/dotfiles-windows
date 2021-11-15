local status, trouble = pcall(require, "trouble")
if not status then return end

local map = require("vim_ext").map

trouble.setup({
  use_lsp_diagnostic_signs = true
})

map('n', '<leader>xx', ':TroubleToggle<cr>', {silent = true, noremap = true})
map('n', '<leader>xw', ':Trouble lsp_workspace_diagnostics<cr>', {silent = true, noremap = true})
map('n', '<leader>xd', ':Trouble lsp_document_diagnostics<cr>', {silent = true, noremap = true})
map('n', '<leader>xq', ':Trouble quickfix<cr>', {silent = true, noremap = true})
map('n', '<leader>xl', ':Trouble loclist<cr>', {silent = true, noremap = true})
