local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

-- Prepend lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- {{{ Get configs from seperate files
local function get_config(plug_name)
  return function()
    require('btoschek.plugins._' .. plug_name)
  end
end
-- }}}

local plugins = {

  -----------------------------------------------------------------------------
  -- Visuals
  -----------------------------------------------------------------------------

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = get_config('tokyonight'),
  },

  {
    'NTBBloodbath/galaxyline.nvim',
    lazy = false,
    config = get_config('galaxyline'),
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'akinsho/bufferline.nvim',
    config = get_config('bufferline'),
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'sidebar-nvim/sidebar.nvim',
    config = get_config('sidebar'),
  },

  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = get_config('dashboard'),
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'folke/todo-comments.nvim',
    config = get_config('todo-comments'),
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = get_config('nvim-treesitter'),
    dependencies = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
  },

  -- Statuscolumn
  require('btoschek.plugins.statuscol'),

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------

  {
    'neovim/nvim-lspconfig',
    config = get_config('lsp'),
  },

  {
    'williamboman/mason.nvim',
    config = get_config('mason'),
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
  },

  {
    'j-hui/fidget.nvim',
  },

  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },

  -- 'saecki/crates.nvim',                  -- Cargo.toml helper

  {
    'folke/neodev.nvim',
  },

  -- Formatting
  require('btoschek.plugins.conform'),

  -----------------------------------------------------------------------------
  -- Completion
  -----------------------------------------------------------------------------

  {
    'hrsh7th/nvim-cmp',
    config = get_config('nvim-cmp'),
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',                -- LSP completion
      'hrsh7th/cmp-nvim-lsp-signature-help', -- Highlight current parameter in function signature
      'hrsh7th/cmp-nvim-lua',                -- Neovim Lua API completion
      'hrsh7th/cmp-calc',                    -- Evaluate mathematical expressions
      'hrsh7th/cmp-buffer',                  -- Buffer-local words
      'hrsh7th/cmp-path',                    -- Directory completion
    },
  },

  -----------------------------------------------------------------------------
  -- Snippets & Commands
  -----------------------------------------------------------------------------

  {
    'L3MON4D3/LuaSnip',
    config = get_config('luasnip'),
    dependencies = {
      'L3MON4D3/cmp_luasnip', -- Snippet completion source for LuaSnip
    },
  },

  -----------------------------------------------------------------------------
  -- Git
  -----------------------------------------------------------------------------

  {
    'lewis6991/gitsigns.nvim',
    config = get_config('git'),
  },

  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },



  -- Use the terminal inside nvim
  {
    'akinsho/toggleterm.nvim',
    config = get_config('toggleterm'),
  },

  {
    'nvim-telescope/telescope.nvim',
    config = get_config('telescope'),
    dependencies = {
      'nvim-lua/plenary.nvim',
      'dhruvmanila/telescope-bookmarks.nvim',
      'kkharji/sqlite.lua',
    },
    keys = {
      { '<Leader>fb', '<CMD>Telescope buffers<CR>',    desc = 'Manage buffers', silent = true },
      { '<Leader>fd' },
      { '<Leader>ff', '<CMD>Telescope find_files<CR>', desc = 'Find file',      silent = true },
      { '<Leader>fh', '<CMD>Telescope help_tags<CR>',  desc = 'Find help tag',  silent = true },
    },
  },

  {
    'anuvyklack/pretty-fold.nvim',
    config = get_config('pretty-fold'),
  },

  -- Conceal and environment recognition for LaTeX
  -- (currently mostly used for implementing snippets)
  {
    'lervag/vimtex',
    config = get_config('vimtex'),
  },

  -- Browse & edit directories like buffers
  {
    'stevearc/oil.nvim',
    config = get_config('oil'),
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
}

-----------------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------------

-- Initialize lazy
require('lazy').setup(
  plugins,
  {
    lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',
  }
)
