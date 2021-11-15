local status, notify = pcall(require, "notify")
if not status then return end

local nightfox
status, nightfox = pcall(require, "nightfox.colors")
if status then
  notify.setup {
    timeout = 3000,
    stages = "fade",
    icons = {
      ERROR = '',
      WARN = "",
      INFO = '',
      DEBUG = "",
      TRACE = "✎",
    },   background_colour = nightfox.init().bg
  }
else
  notify.setup({
    timeout = 3000,
    stages = "fade",
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  })
end

local log = require("plenary.log").new {
  plugin = "notify",
  level = "debug",
  use_console = false
}
vim.notify = notify

vim.notify = function(msg, level, opts)
  log.info(msg, level, opts)
  require("notify")(msg, level, opts)
end
