local notify = require("notify")
local icons = require("icons")

notify.setup {
  timeout = 3000,
  stages = "fade",
  icons = {
    ERROR = icons.diagnostics.Error,
    WARN = icons.diagnostics.Warning,
    INFO = icons.diagnostics.Info,
    DEBUG = icons.diagnostics.Debug,
    TRACE = icons.diagnostics.Trace,
  },
  background_colour = require("nightfox.colors").init().bg
}
