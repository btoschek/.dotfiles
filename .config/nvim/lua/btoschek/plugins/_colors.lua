if not _G.plugin_loaded('tokyonight-vim') then
  do return end
end

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_enable_italic = '1'
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

vim.cmd [[
  colorscheme tokyonight
  highlight clear SignColumn
]]
