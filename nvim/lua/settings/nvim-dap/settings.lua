local status, dap = pcall(require, 'dap')
if not status then
  return
end

local fn = vim.fn
require('nvim-dap-virtual-text').setup()

dap.defaults.fallback.force_external_terminal = true
dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

local dbg_path = fn.expand(fn.stdpath('data') .. '/dapinstall/')
dap.adapters.netcoredbg = {
  type = 'executable',
  command = fn.expand(dbg_path .. 'netcoredbg/netcoredbg.exe'),
  options = {
    env = {
      ASPNETCORE_ENVIRONMENT = 'Development',
      cwd = '${workspaceFolder}',
    },
  },
  args = { '--interpreter=vscode' },
}

dap.adapters.server = {
  type = 'server',
  host = '127.0.0.1',
  port = 4711,
}

dap.adapters.vsdbg = {
  type = 'executable',
  command = vim.fn.expand(
    'C:/Users/mgondermann/.vscode/extensions/ms-dotnettools.csharp-1.23.16/.debugger/vsdbg-ui.exe'
  ),
  options = {
    env = {
      ASPNETCORE_ENVIRONMENT = 'Development',
      cwd = '${workspaceFolder}',
    },
  },
  args = {},
}

dap.configurations.cs = {
  {
    type = 'vsdbg',
    name = 'launch - netcoredbg',
    request = 'launch',
    program = function()
      return fn.input('Path to dll: ', fn.expand(fn.getcwd() .. '/bin/x64/Debug/'), 'file')
    end,
  },
}

fn.sign_define(
  'DapBreakpoint',
  { text = '', texthl = 'DebugBreakpointSign', linehl = 'DebugBreakpointLine', numhl = '' }
)

-- require('dap.ext.vscode').load_launchjs()
require('dapui').setup()
vim.cmd([[ command! DapUi :lua require("dapui").toggle()]])

local map = require('vim_ext').map

map('n', '<F5>', ':lua require("dap").continue()<cr>', { noremap = true, silent = true })
map('n', '<F9>', ':lua require("dap").toggle_breakpoint()<cr>', { noremap = true, silent = true })
map('n', '<F10>', ':lua require("dap").step_over()<cr>', { noremap = true, silent = true })
map('n', '<F11>', ':lua require("dap").step_into()<cr>', { noremap = true, silent = true })
map('n', '<S-F11>', ':lua require("dap").step_out()<cr>', { noremap = true, silent = true })
map('n', '<leader>dl', ':lua require("dap").run_last()<cr>', { noremap = true, silent = true })
map('n', '<leader>dr', ':Telescope dap configurations<cr>', { noremap = true, silent = true })
map('n', '<leader>du', ':DapUi<cr>', { noremap = true, silent = true })
map('n', '<leader>dq', ':lua require("dap").terminate()<cr>', { noremap = true, silent = true })
