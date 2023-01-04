if not _G.plugin_loaded('sidebar.nvim') then
  do return end
end

require('sidebar-nvim').setup {
  open = false,
  initial_width = 35,
  hide_statusline = true,
  sections = {'git', 'diagnostics', 'symbols', 'files', 'todos'},
  section_separator = {'', '-----', ''},
}
