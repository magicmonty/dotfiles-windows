vim.opt.shell = 'pwsh.exe'

if vim.fn.has('win32') then
  local profile = '-f ' .. vim.env.USERPROFILE .. '/dotfiles/Powershell/profile.core.ps1'

  vim.opt.shellcmdflag = '-ExecutionPolicy Bypass -NoLogo -NoProfile -NoExit ' .. profile
  vim.opt.shellredir = '2>&1 | Out-file -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | Out-file -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.shellxquote = ''
end

vim.g.neoterm_default_mod = 'belowright'
vim.g.neoterm_autoinsert = true
vim.g.neoterm_autoscropp = true

local map = require("vim_ext").map
local au = require("vim_ext").au

map('n', '<C-y>', ':Ttoggle<cr>', {silent = true, noremap = true})
map('n', '<C-Y>', ':Ttoggle<cr>', {silent = true, noremap = true})
map('n', '<C-y>', '<Esc>:Ttoggle<cr>', {silent = true, noremap = true})
map('t', '<C-y>', '<C-\\><C-n>:Ttoggle<cr>', {silent = true, noremap = true})
map('t', '<C-w>h', '<C-\\><C-n><C-w>h')
map('t', '<C-w><Left>', '<C-\\><C-n><C-w>h')
map('t', '<C-w>l', '<C-\\><C-n><C-w>l')
map('t', '<C-w><Right>', '<C-\\><C-n><C-w>l')
map('t', '<C-w>j', '<C-\\><C-n><C-w>j')
map('t', '<C-w><Down>', '<C-\\><C-n><C-w>j')
map('t', '<C-w>k', '<C-\\><C-n><C-w>k')
map('t', '<C-w><Up>', '<C-\\><C-n><C-w>k')
au({'TermOpen', '*', 'tnoremap <Esc> <C-\\><C-n>'})
au({'BufEnter', '*', "if &buftype == 'terminal' | :startinsert | endif"})
