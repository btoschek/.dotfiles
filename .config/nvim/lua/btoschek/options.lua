local cmd = vim.cmd
local opt = vim.opt

cmd 'filetype indent plugin on'
cmd 'set inccommand=split'

opt.shortmess:append 'c'                  -- Avoid showing extra messages on completion

opt.backup = false                        -- Disable backup files
opt.clipboard = 'unnamedplus'             -- Allow Neovim to access system clipboard
opt.cmdheight = 2                         -- More space in Neovim command line
opt.completeopt = {'menuone', 'noinsert', 'noselect'}
opt.fileencoding = 'utf-8'                -- Encoding written to files
opt.fileformat = 'unix'                     -- Use \n for line endings
opt.foldmethod = 'marker'
opt.guifont = 'Hack NF:h12'               -- Font used in graphical Neovim (under Windows)
opt.hidden = true                         -- When buffer goes out of sight, don't delete it
opt.ignorecase = true                     -- Ignore case in search patterns
opt.list = true
opt.listchars = { tab = ' ', trail = '·' }
opt.mouse = 'a'                           -- Allow mouse usage
opt.pumheight = 10                        -- Pop up menu height
opt.ruler = false                         -- Hide current cursor row and column from builtin statusbar
opt.scrolloff = 4                         -- How many lines to keep when scrolling
opt.showcmd = false                       -- Hide keystrokes from builtin statusbar
opt.showmode = false                      -- Don't show mode ('-- INSERT --')
opt.showtabline = 2                       -- Always show tabs
opt.sidescrolloff = 8                     -- Horizontal scrolloff
opt.smartcase = true
opt.smartindent = true                    -- Smarter indentation
opt.splitbelow = true                     -- Split below, not above
opt.splitright = true                     -- Split to the right, not left
opt.swapfile = false                      -- Don't create swapfiles
opt.termguicolors = true                  -- Needed for themes to show correctly
opt.timeoutlen = 500                      -- Set time after which Neovim interpretes keystrokes
opt.undodir = vim.fn.stdpath('cache') .. '/undo'       -- Set not-project-based undo directory
opt.undofile = true                       -- Persistent undo
opt.updatetime = 300                      -- Faster completion
opt.writebackup = false
opt.expandtab = true                      -- Convert tabs to spaces
opt.shiftwidth = 2                        -- Use indentation of x spaces
opt.tabstop = 2                           -- Convert tab to x spaces
opt.number = true                         -- Show absolute line numbers
opt.relativenumber = true                 -- Show relative line numbers
opt.numberwidth = 4
opt.signcolumn = 'yes'                    -- Always show sign column
opt.wildmenu = true
opt.wildmode = { list = 'full', 'full' }
opt.wrap = false                          -- Set visual line wrapping
