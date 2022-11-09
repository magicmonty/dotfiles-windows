local M = {}

M.setup = function()
  require('orgmode').setup({
    org_agenda_files = { '~/OneDrive - BAYOONET Service GmbH & Co. KG/Documents/org/*.org' },
    org_default_notes_file = '~/OneDrive - BAYOONET Service GmbH & Co. KG/Documents/org/refile.org',
    org_hide_leading_stars = true,
    org_hide_emphasis_markers = true,
    mappings = {
      prefix = "<localleader>o",
    }
  })
end

return M
