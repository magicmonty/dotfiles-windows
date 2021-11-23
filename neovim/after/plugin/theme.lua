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
