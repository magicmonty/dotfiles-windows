local lspColors = require("lsp-colors")
local nightfox = require("nightfox.colors")
local icons = require("icons")
local c = nightfox.init()
lspColors.setup({
  Error = c.red,
  Warning = c.orange,
  Information = c.cyan_dm,
  Hint = c.green_dm
})

-- LSP signs default
vim.fn.sign_define(
  "DiagnosticSignError",
  { texthl = "DiagnosticSignError", text = icons.diagnostics.Error, numhl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { texthl = "DiagnosticSignWarn", text = icons.diagnostics.warning, numhl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { texthl = "DiagnosticSignHint", text = icons.diagnostics.Hint, numhl = "DiagnosticSignHint" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { texthl = "DiagnosticSignInfo", text = icons.diagnostics.Info, numhl = "DiagnosticSignInformation" }
)

