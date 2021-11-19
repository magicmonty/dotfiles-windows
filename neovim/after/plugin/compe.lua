local hascmp,cmp = pcall(require, 'cmp')
if not hascmp then return end

local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function (args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  experimental = {
    native_menu = false,
    ghost_text = true
  },

  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  mapping = {
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Right>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'vsnip' },
    { name = 'path' },
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
        vsnip = "",
        spell = "暈",
        orgmode = ''
      })[entry.source.name]

      return vim_item
    end
  }
})

local hasautopairs,autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if hasautopairs then
  cmp.event:on('confirm_done', autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

