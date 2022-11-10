local config = {
  disabled_filetype = { 'TelescopePrompt' },
  check_ts = true,
  ts_config = {
    lua = { 'string' }, -- don't add auto pair on lua string nodes
  },
  enable_check_bracket_line = true,
  fast_wrap = {},
}

local M = {}

M.setup = function()
  local installed, ap = pcall(require, 'nvim-autopairs')
  if not installed then
    return
  end
  ap.setup(config)
end

return M
