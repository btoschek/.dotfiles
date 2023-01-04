if not _G.plugin_loaded('pretty-fold.nvim') then
  do return end
end

-- TODO: Cap text to standardized amount, show text with even boxes
require('pretty-fold').setup {
  keep_indentation = false,
  fill_char = '━',
  sections = {
    left = {
      '━━━┫ ', 'content', '┣'
    },
    right = {
      '┫ ', 'number_of_folded_lines', ':', 'percentage', ' ┣━'
    },
  },
}
