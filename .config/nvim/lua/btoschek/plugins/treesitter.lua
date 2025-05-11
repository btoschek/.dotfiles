return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')

    configs.setup {
      ensure_installed = {
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
        'nix',
        'python',
        'regex',
        'rust',
        'scss',
        'sql',
        'toml',
        'typst',
        'vim',
        'vimdoc',
        'yaml',
        'yuck',
      },
      -- Don't install parsers set in 'ensure_installed' synchronously
      sync_install = false,
      auto_install = true,
      ignore_install = {},
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
  end,
}
