local cmd = vim.cmd
local opt = vim.opt

cmd 'filetype indent plugin on'                        -- Enable filetype-specific settings
cmd 'set inccommand=split'                             -- Show rows affected by substitute command in seperate split

opt.shortmess:append 'c'                               -- Avoid showing extra messages on completion

opt.backup = false                                     -- Disable backup files
opt.clipboard = 'unnamedplus'                          -- Allow Neovim to access system clipboard
opt.cmdheight = 2                                      -- More space in Neovim command line
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Don't select entries in completion menu by default
opt.fileencoding = 'utf-8'                             -- Encoding written to files
opt.fileformat = 'unix'                                -- Use \n for line endings
opt.foldmethod = 'marker'                              -- TODO: Assess usage of treesitter here
opt.guifont = 'Hack NF:h12'                            -- Font used in graphical Neovim (under Windows)
opt.hidden = true                                      -- When buffer goes out of sight, don't delete it
opt.ignorecase = true                                  -- Ignore case in search patterns
opt.list = true                                        -- Modify the look of some common special characters
opt.listchars = { tab = ' ', trail = '·' }            -- Highlight usage of tabs with arrows & hint at trailing whitespace
opt.mouse = 'a'                                        -- Allow mouse usage
opt.pumheight = 10                                     -- Popup menu height
opt.ruler = false                                      -- Hide current cursor row and column from builtin statusbar
opt.scrolloff = 4                                      -- How many lines to keep when scrolling
opt.showcmd = false                                    -- Hide keystrokes from builtin statusbar
opt.showmode = false                                   -- Don't show mode ('-- INSERT --')
opt.showtabline = 2                                    -- Always show tabs
opt.sidescrolloff = 8                                  -- Horizontal scrolloff
opt.smartcase = true                                   -- Case-insensitive search when string doesn't start with uppercase character
opt.smartindent = true                                 -- Smarter indentation
opt.splitbelow = true                                  -- Split below, not above
opt.splitright = true                                  -- Split to the right, not left
opt.swapfile = false                                   -- Don't create swapfiles
opt.termguicolors = true                               -- Needed for themes to show correctly
opt.timeoutlen = 500                                   -- Set time after which Neovim interpretes keystrokes
opt.undodir = vim.fn.stdpath('cache') .. '/undo'       -- Set not-project-based undo directory
opt.undofile = true                                    -- Persistent undo
opt.updatetime = 300                                   -- Faster completion
opt.writebackup = false                                -- Don't create backup files during save
opt.expandtab = true                                   -- Convert tabs to spaces
opt.shiftwidth = 2                                     -- Use indentation of x spaces
opt.tabstop = 2                                        -- Convert tab to x spaces
opt.number = true                                      -- Show absolute line numbers
opt.relativenumber = true                              -- Show relative line numbers
opt.numberwidth = 4                                    -- Remove jitter for 3-wide line numbers
opt.signcolumn = 'yes'                                 -- Always show sign column
opt.wildmenu = true                                    -- Show completions for editor commands when available
opt.wildmode = { list = 'full', 'full' }               -- Show full list of completions (editor commands)
opt.wrap = false                                       -- Set visual line wrapping
