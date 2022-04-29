local function on_attach(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings.
  local leader_mappings = {
    l = {
      name = 'LSP',
      a = { vim.lsp.buf.code_action, 'Show available code actions' },
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

  local wk = require('which-key')
  wk.register(leader_mappings, { prefix = '<leader>', buffer = bufnr, mode = 'n', noremap = true, silent = true })

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
  }

  wk.register(normal_mappings, { buffer = bufnr, mode = 'n', noremap = true, silent = true })

  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<M-End>', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<S-M-Right>', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<M-Home>', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<S-M-Left>', vim.diagnostic.goto_prev, opts)

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

  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_document_highlight
        au! * <buffer>
        au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd([[
      augroup lsp_document_code_lens
        au! * <buffer>
        au BufEnter ++once lua vim.lsp.codelens.refresh()
        au BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]])
  end
end

require('nvim-lsp-setup').setup({
  default_mappings = false,
  mappings = {},
  on_attach = on_attach,
  servers = {
    emmet_ls = {
      root_dir = function()
        return vim.loop.cwd()
      end,
      filetypes = { 'html', 'css', 'scss' },
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.resolved_capabilities.textDocument.completion.completionItem.snippetSupport = true
      end,
    },
    eslint = {},
    html = {},
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
    remark_ls = {},
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
        on_attach(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end,
    },
    volar = {},
    yamlls = {},
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

-- Nicer Icons in LspInstallInfo
require('nvim-lsp-installer').settings({
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})
