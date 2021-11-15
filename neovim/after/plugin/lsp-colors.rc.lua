local status, lspColors = pcall(require, "lsp-colors")
if not status then return end

local nightfox;
status,nightfox = pcall(require, "nightfox.colors")
if status then
  local c = nightfox.init()
  lspColors.setup({
    Error = c.red,
    Warning = c.orange,
    Information = c.cyan_dm,
    Hint = c.green_dm
  })
else
  lspColors.setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })
end
