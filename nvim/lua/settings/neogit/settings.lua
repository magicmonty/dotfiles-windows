local has_neogit, neogit = pcall(require, 'neogit')
if not has_neogit then
  return
end

neogit.setup({})

vim.keymap.set('n', '<leader>gs', neogit.open)
