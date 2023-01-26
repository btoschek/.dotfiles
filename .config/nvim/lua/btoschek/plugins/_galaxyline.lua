-- {{{ Colors
local colors = {
  bg_dark        = '#1f2335',
  bg             = '#1a1b26',
  bg_highlight   = '#292e42',
  terminal_black = '#414868',
  fg             = '#c0caf5',
  fg_dark        = '#a9b1d6',
  fg_gutter      = '#3b4261',
  dark3          = '#545c7e',
  comment        = '#565f89',
  dark5          = '#737aa2',
  blue0          = '#3d59a1',
  blue           = '#7aa2f7',
  cyan           = '#7dcfff',
  blue1          = '#2ac3de',
  blue2          = '#0db9d7',
  blue5          = '#89ddff',
  blue6          = '#b4f9f8',
  blue7          = '#394b70',
  magenta        = '#bb9af7',
  magenta2       = '#ff007c',
  purple         = '#9d7cd8',
  orange         = '#ff9e64',
  yellow         = '#e0af68',
  green          = '#9ece6a',
  green1         = '#73daca',
  green2         = '#41a6b5',
  teal           = '#1abc9c',
  red            = '#f7768e',
  red1           = '#db4b4b',
  replace        = '#e06c75',

  bg_git         = '#304b2e',
  bg_lsp         = '#364463',
  bg_fileinfo    = '#5c2c2e',
}
-- }}}

-- {{{ Function providers
local function color_current_mode()
  local mode = vim.fn.mode() or vim.fn.visualmode()
  local mode_colors = {
    n      = colors.blue,
    i      = colors.green,
    v      = colors.purple,
    V      = colors.purple,
    [''] = colors.purple,
    c      = colors.magenta,
    no     = colors.blue,
    s      = colors.orange,
    S      = colors.orange,
    [''] = colors.orange,
    ic     = colors.yellow,
    R      = colors.red,
    Rv     = colors.red,
    cv     = colors.blue,
    ce     = colors.blue,
    r      = colors.replace,
    rm     = colors.replace,
    ['r?'] = colors.cyan,
    ['!']  = colors.blue,
    t      = colors.blue,
  }
  return mode_colors[mode]
end

local function active_lsp()
  return require('galaxyline.providers.lsp').get_lsp_client(' ') .. ' '
end

local function cursor_pos()
  local line   = vim.fn.line('.')
  local column = vim.fn.col('.')
  return string.format('%3d:%2d', line, column)
end

local function git_branch()
  if vim.bo.filetype == 'dashboard' then
    return ''
  else
    return require('galaxyline.providers.vcs').get_git_branch() .. ' '
  end
end

local function mode_color()
  local color = color_current_mode()
  local complementary = colors.bg
  vim.api.nvim_command('hi GalaxyModeColorText guibg=' .. color .. ' guifg=' .. complementary)
  vim.api.nvim_command('hi GalaxyModeColorSeparator guifg=' .. color .. ' guibg=' .. complementary)
  return ' '
end

local function file_icon()
  return require('galaxyline.providers.fileinfo').get_file_icon():sub(1, -2)
end
-- }}}

-- {{{ Abstractions
local function add_entries(section, namespace, data)
  for index, entry in ipairs(data) do
    table.insert(section, {[namespace .. index] = entry})
  end
end

local function left(namespace, data)
  add_entries( require('galaxyline').section.left, namespace, data )
end

local function right(namespace, data)
  add_entries( require('galaxyline').section.right, namespace, data )
end
-- }}}

-- {{{ Conditions
local function condition_common()
  local excluded = {[''] = true, ['NvimTree'] = true}
  if excluded[vim.bo.filetype] then return false end
  return true
end

local function condition_lsp()
  return active_lsp() ~= '  '
end
-- }}}

-- {{{ Info panel
--- Create a bubble-shaped info panel to hold specific information
---
--- info = {
---   highlight (table),
---   symbol (func),
---   content (table),
---   condition (func)
--- }
local function info_panel(info)

  local hl = info.highlight
  local bubble_config = {
    {
      provider  = function() return '' end,
      highlight = { hl.icon, hl.bg_bar },
      condition = info.condition,
    },
    {
      provider  = function() return info.icon end,
      highlight = { hl.bg_bar, hl.icon },
      condition = info.condition,
    },
    {
      provider  = function() return ' ' end,
      highlight = { hl.icon, hl.bg_panel },
      condition = info.condition,
    },
  }

  for _, prov in ipairs(info.content) do
    table.insert(bubble_config,
      {
        provider  = prov.provider,
        icon      = prov.icon,
        highlight = { prov.color, hl.bg_panel },
        condition = info.condition,
      }
    )
  end

  table.insert(bubble_config,
    {
      provider  = function() return '' end,
      highlight = { hl.bg_panel, hl.bg_bar },
      condition = info.condition,
    }
  )

  return bubble_config
end
-- }}}

--[[----------------------------------------------------------
                      Bar Configuration
------------------------------------------------------------]]

left('mode',
  {{
    provider  = mode_color,
    icon      = '  ',
    separator = ' ',
    highlight = 'GalaxyModeColorText',
    separator_highlight = 'GalaxyModeColorSeparator',
    condition = condition_common,
  }}
)

left('git',
  info_panel {
    highlight = {
      icon       = colors.green,
      text       = colors.fg,
      bg_bar     = colors.bg,
      bg_panel   = colors.bg_git,
    },
    icon    = 'ﯙ',
    content = {
      { provider = git_branch,     icon = ' שׂ ', color = colors.green,  },
      { provider = 'DiffAdd',      icon = '  ', color = colors.green,  },
      { provider = 'DiffModified', icon = ' 柳', color = colors.yellow, },
      { provider = 'DiffRemove',   icon = '  ', color = colors.red,    },
    },
    condition = require('galaxyline.condition').check_git_workspace,
  }
)

left('space',
  {{
    provider  = function() return ' ' end,
    highlight = { colors.green, colors.bg },
    condition = require('galaxyline.condition').check_git_workspace,
  }}
)

left('lsp',
  info_panel {
    highlight = {
      icon        = colors.blue,
      text        = colors.fg,
      bg_bar      = colors.bg,
      bg_panel    = colors.bg_lsp,
    },
    icon    = '',
    content = {
      { provider  = active_lsp,                                             },
      { provider  = 'DiagnosticError', icon = '  ', color = colors.red,    },
      { provider  = 'DiagnosticWarn',  icon = '  ', color = colors.yellow, },
      { provider  = 'DiagnosticHint',  icon = '  ', color = colors.cyan,   },
      { provider  = 'DiagnosticInfo',  icon = '  ', color = colors.blue,   },
    },
    condition = condition_lsp,
  }
)

-- TODO: Search for reason dynamic function provider below won't work
right('file_info',
  info_panel {
    highlight = {
      icon     = colors.orange,
      text     = colors.fg,
      bg_bar   = colors.bg,
      bg_panel = colors.bg_fileinfo,
    },
    icon    = 'l',--{ provider = file_icon, icon = '', highlight = {}},
    content   = {
      { provider = cursor_pos, }
    },
    condition = condition_common,
  }
)
