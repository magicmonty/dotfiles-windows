local lspColors = require("lsp-colors")
local theme = require("magicmonty.theme")
local colors = theme.colors
local icons = theme.icons

lspColors.setup({
	Error = colors.diag.error,
	Warning = colors.diag.warn,
	Information = colors.diag.info,
	Hint = colors.diag.hint,
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
