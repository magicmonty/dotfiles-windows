local opt = vim.opt
local cmd = vim.cmd
local vim_ext = require("vim_ext")
local hi = vim_ext.hi
local augroup = vim_ext.augroup

nightfox = require("nightfox")

nightfox.setup({
  fox = "nightfox",
  transparent = false,
  alt_nc = true,
  terminal_colors = true,
  styles = {
    comments = "italic",
    keywords = "bold",
  },
  inverse = {
    visual = false,
  },
  hlgroups = {
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
})

nightfox.load()

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

if opt.termguicolors and opt.winblend then
  cmd 'syntax enable'
  opt.termguicolors = true
  opt.winblend = 0
  opt.wildoptions = { 'pum' }
  opt.pumblend = 5
  opt.background = "dark"
end

local has_blankline, blankline = pcall(require, 'indent_blankline')
if has_blankline then
  blankline.setup({
    show_end_of_line = true,
    space_char_blank_line = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
end
