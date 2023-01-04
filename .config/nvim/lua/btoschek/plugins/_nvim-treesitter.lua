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
  },
  playground = {
    enable = true,
    disable = {},
  },
}
