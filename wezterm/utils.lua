local wt = require('wezterm')
local nf = wt.nerdfonts

local M = {}

M.bg = function(color)
  return { Background = { Color = color } }
end

M.fg = function(color)
  return { Foreground = { Color = color } }
end

M.txt = function(text)
  return { Text = text }
end

M.left_arrow = function()
  return M.txt(nf.pl_right_hard_divider)
end

M.right_arrow = function()
  return M.txt(nf.pl_left_hard_divider)
end

return M
