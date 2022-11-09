local installed, signature = pcall(require, 'lsp_signature')
if not installed then
  return
end

signature.setup({})
