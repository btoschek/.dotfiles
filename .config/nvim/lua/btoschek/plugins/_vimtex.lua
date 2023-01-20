if not _G.plugin_loaded('vimtex') then
  do return end
end

vim.g.tex_flavor = 'latex'
vim.g.tex_conceal = 'abdmg'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
