local M = {}

M.opts = {
  single_file_support = false,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx",
    'vue', 'svelte', 'astro' },
  root_dir = require("magicmonty.lsp_util").root_pattern("package.json", "node_modules", "tsconfig.json", "webpack.config.js", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc", ".git")
}

return M
