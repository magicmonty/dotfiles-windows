local M = {}

M.stylua = function()
  return {
    exe = 'stylua',
    args = {
      '--config-path ' .. os.getenv('XDG_CONFIG_HOME') .. '/stylua/stylua.toml',
      '-',
    },
    stdin = true,
  }
end

M.prettier = function()
  return {
    exe = 'prettier',
    args = {
      '--stdin-filepath',
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--single-quote',
    },
    stdin = true,
  }
end

return M
