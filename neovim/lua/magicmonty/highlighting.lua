-- vim: foldlevel=99:
local vim_ext = require("vim_ext")
local hi = vim_ext.hi
local augroup = vim_ext.augroup
local opt = vim.opt

--
-- Highlights
-- ----------
opt.cursorline = true

-- Highlight column 120
opt.colorcolumn = "120"

-- Hide cursorline on inactive windows
augroup("BgHighlight", {
  { "WinEnter", "*", "set cursorline" },
  { "WinLeave", "*", "set nocursorline" }
})

