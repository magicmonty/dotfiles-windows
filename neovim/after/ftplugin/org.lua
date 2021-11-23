local status,orgmode = pcall(require, 'orgmode')
if not status then return end

orgmode.setup({
  org_agenda_files = { '~/org/**/*' },
  org_default_notes_files = '~/org/index.org'
})

local hascmp, cmp = pcall(require, "cmp")
if hascmp then 
  cmp.setup.buffer {
    sources = {
      { name = 'orgmode' },
      { name = 'treesitter' },
      { name = 'luasnip' },
      { name = 'path' }
    }
  }
end

