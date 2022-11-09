local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_auto_snippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<-', 'NonTest' } },
      },
    },
  },
})

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.dotfiles/snippets' })

-- expand snippet
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- jump backward
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- select from choices
vim.keymap.set({ 'i' }, '<C-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set('i', '<C-u>', require('luasnip.extras.select_choice'))