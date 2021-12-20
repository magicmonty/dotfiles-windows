local hascmp,cmp = pcall(require, 'cmp')
if not hascmp then return end

local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function (args)
      luasnip.lsp_expand(args.body)
    end,
  },

  experimental = {
    native_menu = false,
    ghost_text = false
  },

  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback) 
        if cmp.visible() then 
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, 
      {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback) 
        if cmp.visible then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, 
      {'i', 's'}),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'jira' },
    -- {
      -- name = 'buffer',
      -- opts = {
        -- keyword_length = 5,
        -- get_bufnrs = function()
          -- return vim.api.nvim_list_bufs()
        -- end
      -- }
   -- },
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "ﲳ",
        nvim_lua = "",
        treesitter = "",
        path = "ﱮ",
        buffer = "﬘",
        zsh = "",
        luasnip = "",
        spell = "暈",
        orgmode = '',
        jira = '',
      })[entry.source.name]

      return vim_item
    end
  }
})

local hasautopairs,autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if hasautopairs then
  cmp.event:on('confirm_done', autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

-- cmp.register_source("jira", require'magicmonty.cmp_jira'.new())
