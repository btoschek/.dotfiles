require('nvim-treesitter.configs').setup {
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
    'vimdoc',
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

vim.cmd [[
  highlight TreesitterContext guibg=dark
]]
