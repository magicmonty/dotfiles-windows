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
      notes = '',
    },
    method = { FORMATTING, RANGE_FORMATTING },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
      'css',
      'scss',
      'less',
      'html',
      'json',
      'jsonc',
      'yaml',
      'markdown',
      'markdown.mdx',
      'graphql',
      'handlebars',
    },
    generator_opts = {
      command = 'prettier-eslint',
      args = h.range_formatting_args_factory({
        '--stdin-filepath',
        '$FILENAME',
      }, '--range-start', '--range-end', { row_offset = -1, col_offset = -1 }),
      to_stdin = true,
      dynamic_command = cmd_resolver.from_node_modules(),
      cwd = h.cache.by_bufnr(function(params)
        return u.root_pattern(
        -- https://prettier.io/docs/en/configuration.html
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.js',
          '.prettierrc.cjs',
          '.prettierrc.toml',
          'prettier.config.js',
          'prettier.config.cjs',
          'package.json'
        )(params.bufname)
      end),
    },
    factory = h.formatter_factory,
  })
end

return M
