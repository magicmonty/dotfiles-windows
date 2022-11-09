local installed, lsp_config = pcall(require, 'mason-lspconfig')
if not installed then
  return
end

local installed, neodev = pcall(require, 'neodev')
if installed then
  neodev.setup({})
end

local root_pattern = require('lspconfig.util').root_pattern
local mappings = require('magicmonty.mappings')

local function has_filetype(filetypes, ft)
  for _, value in ipairs(filetypes) do
    if value == ft then
      return true
    end
  end

  return false
end

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

lsp_config.setup({
  ensure_installed = {
    'eslint',
    'html',
    'jsonls',
    'sumneko_lua',
    'marksman',
    'texlab',
    'tsserver',
    'tailwindcss',
  },
})

local function on_attach(client, bufnr)
  local hinstalled, inlayhints = pcall(require, 'lsp-inlayhints')
  if hinstalled then
    inlayhints.on_attach(client, bufnr)
  end

  local sinstalled, signature = pcall(require, 'lsp_signature')
  if sinstalled then
    signature.on_attach({
      bind = true,
      handler_opts = {
        border = 'rounded',
      },
    }, bufnr)
  end

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

  local augroup_format = vim.api.nvim_create_augroup('lsp_format', { clear = true })
  vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
  local ft = client.config.filetypes
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      group = augroup_format,
      callback = function()
        vim.lsp.buf.format()
      end,
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local path = require('mason-core.path')
local platform = require('mason-core.platform')

require('lsp-setup').setup({
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
    eslint = {
      root_dir = root_pattern_or_self('.eslintrc', '.eslintrc.json', 'package.json', '.git'),
      settings = {
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = 'separateLine',
          },
          showDocumentation = {
            enable = true,
          },
        },
        codeActionOnSave = {
          enable = true,
          mode = 'all',
        },
        format = true,
        onIgnoredFiles = 'off',
        packageManager = 'yarn',
        quiet = false,
        run = 'onType',
        useESLintClass = false,
        validate = 'probe',
        workingDirectory = {
          mode = 'auto',
        },
      },
    },
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
    sumneko_lua = {
      runtime_path = false,
      lspconfig = {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            format = { enable = true },
            diagnostics = { globals = { 'use' } },
            workspace = {
              preloadFileSize = 350,
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
    },
    texlab = {
      settings = {
        texlab = {
          build = {
            onSave = true,
            forwardSearchAfter = false,
          },
          chktex = {
            openAndSave = true,
            onEdit = true,
          },
        },
      },
    },
    tsserver = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
      root_dir = root_pattern_or_self('tsconfig.json', 'tsconfig.base.json', 'package.json', '.git'),
      -- root_dir = root_pattern_or_self('.git'),
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayVariableTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayVariableTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    tailwindcss = {},
    volar = {},
    yamlls = {},
    marksman = {
      cmd = { path.concat({ path.bin_prefix(), 'marksman.cmd' }) },
    },
  },
})

-- Enable inline diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --[[ virtual_text = {
    prefix = '»',
    spacing = 4,
  }, ]]
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
})

-- Add Border and max with to signature/hover
local pop_opts = { border = 'rounded', max_width = 80 }
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
