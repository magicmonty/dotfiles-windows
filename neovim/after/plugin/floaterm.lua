if vim.fn.has('win32') then
  if (vim.fn.executable('pwsh') > 0) then
    vim.opt.shell = 'pwsh'
  else
    vim.opt.shell = 'powershell'
  end

  local profile = ' -Command  \'iex "' .. vim.env.USERPROFILE .. '\\.dotfiles\\powershell\\profile.core.ps1"\';'
  vim.opt.shellcmdflag = '-ExecutionPolicy Bypass -NoLogo -NoExit' .. profile 

  vim.opt.shellredir = '2>&1 | Out-file -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | Out-file -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.shellxquote = ''
end

vim.g.floaterm_shell=vim.opt.shell:get()
vim.g.floaterm_gitcommit='floaterm'
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_wintitle=0
vim.g.floaterm_autoclose=1
vim.g.floaterm_borderchars = "─|─|++++"

local map = require("vim_ext").map
local au = require("vim_ext").au

map('n', '<leader>t,', ':FloatermNew<cr>', { noremap = true, silent = true})
map('n', '<leader>tv', ':FloatermNew --wintype=vsplit<cr>', { noremap = true, silent = true})
map('n', '<leader>th', ':FloatermNew --wintype=split<cr>', { noremap = true, silent = true})
map('n', '<leader>tg', ':FloatermNew lazygit<cr>', { noremap = true, silent = true})
map('n', '<leader>tt', ':FloatermToggle<cr>', { noremap = true, silent = true})
map('n', '<leader>tq', ':FloatermKill<cr>', { noremap = true, silent = true})
map('n', '<C-y>', ':FloatermToggle<cr>', { noremap = true, silent = true})
map('t', '<C-y>', '<C-\\><C-n>:FloatermToggle<cr>', { noremap = true, silent = true})

au({'TermOpen', '*', 'tnoremap <Esc> <C-\\><C-n>'})
au({'BufEnter', '*', "if &buftype == 'terminal' | :startinsert | endif"})
