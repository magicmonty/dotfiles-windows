local installed, lsp_lines = pcall(require, 'lsp_lines')
if not installed then
  return
end

lsp_lines.setup()
vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
