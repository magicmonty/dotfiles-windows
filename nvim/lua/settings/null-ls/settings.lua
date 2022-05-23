local nullls = require('null-ls')

nullls.setup({
  debug = true,
  sources = {
    nullls.builtins.formatting.stylua,
    nullls.builtins.formatting.prettier.with({
      extra_args = {
        '--single-quote',
        '--bracket-same-line: true',
        '--arrow-parens: avoid',
      },
    }),
  },
  on_attach = function(client)
    if client.server_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end,
})
