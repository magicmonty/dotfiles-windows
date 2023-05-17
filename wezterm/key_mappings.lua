local wt = require('wezterm')
local act = wt.action
local M = {}

local resize_pane = 'resize_pane'

M.leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 1000 }
M.default_mappings = {}
local function mapl(key, action)
  table.insert(M.default_mappings, { key = key, mods = 'LEADER', action = action })
end
local function mapc(key, action)
  table.insert(M.default_mappings, { key = key, mods = 'CTRL', action = action })
end

-- Splits with <Leader># (Horizontal) or <Leader>- (Vertical)
mapl('#', act.SplitHorizontal({ domain = 'CurrentPaneDomain' }))
mapl('-', act.SplitVertical({ domain = 'CurrentPaneDomain' }))

--  Move between Splits (either <Ctrl>h/j/k/l or <Leader>h/j/k/l or <Leader>ArrowKey)
mapl('h', act.ActivatePaneDirection('Left'))
mapl('LeftArrow', act.ActivatePaneDirection('Left'))
mapc('h', act.ActivatePaneDirection('Left'))

mapl('j', act.ActivatePaneDirection('Down'))
mapl('DownArrow', act.ActivatePaneDirection('Down'))
mapc('j', act.ActivatePaneDirection('Down'))

mapl('k', act.ActivatePaneDirection('Up'))
mapl('UpArrow', act.ActivatePaneDirection('Up'))
mapc('k', act.ActivatePaneDirection('Up'))

mapl('l', act.ActivatePaneDirection('Right'))
mapl('RightArrow', act.ActivatePaneDirection('Right'))
mapc('l', act.ActivatePaneDirection('Right'))

-- <Leader>r activates resize mode
mapl('r', act.ActivateKeyTable({ name = resize_pane, one_shot = false }))

-- <Leader>g or <Ctrl>g opens a new Tab with lazygit
mapl('g', act.SpawnCommandInNewTab({ args = { 'lazygit' } }))
mapc('g', act.SpawnCommandInNewTab({ args = { 'lazygit' } }))

-- <Leader>t opens a new tab
mapl('t', act.SpawnTab('CurrentPaneDomain'))
mapl(',', act.ActivateTabRelative(-1))
mapl('.', act.ActivateTabRelative(1))

-- <Leader><CTRL>Space or <Leader>Space activates Copy Mode
table.insert(M.default_mappings, { key = 'Space', mods = 'LEADER|CTRL', action = act.ActivateCopyMode })
table.insert(M.default_mappings, { key = 'Space', mods = 'LEADER', action = act.ActivateCopyMode })

-- <CTRL+SHIFT>r reloads the configuration
table.insert(M.default_mappings, { key = 'R', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration })

-- <Leader>u opens URL in Browser ( https://www.google.de )
mapl(
  'u',
  act.QuickSelectArgs({
    label = 'open URL',
    patterns = { "(?:https?://[a-zA-Z0-9_.~!*'();:@&=+$,/?#\\[%-\\]]+|\\\\[\\S ]+)" },
    action = wt.action_callback(function(window, pane)
      local url = window:get_selection_text_for_pane(pane)
      wt.log_info('opening URL ' .. url)
      wt.open_with(url)
    end),
  })
)

M.key_tables = {
  [resize_pane] = {
    { key = 'LeftArrow', action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },

    { key = 'RightArrow', action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },

    { key = 'UpArrow', action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },

    { key = 'DownArrow', action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },
  copy_mode = wt.gui.default_key_tables().copy_mode,
}

return M
