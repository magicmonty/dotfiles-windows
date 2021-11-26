local status,nightfox = pcall(require, "nightfox")
if not status then return end

if status then
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
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

local has_blankline, blankline = pcall(require, 'indent_blankline')
if has_blankline then
  blankline.setup({
    show_end_of_line = true,
    space_char_blank_line = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
end
