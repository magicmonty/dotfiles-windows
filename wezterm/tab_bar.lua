local wt = require('wezterm')
local utils = require('utils')
local bg = utils.bg
local fg = utils.fg
local txt = utils.txt

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if not title or #title == 0 then
    title = tab_info.active_pane.title

    if title == 'pwsh.exe' then
      title = 'Windows Powershell'
    end
  end

  if not tab_info.is_active and tab_info.tab_index < 9 then
    title = (tab_info.tab_index + 1) .. ': ' .. title
  end

  return title
end

wt.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local colors = config.resolved_palette.tab_bar
  local tab_colors = tab.is_active and colors.active_tab or colors.inactive_tab

  local background = tab_colors.bg_color
  local foreground = tab_colors.fg_color

  return {
    bg(background),
    fg(foreground),
    txt(tab_title(tab)),
  }
end)
