if not _G.plugin_loaded('todo-comments.nvim') then
  do return end
end

require('todo-comments').setup {}
