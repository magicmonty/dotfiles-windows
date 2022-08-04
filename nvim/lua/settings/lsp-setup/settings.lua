local installed, lsp_setup = pcall(require, 'nvim-lsp-setup')
if not installed then
  return
end

local root_pattern = require('lspconfig.util').root_pattern
local mappings = require('magicmonty.mappings')

-- Nicer Icons in LspInstallInfo
require('mason').setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
    keymaps = {
      toggle_package_expand = '<CR>',
      install_package = 'i',
      update_package = 'u',
      check_package_version = 'c',
      update_all_packages = 'U',
      check_outdated_packages = 'C',
      uninstall_package = 'X',
      cancel_installation = '<C-c>',
      apply_language_filter = '<C-f>',
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'sumneko_lua', 'json', 'marksman' },
})

local function on_attach(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings.
  local leader_mappings = {
    l = {
      name = 'LSP',
      f = { '<cmd>Format<cr>', 'Format buffer' },
      n = { vim.lsp.buf.rename, 'Rename symbol' },
    },
    d = {
      name = 'Diagnostics',
      l = { '<cmd>Telescope diagnostics<CR>', 'Workspace diagnostics list' },
      n = { vim.diagnostic.goto_next, 'Jump to next diagnostic entry' },
      p = { vim.diagnostic.goto_prev, 'Jump to previous diagnostic entry' },
    },
  }

  if client.server_capabilities.codeActionProvider then
    leader_mappings.l.a = { vim.lsp.buf.code_action, 'Show available code actions' }
  end

  mappings.register(leader_mappings, { prefix = '<leader>', buffer = bufnr, mode = 'n', noremap = true, silent = true })

  local normal_mappings = {
    ['<C-s>'] = { vim.lsp.buf.signature_help, 'Show signature help' },
    g = {
      name = 'Goto',
      d = { '<cmd>Telescope lsp_definitions<CR>', 'Goto definition' },
      D = { vim.lsp.buf.declaration, 'Goto declaration' },
      i = { '<cmd>Telescope lsp_implementations<CR>', 'Goto implementation' },
      r = { '<cmd>Telescope lsp_references<CR>', 'Goto reference' },
      T = { '<cmd>Telescope lsp_type_definitions<CR>', 'Goto type definition' },
    },
    K = { vim.lsp.buf.hover, 'Show hover documentation' },
    ['<M-End>'] = { vim.diagnostic.goto_next, 'Jump to next diagnostic entry' },
    ['<M-Home>'] = { vim.diagnostic.goto_prev, 'Jump to previous diagnostic entry' },
    ['<M-CR>'] = { vim.lsp.buf.code_action, 'Jump to previous diagnostic entry' },
  }

  mappings.register(normal_mappings, { buffer = bufnr, mode = 'n', noremap = true, silent = true })

  local icons = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    'ﰠ', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    'פּ', -- Struct
    '', -- Event
    '', -- Operator
    '', -- TypeParameter
  }

  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
  end

  if client.server_capabilities.documentHighlightProvider then
    local augroup_highlight = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_highlight })
    vim.api.nvim_create_autocmd('CursorHold', {
      group = augroup_highlight,
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = augroup_highlight,
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.server_capabilities.codeLensProvider or client.server_capabilities.code_lens then
    local augroup_code_lens = vim.api.nvim_create_augroup('lsp_document_code_lens', { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_code_lens })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = augroup_code_lens,
      buffer = 0,
      once = true,
      callback = vim.lsp.codelens.refresh,
    })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'CursorHold' }, {
      group = augroup_code_lens,
      buffer = 0,
      callback = vim.lsp.codelens.refresh,
    })
  end

  if client.server_capabilities.documentFormattingProvider then
    local augroup_format = vim.api.nvim_create_augroup('lsp_format', { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      callback = vim.lsp.buf.formatting_sync,
    })
  end
end

local function root_pattern_or_self(...)
  local f = root_pattern(...)
  return function(startpath)
    local dir = f(startpath)
    return dir or vim.loop.cwd()
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.codeLens = { dynamicRegistration = false }
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local path = require('mason-core.path')
local platform = require('mason-core.platform')

lsp_setup.setup({
  default_mappings = false,
  mappings = {},
  on_attach = on_attach,
  capabilities = capabilities,
  servers = {
    --[[ emmet_ls = {
      root_dir = root_pattern_or_self('package.json', '.git'),
      filetypes = { 'html', 'css', 'scss' },
      capabilities = capabilities,
    }, ]]
    eslint = {},
    html = {
      capabilities = capabilities,
      root_dir = root_pattern_or_self('package.json', '.git'),
    },
    jsonls = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
          end,
        },
      },
      settings = {
        json = {
          schemaDownload = { enable = true },
          schemas = {
            {
              description = 'JSON schema for Babel 6+ configuration files',
              fileMatch = { '.babelrc' },
              url = 'https://json.schemastore.org/babelrc.json',
            },
            {
              description = 'ESLint config',
              fileMatch = { '.eslintrc.json', '.eslintrc' },
              url = 'https://json.schemastore.org/eslintrc.json',
            },
            {
              description = 'Prettier config',
              fileMatch = {
                '.prettierrc',
                '.prettierrc.json',
                'prettier.config.json',
              },
              url = 'https://json.schemastore.org/prettierrc.json',
            },
            {
              description = 'Javascript compiler configuration file',
              fileMatch = { 'jsconfig.json', 'jsconfig.*.json' },
              url = 'https://json.schemastore.org/jsconfig.json',
            },
            {
              description = 'TypeScript compiler configuration file',
              fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
              url = 'https://json.schemastore.org/tsconfig.json',
            },
            {
              descrtiption = 'NPM package config',
              fileMatch = { 'package.json' },
              url = 'https://json.schemastore.org/package.json',
            },
            {
              description = 'A JSON schema for ASP.net launchsettings.json files',
              fileMatch = { 'launchsettings.json' },
              url = 'https://json.schemastore.org/launchsettings.json',
            },
            {
              description = 'VSCode snippets',
              fileMatch = { '**/snippets/*.json' },
              url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
            },
          },
        },
      },
    },
    lemminx = {},
    omnisharp = {},
    powershell_es = {},
    sumneko_lua = require('lua-dev').setup({
      library = {
        vimruntime = true,
        types = true,
        plugins = true,
      },
      runtime_path = true,
      lspconfig = {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          require('nvim-lsp-setup.utils').disable_formatting(client)
        end,
        settings = {
          Lua = {
            diagnostics = { globals = { 'use' } },
            workspace = { preloadFileSize = 350 },
            telemetry = { enable = false },
          },
        },
      },
    }),
    tsserver = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      lspconfig = {
        root_dir = root_pattern_or_self('.git'),
      },
    },
    volar = {},
    yamlls = {},
    marksman = {
      cmd = { path.concat({ path.bin_prefix(), 'marksman.cmd' }) },
    },
  },
})

-- Enable inline diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = '»',
    -- severity_limit = 'Warning',
    spacing = 4,
  },
  underline = true,
  signs = true,
  update_in_insert = false,
})

-- Add Border and max with to signature/hover
local pop_opts = { border = 'rounded', max_width = 80 }
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
