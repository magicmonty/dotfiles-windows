local M = {}

M.setup = function()
  local has_noice, noice = pcall(require, 'noice')
  if not has_noice then
    return
  end

  noice.setup({
    history = {
      view = 'split',
    },
  })
end

return M
