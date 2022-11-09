local installed, null_ls = pcall(require, 'null-ls')
if not installed then
  return
end

local my_formatters = require('magicmonty.formatters')
local b = null_ls.builtins

null_ls.setup({
  debug = true,
  sources = {
    b.formatting.stylua,
    my_formatters.prettier_eslint
  },
  on_attach = function(client, bufnr)
    vim.diagnostic.config({ virtual_text = false })
    if client.server_capabilities.documentFormattingProvider then
      local augroup_formatting = vim.api.nvim_create_augroup('NullLsFormatting', { clear = true })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup_formatting })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup_formatting,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 10000 })
        end,
      })
    end
  end,
})
