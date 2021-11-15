local haslspkind,lspkind = pcall(require, 'lspkind')
if not haslspkind then return end

lspkind.init({
  -- enable text annotations
  with_text = true,

  -- Use nerd fonts for icons
  preset = 'default',

  -- set symbols
  symbol_map = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = '',
    Interface = 'ﰮ',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '﬌',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = ''
  }
})