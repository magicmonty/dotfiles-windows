local M = {}

M.opts = {
  single_file_support = false,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx', 
    'vue',
    'svelte',
    'astro'
},
root_dir = require("magicmonty.lsp_util").root_pattern(
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.json',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc')
}

return M

