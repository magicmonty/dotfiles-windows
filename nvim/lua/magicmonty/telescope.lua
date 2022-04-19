-- vim: foldlevel=99:
local utils = require('telescope.utils')

local M = {}

M.search_config = function()
  local opts = {
    cwd = '~/.dotfiles/neovim/',
    path_display = {
      'absolute',
    },
  }

  require('telescope.builtin').find_files(opts)
end

M.project_files = function()
  local _, ret, _ = utils.get_os_command_output({
    'git',
    'rev-parse',
    '--is-inside-work-tree',
  })

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = ' Git Files'
  gopts.prompt_prefix = '  '
  gopts.results_title = 'Project Files Results'

  fopts.hidden = true

  fopts.file_ignore_patterns = {
    '.vim/',
    '.local/',
    '.cache/',
    'Downloads/',
    '.git/',
    'Dropbox/.*',
    'Library/.*',
    '.rustup/.*',
    'Movies/',
    '.cargo/registry/',
  }

  if ret == 0 then
    require('telescope.builtin').git_files(gopts)
  else
    require('telescope.builtin').find_files(fopts)
  end
end

local devicons = require('nvim-web-devicons')
local entry_display = require('telescope.pickers.entry_display')

local filter = vim.tbl_filter
local map = vim.tbl_map

function M.gen_buffer_display(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon('file', '', { default = true })

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr = math.max(unpack(bufnrs))
  local bufnr_width = #tostring(max_bufnr)

  local max_bufname = math.max(unpack(map(function(bufnr)
    return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:t'))
  end, bufnrs)))

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = bufnr_width },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.bufnr, 'TelescopeResultsNumber' },
      { entry.indicator, 'TelescopeResultsComment' },
      { entry.devicons, entry.devicons_highlight },
      entry.file_name,
      { entry.dir_name, 'Comment' },
    })
  end

  return function(entry)
    local bufname = entry.info.name ~= '' and entry.info.name or '[No Name]'
    local hidden = entry.info.hidden == 1 and 'h' or 'a'
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, 'readonly') and '=' or ' '
    local changed = entry.info.changed == 1 and '+' or ' '
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ':p:h')
    local file_name = vim.fn.fnamemodify(bufname, ':p:t')

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, '%a+$'), { default = true })

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. ' : ' .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

return M
