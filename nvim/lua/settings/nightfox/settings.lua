local opt = vim.opt
local cmd = vim.cmd
local vim_ext = require("vim_ext")
local augroup = vim_ext.augroup
local nightfox = require("nightfox")


nightfox.setup({
  options = {
    terminal_colors = true,
    transparent = false,
    inverse = {
      visual = false,
    },
    styles = {
      comments = "italic",
      keywords = "bold",
    },
    alt_nc = true,
    groups = {
      IndentBlanklineChar = { fg = '${comment}' },
      IndentBlanklineContextChar = { fg= '${pink}' },
      DebugBreakpointSign = { fg = '${red}' },
      DebugBreakpointLine = { bg = '${diff.delete}' },
      TSTag = { fg = '${red}'},
      TSTagDelimiter = { fg = '${fg}'},
      htmlTag = { fg = '${red}'},
      htmlEndTag = { fg = '${red}'},
      NvimTreeExecFile = { style = 'bold' },
      NvimTreeGitDirty = { fg = '${git.change}' },
      NvimTreeGitStaged = { fg = '${green_br}' },
      NvimTreeGitMerge = { fg = '${orange}' },
      NvimTreeGitRenamed = { fg = '${green_dm}' },
      NvimTreeGitNew = { fg = '${git.add}' },
      NvimTreeGitDeleted = { fg = '${git.delete}' },
    }
  },
})

vim.cmd [[ colorscheme nightfox ]]


opt.list = true

-- Highlight column 120
opt.colorcolumn = "120"

opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

-- Hide cursorline on inactive windows
opt.cursorline = true
augroup("BgHighlight", {
  { "WinEnter", "*", "set cursorline" },
  { "WinLeave", "*", "set nocursorline" }
})

opt.background = "dark"

local has_blankline, blankline = pcall(require, 'indent_blankline')
if has_blankline then
  blankline.setup({
    show_end_of_line = true,
    space_char_blank_line = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
end
