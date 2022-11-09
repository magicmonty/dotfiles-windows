local installed, null_ls = pcall(require, 'null-ls')
if not installed then
  return
end

local b = null_ls.builtins

local sources = {
  require('magicmonty.formatters').prettier_eslint,
  b.formatting.stylua,
}

null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = function(client)
    vim.diagnostic.config({ virtual_text = false })
    if client.server_capabilities.documentFormattingProvider then
      local augroup_formatting = vim.api.nvim_create_augroup('NullLsFormatting', { clear = true })
      vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_formatting })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup_formatting,
        buffer = 0,
        callback = function()
          vim.lsp.buf.format(nil)
        end,
      })
    end
  end,
})
