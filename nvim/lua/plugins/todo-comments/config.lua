local installed, todo = pcall(require, 'todo-comments')
if not installed then
  return
end

todo.setup({})
