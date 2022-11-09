local has_project, project = pcall(require, 'project_nvim')
if not has_project then
  return
end

project.setup({
  patterns = { '.git', 'Makefile', 'package.json', '*.sln', 'README.md' },
  exclude_dirs = { '**/node-modules/**/*' },
})

require('telescope').load_extension('projects')
