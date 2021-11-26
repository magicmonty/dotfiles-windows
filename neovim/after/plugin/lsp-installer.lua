local status, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status then return end
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local on_init = function(client)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua require"telescope.builtin".lsp_code_actions()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

 -- automatic formatting on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup Format]]
    vim.cmd [[autocmd!]]
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.cmd [[augroup END]]
  end 

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
    '' -- TypeParameter
  }

  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
  end
end

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
local hascmp, cmp = pcall(require, "cmp_nvim_lsp")
if hascmp then
  capabilities = cmp.update_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits'
  }
}
capabilities.textDocument.codeAction = {
  dynamicRegistration = true,
}
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = on_init
  }

  if server.name == "rust_analyzer" then
    opts.settings = {
      ["rust-analyzer"] = {
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true }
      }
    }
  end

  if server.name == "sumneko_lua" then
    local luadev = require("lua-dev").setup({
      library = {
        vimruntime = true,
        types = true,
        plugins = true
      },
      lspconfig = {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = on_init
      },
      settings = {
        Lua = {
          diagnostics = { globals = { "use" } },
          workspace = { preloadFileSize = 350 },
          telemetry = { enable = false }
        }
      }
    })

    server:setup(luadev)
    return
  end

  if server.name == "emmet_ls" then
    opts.root_dir = function() 
      return vim.loop.cwd()
    end
    opts.filetypes = { "html", "css", "scss" }
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps.textDocument.completion.completionItem.snippetSupport = true
    opts.capabilites = caps
  end

  if server.name == "jsonls" then
    opts.commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, {0,0}, {vim.fn.line("$"), 0})
        end
      },
    }
    opts.settings = {
      json = {
        schemaDownload = { enable = true },
        schemas = {
          {
            description = "JSON schema for Babel 6+ configuration files",
            fileMatch = { ".babelrc" },
            url = "https://json.schemastore.org/babelrc.json"
          },
          {
            description = "ESLint config",
            fileMatch = { ".eslintrc.json", ".eslintrc" },
            url = "https://json.schemastore.org/eslintrc.json"
          },
          {
            description = "Prettier config",
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json"
            },
            url = "https://json.schemastore.org/prettierrc.json"
          },
          {
            description = "Javascript compiler configuration file",
            fileMatch = { "jsconfig.json", "jsconfig.*.json" },
            url = "https://json.schemastore.org/jsconfig.json"
          },
          {
            description = "TypeScript compiler configuration file",
            fileMatch = { "tsconfig.json", "tsconfig.*.json" },
            url = "https://json.schemastore.org/tsconfig.json"
          },
          {
            descrtiption = "NPM package config",
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json"
          },
          {
            description = "A JSON schema for ASP.net launchsettings.json files",
            fileMatch = { "launchsettings.json" },
            url = "https://json.schemastore.org/launchsettings.json"
          },
          {
            description = "VSCode snippets",
            fileMatch = { "**/snippets/*.json" },
            url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json"
          }
        }
      }
    }
  end

  server:setup(opts)
end)

require("nvim-web-devicons").setup {
  override = {
    zsh = { icon = "", color = "#428850", name = "Zsh" },
    lua = { icon = "", color = "#4E99DF", name = "Lua" },
    md = { icon = "", color = "#6BD02B", name = "Md" },
    MD = { icon = "", color = "#6BD02B", name = "MD" },
    [".gitignore"] = { icon = "", color = "#F14E32", name = "GitIgnore" },
  },
  default = true,
}

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      prefix = "»",
      severity_limit = 'Warning',
      spacing = 4
    },
    underline = true,
    signs = true,
    update_in_insert = false,
  }
)

local pop_opts = { border = "rounded", max_width = 80 }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
