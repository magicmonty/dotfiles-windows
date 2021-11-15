-- vim: foldlevel=99:
local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then return end

local augroup = require("vim_ext").augroup

local protocol = require'vim.lsp.protocol'

local hascmp, cmp = pcall(require, 'cmp_nvim_lsp')
local capabilites = vim.lsp.protocol.make_client_capabilities()
if hascmp then
  capabilites = cmp.update_capabilities(capabilites)
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
  if client.resolved_capabilities.document_formatting then
    augroup("Format", { { "BufWritePre", "<buffer>", "lua vim.lsp.buf.formatting_seq_sync()" } }, true)
  end

  local status, completion = pcall(require, 'completion')
  if status then
    completion.on_attach(client, bufnr)
  end

  protocol.CompletionItemKind = {
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
end

nvim_lsp.rust_analyzer.setup {
  capabilites = capabilites,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true }
    }
  }
}

nvim_lsp.tsserver.setup {
  capabilites = capabilites,
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}

local sumneko_root_path = 'C:/Projects/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Windows/lua-language-server.exe"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "use" }
      },
      workspace = {
        preloadFileSize = 350
      }
    }
  }
})

nvim_lsp.sumneko_lua.setup(luadev)

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

