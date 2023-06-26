local wt = require('wezterm')
local mux = wt.mux

--[[ wt.on('update-right-status', function(window, pane)
  window:set_left_status('left')
  window:set_right_status('right')
end) ]]

wt.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

require('status_bar')
require('tab_bar')
local mappings = require('key_mappings')

return {
  adjust_window_size_when_changing_font_size = false,
  allow_win32_input_mode = true,
  audible_bell = 'Disabled',
  bold_brightens_ansi_colors = 'BrightAndBold',
  color_scheme = 'nightfox',
  custom_block_glyphs = true,
  default_cwd = 'C:\\Projects',
  default_prog = {
    'pwsh',
    '-ExecutionPolicy',
    'Bypass',
    '-NoLogo',
    -- '-NoProfile',
    '-NoExit',
    -- '-Command',
    -- 'iex ". \'$env:USERPROFILE\\.dotfiles\\powershell\\profile.core.ps1\'"',
  },
  exit_behavior = 'Close',
  font = wt.font('JetBrainsMono Nerd Font'),
  font_size = 12.0,
  force_reverse_video_cursor = false,
  hide_mouse_cursor_when_typing = true,
  hide_tab_bar_if_only_one_tab = false,
  key_tables = mappings.key_tables,
  keys = mappings.default_mappings,
  leader = mappings.leader,
  warn_about_missing_glyphs = false,
  window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
  launch_menu = require('launch_menu'),
  pane_focus_follows_mouse = false,
  unicode_version = 14,
  -- win32_system_backdrop = 'Acrylic',
  window_background_opacity = 0.95,
  tab_bar_style = {
    new_tab = '<+>',
  },
  window_close_confirmation = 'NeverPrompt',
  window_frame = {
    inactive_titlebar_bg = '#131a24',
    active_titlebar_bg = '#131a24',
    inactive_titlebar_border_bottom = '#131a24',
    active_titlebar_border_bottom = '#212e3f',
    button_fg = '#aeafb0',
    button_bg = '#192330',
    button_hover_bg = '#29394f',
    button_hover_fg = '#cdcecf',
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  ssh_domains = {},
}
