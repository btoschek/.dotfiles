if not _G.plugin_loaded('nvim-treesitter') then
  do return end
end

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'arduino',
    'bash',
    'bibtex',
    'c',
    'css',
    'fish',
    'html',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    'markdown',
    'python',
    'regex',
    'rust',
    'scss',
    'toml',
    'vim',
    'yaml',
  },
  highlight = {
    enable = true,
    disable = {},
    -- Band-aid solution to have treesitter highlights under LaTeX with vimtex
    additional_vim_regex_highlighting = { 'latex' },
  },
  playground = {
    enable = true,
    disable = {},
  },
}
