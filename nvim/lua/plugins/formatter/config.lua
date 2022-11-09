require('formatter').setup({
  filetype = {
    javascript = { require('formatter.filetypes.javascript').prettiereslint },
    typescript = { require('formatter.filetypes.typescript').prettiereslint },
    javascriptreact = { require('formatter.filetypes.javascriptreact').prettiereslint },
    typescriptreact = { require('formatter.filetypes.typescriptreact').prettiereslint },
    html = { require('formatter.filetypes.html').prettier },
    css = { require('formatter.filetypes.css').prettier },
    scss = { require('formatter.filetypes.css').prettier },
    lua = { require('formatter.filetypes.lua').stylua },
  },
})
