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

local installed, h = pcall(require, 'null-ls.helpers')
if installed then
  local methods = require('null-ls.methods')
  local cmd_resolver = require('null-ls.helpers.command_resolver')
  local u = require('null-ls.utils')

  local FORMATTING = methods.internal.FORMATTING
  local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

  M.prettier_eslint = h.make_builtin({
    name = 'prettier_eslint',
    meta = {
      url = 'https://github.com/prettier/prettier-eslint-cli',
      description = 'Prettier with eslint settings',
    },
    method = { FORMATTING },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
      'jsx',
    },
    factory = h.formatter_factory,
    generator_opts = {
      command = 'prettier-eslint',
      args = { '--stdin', '--parser', 'babel' },
      to_stdin = true,
    },
  })

  M.prettier_eslint_json = h.make_builtin({
    name = 'prettier_eslint',
    meta = {
      url = 'https://github.com/prettier/prettier-eslint-cli',
      description = 'Prettier with eslint settings',
    },
    method = { FORMATTING },
    filetypes = {
      'json',
      'jsonc',
    },
    factory = h.formatter_factory,
    generator_opts = {
      command = 'prettier-eslint',
      args = { '--stdin', '--parser', 'json' },
      to_stdin = true,
    },
  })
end

return M
