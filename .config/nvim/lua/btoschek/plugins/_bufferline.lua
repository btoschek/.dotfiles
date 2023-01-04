if not _G.plugin_loaded('bufferline.nvim') then
  do return end
end

require('bufferline').setup {}
