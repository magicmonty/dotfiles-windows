local opt = vim.opt
local cmd = vim.cmd
local vim_ext = require("vim_ext")
local augroup = vim_ext.augroup
local nightfox = require("nightfox")

nightfox.setup({
	options = {
		terminal_colors = true,
		transparent = false,
		dim_inactive = true,
		inverse = {
			visual = false,
		},
		styles = {
			comments = "italic",
			keywords = "bold",
		},
		alt_nc = true,
	},
	groups = {
		IndentBlanklineChar = { fg = "syntax.comment" },
		IndentBlanklineContextChar = { fg = "palette.pink" },
		DebugBreakpointSign = { fg = "palette.red" },
		DebugBreakpointLine = { bg = "diff.delete" },
		TSTag = { fg = "palette.red" },
		TSTagDelimiter = { fg = "fg0" },
		htmlTag = { fg = "palette.red" },
		htmlEndTag = { fg = "palette.red" },
		NvimTreeExecFile = { style = "bold" },
		NvimTreeGitDirty = { fg = "git.changed" },
		NvimTreeGitStaged = { fg = "palette.green.bright" },
		NvimTreeGitMerge = { fg = "palette.orange" },
		NvimTreeGitRenamed = { fg = "palette.green.dim" },
		NvimTreeGitNew = { fg = "git.add" },
		NvimTreeGitDeleted = { fg = "git.removed" },
		GitSignsAdd = { fg = "git.add" },
		GitSignsAddNr = { fg = "git.add" },
		GitSignsChange = { fg = "git.changed" },
		GitSignsChangeNr = { fg = "git.changed" },
		GitSignsDelete = { fg = "git.removed" },
		GitSignsDeleteNr = { fg = "git.removed" },
	},
})

vim.cmd([[ colorscheme nightfox ]])

opt.list = true

-- Highlight column 120
opt.colorcolumn = "120"

opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

-- Hide cursorline on inactive windows
opt.cursorline = true
augroup("BgHighlight", {
	{ "WinEnter", "*", "set cursorline" },
	{ "WinLeave", "*", "set nocursorline" },
})

opt.background = "dark"

local has_blankline, blankline = pcall(require, "indent_blankline")
if has_blankline then
	blankline.setup({
		show_end_of_line = true,
		space_char_blank_line = " ",
		show_current_context = true,
		show_current_context_start = true,
	})
end
