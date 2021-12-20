local map = require("vim_ext").map
local silent = { silent = true }

require('tabline').setup( { options = { show_filename_only = true } })

-- Buffer navigation with leader key
-- map('n', '<leader>bn', ':TablineBufferNext<cr>', silent)
-- map('n', '<leader>bp', 'TablineBufferPrevious<cr>', silent)
map('n', '<leader>bn', ':bn<cr>', silent)
map('n', '<leader>bp', ':bp<cr>', silent)

map('n', '<leader>Tc', ':TablineTabNew<cr>', silent)
map('n', '<leader>Tn', ':tabnext<cr>', silent)
map('n', '<leader>Tp', ':tabprev<cr>', silent)
map('n', '<leader>Tb', ':TablineToggleShowAllBuffers<cr>', silent)
map('n', '<leader>Tr', ':TablineTabRename ', { noremap = true })
