if not vim.g.loaded_vsnip then return end

-- Jump forward or backward
vim.api.nvim_set_keymap('i', '<Tab>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<Tab>'", { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<Tab>'", { expr = true })

