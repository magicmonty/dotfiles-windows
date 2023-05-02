local M = {}

M.current_buffer_path = function()
  return vim.fn.expand('%:p:h'):gsub("\\", "/")
end

M.root_pattern = function(...)
  local args = { ... }

  local rp_function = require("lspconfig.util").root_pattern(unpack(args))
  return function(fname)
    return rp_function(M.current_buffer_path())
  end
end

return M
