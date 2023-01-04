local ensure_packer = function ()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local bootstrap_config = ensure_packer()

local packer = require('packer')
local util = require('packer.util')

-- Declare plugins use in the config
local function plugins(use)

  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }

  -----------------------------------------------------------------------------
   -- Shared requirements
  -----------------------------------------------------------------------------

  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-lua/plenary.nvim' }

  -----------------------------------------------------------------------------
   -- Visuals
  -----------------------------------------------------------------------------

  -- Colorscheme
  use { 'ghifarit53/tokyonight-vim' }

  -- Statusline
  use { 'NTBBloodbath/galaxyline.nvim', branch = 'main' }

  -- Bufferline
  use { 'akinsho/bufferline.nvim' }

  use { 'sidebar-nvim/sidebar.nvim' }

  use { 'glepnir/dashboard-nvim' }

  -- List all TODOs in a file / project
  use { 'folke/todo-comments.nvim' }

  -- Highlight color codes with their respective colors
  use { 'norcalli/nvim-colorizer.lua' }

  -- Better syntax highlighting for various formats
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/playground' }

  -----------------------------------------------------------------------------
   -- LSP
  -----------------------------------------------------------------------------

  -- LSP package manager
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }

  -- Easier LSP setup
  use { 'neovim/nvim-lspconfig' }
  use { 'j-hui/fidget.nvim' }

  use { 'simrat39/rust-tools.nvim' }
    -- 'saecki/crates.nvim',                  -- Cargo.toml helper

  -----------------------------------------------------------------------------
   -- Completion
  -----------------------------------------------------------------------------

  use { 'hrsh7th/nvim-cmp' }

  use { 'hrsh7th/cmp-nvim-lsp' }                -- LSP completion
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' } -- Highlight current parameter in function signature
  use { 'hrsh7th/cmp-nvim-lua' }                -- Neovim Lua API completion
  use { 'hrsh7th/cmp-calc' }                    -- Evaluate mathematical expressions
  use { 'hrsh7th/cmp-buffer' }                  -- Buffer-local words
  use { 'hrsh7th/cmp-path' }                    -- Directory completion

  -----------------------------------------------------------------------------
   -- Snippets
  -----------------------------------------------------------------------------

  use { 'L3MON4D3/LuaSnip' }
  use { 'L3MON4D3/cmp_luasnip' }               -- Snippet completion source for LuaSnip

  -----------------------------------------------------------------------------
   -- Git
  -----------------------------------------------------------------------------

  use { 'lewis6991/gitsigns.nvim' }
  use { 'pwntester/octo.nvim' }


  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
  use { 'anuvyklack/pretty-fold.nvim' }


  -- Automatically set up the configuration after cloning packer.nvim
  -- Source: https://github.com/wbthomason/packer.nvim#bootstrapping
  if bootstrap_config then
    packer.sync()
  end
end

local compile_path = util.join_paths(
  vim.fn.stdpath('config'), 'generated', 'packer_compiled.lua'
)

packer.startup {
  plugins,
  config = {
    compile_path = compile_path,
    display = {
      open_fn = function()
        return require('packer.util').float{ border = 'single' }
      end,
    },
    enable = true,                   -- Enable profiling via :PackerCompile profile=true
    git = { clone_timeout = 300 },
    threshold = 0,                   -- Amount of ms plugin load time must be over to be included in profile
  },
}

if bootstrap_config then
  -- TODO: Run packer compile here
end

-- Source custom compiled config
vim.cmd('source ' .. compile_path)

function _G.plugin_loaded(plugin_name)
  local p = _G.packer_plugins
  return p ~= nil and p[plugin_name] ~= nil and p[plugin_name].loaded
end

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. ']' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

vim.keymap.set('n', '<F1>', function()
  vim.api.nvim_buf_set_lines(0, -1, -1, false, {
    'Plugins:',
    dump(_G.packer_plugins)
  })
end)
