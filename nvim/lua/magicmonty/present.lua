local M = {}

M.enable = function()
  vim.g.miniindentscope_disable = true
  vim.cmd.IBLDisableScope()
  vim.cmd.IBLDisable()
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0
  vim.opt.list = false
  vim.opt.colorcolumn = ''
  vim.opt.cursorline = false

  vim.keymap.set('n', '<leader><right>', ':bn<CR>', { silent = true, remap = false })
  vim.keymap.set('n', '<leader><left>', ':bp<CR>', { silent = true, remap = false })
end

return M
