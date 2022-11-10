local theme = require('magicmonty.theme')
local icons = theme.icons
local theme_colors = theme.colors

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  has_gitsigns_info = function()
    return vim.b.gitsigns_status_dict ~= nil
  end,
}

local config = {
  options = {
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = { 'NvimTree' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return icons.git.branch .. ' ' .. gitsigns.head
          end
        end,
        cond = conditions.has_gitsigns_info,
        separator = '',
      },
      {
        'diff',
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
        symbols = {
          added = icons.git.added .. ' ',
          modified = icons.git.modified .. ' ',
          removed = icons.git.removed .. ' ',
        },
        diff_color = {
          added = { fg = theme_colors.git.add },
          modified = { fg = theme_colors.git.changed },
          removed = { fg = theme_colors.git.removed },
        },
        cond = conditions.has_gitsigns_info,
      },
    },
    lualine_c = {},
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
          hint = icons.diagnostics.Hint,
        },
      },
    },
    lualine_y = {
      {
        function()
          local total_lines = vim.fn.line('$')
          if total_lines > 1 then
            local current_line = vim.fn.line('.')
            local chars = {
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
            }
            local line_ratio = current_line / total_lines
            local percentage = math.floor(line_ratio * 100)
            local index = math.ceil(line_ratio * #chars)
            return chars[index] .. ' ' .. string.format('%02d%%%%', percentage)
          end
          return ''
        end,
      },
    },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
        file_status = true,
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'fugitive' },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({ 'filename', file_status = true })
ins_right({
  'filetype',
  cond = conditions.buffer_not_empty,
  separator = '',
})

ins_right({
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then
      return ' '
    end
    return ''
  end,
  color = { fg = theme_colors.palette.green.base },
})

ins_right({ 'encoding', cond = conditions.buffer_not_empty })

local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

ins_left({
  'lsp_progress',
  display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
  colors = {
    percentage = colors.cyan,
    title = colors.red,
    message = colors.cyan,
    spinner = colors.cyan,
    lsp_client_name = colors.magenta,
    use = true,
  },
  separators = {
    component = ' ',
    progress = ' | ',
    message = { pre = '(', post = ')', commenced = 'In Progress', completed = 'Completed' },
    percentage = { pre = '', post = '%% ' },
    title = { pre = '', post = ': ' },
    lsp_client_name = { pre = '[', post = ']' },
    spinner = { pre = '', post = '' },
  },
  spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
})
require('lualine').setup(config)
