local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.tsx = { "javascript", "typescript.tsx" }

local M = {}

local opts = {
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = { 'yaml' }
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      icit_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  matchup = { enable = true },
  rainbow = {
    disable = { 'html' },
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters
    max_file_lines = 1000,
  },
  autopairs = { enable = true },
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    config = {
      typescript = '// %s',
      css = '/* %s */',
      scss = '/* %s */',
      html = '<!-- %s -->',
      vue = '<!-- %s -->',
      json = '',
    },
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    -- @TODOUA: these selectors may or may not helpful workflow
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  ensure_installed = {
    "c_sharp",
    "comment",
    "css",
    "dockerfile",
    "html",
    "http",
    "javascript",
    "json",
    "json5",
    "jsonc",
    "lua",
    "markdown",
    "regex",
    "scss",
    "todotxt",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml"
  }
}

M.setup = function()
  ---- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  local status, treesitter = pcall(require, 'nvim-treesitter.configs')
  if not status then
    return
  end

  treesitter.setup(opts) 

  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 99
  vim.opt.fillchars = "fold:-"
  vim.wo.foldmethod = "expr"
  vim.o.foldtext = [['--- ' . substitute(getline(v:foldstart),'\\t',repeat(' ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines) ']]
end

return M
