local lspColors = require("lsp-colors")
local theme = require("magicmonty.theme")
local pallet = theme.colors.pallet;
local spec = theme.colors.spec
local icons = theme.icons

lspColors.setup({
  Error = spec.diag.error,
  Warning = spec.diag.warn,
  Information = spec.diag.info,
  Hint = spec.diag.hint
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
