-- {{{ LSP Imports
local snip = require('luasnip')

local c    = snip.c
local i    = snip.i
local s    = snip.s
local t    = snip.t

local d    = snip.dynamic_node
local f    = snip.function_node
local sn   = snip.snippet_node

local fmt  = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep  = require('luasnip.extras').rep
-- }}}

-- {{{ Streamline the process of creating snippet infos
local text = function(trigger, name, description)
  return {
    trig        = trigger,
    name        = name,
    dscr        = description,
    regTrig     = false,
    wordTrig    = true,
    snippetType = 'snippet',
  }
end
local autotext = function(trigger, name, description)
  return {
    trig        = trigger,
    name        = name,
    dscr        = description,
    regTrig     = false,
    wordTrig    = true,
    snippetType = 'autosnippet',
  }
end
local regex = function(trigger, name, description)
  return {
    trig        = trigger,
    name        = name,
    dscr        = description,
    regTrig     = true,
    wordTrig    = false,
    snippetType = 'snippet',
  }
end
local autoreg = function(trigger, name, description)
  return {
    trig        = trigger,
    name        = name,
    dscr        = description,
    regTrig     = true,
    wordTrig    = false,
    snippetType = 'autosnippet',
  }
end
-- }}}

-- {{{ Conditions
local cond = {}

--- Math context detection
cond.in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

cond.in_text = function()
  return not cond.in_mathzone()
end

--- Comment detection
cond.in_comment = function()
  return vim.fn['vimtex#syntax#in_comment']() == 1
end

--- Generic environment detection
cond.in_env = function(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- }}}

--- Create a consistently formatted label
local function labelize(args)
  local text = args[1][1]
  return text:gsub('%W+', '_'):lower()
end

local function rec_ls()
  return sn(
    nil,
    c(1, {
      t(''),
      sn(nil, { t({ '', '\t\\item ' }), i(1), d(2, rec_ls, {}) }),
    })
  )
end

return {

  -- Greek letters

  s({trig = ';a', snippetType = 'autosnippet'},
  { t('\\alpha'), }),

  s({trig = ';A', snippetType = 'autosnippet'},
  { t('\\Alpha'), }),

  s({trig = ';b', snippetType = 'autosnippet'},
  { t('\\beta'), }),

  s({trig = ';B', snippetType = 'autosnippet'},
  { t('\\Beta'), }),

  s({trig = ';g', snippetType = 'autosnippet'},
  { t('\\gamma'), }),

  s({trig = ';G', snippetType = 'autosnippet'},
  { t('\\Gamma'), }),

  s({trig = ';d', snippetType = 'autosnippet'},
  { t('\\delta'), }),

  s({trig = ';D', snippetType = 'autosnippet'},
  { t('\\Delta'), }),

  -- Other stuff TODO: Sort

  s(autotext('ff', 'Fraction', 'Create a fraction'),
    fmta("\\frac{<>}{<>}", { i(1), i(2) }),
    { condition = cond.in_mathzone }
  ),

  -- Environments

  s(text('beg', 'Begin', 'Create a new environment'),
    fmta([[
      \begin{<>}
        <>
      \end{<>}
    ]], { i(1), i(0), rep(1) })),

  s(text('...', 'ldots', 'Better version of ...'),
    fmt([[
      \ldots
    ]], {})),

  s(text('table', 'Table environment', nil),
    fmta([[
      \begin{table}[<>]
        \centering
        \begin{tabular}[|<>|]
          <>
        \end{tabular}
        \caption{<>}
        \label{tab:<>}
      \end{table}
    ]], {
      c(1, {t'H',t'h',t't',t'p',t'b'}),
      c(2, {t'c',t'l',t'r'}),
      i(3),
      i(4, 'caption'),
      i(5, 'label')
    })),

  s(text('fig', 'Figure environment', nil),
    fmta([[
      \begin{figure}[<>]
        \centering
        \includegraphics[width=0.8\textwidth]{<>}
        \caption{<>}
        \label{fig:<>}
      \end{figure}
    ]], {
      c(1, {t'H',t'h',t't',t'p',t'b'}),
      i(2, 'image path'),
      i(3, 'caption'),
      i(4, 'label')
    })),

  s(text('enum', 'Enumerate', nil),
    fmta([[
      \begin{enumerate}
        <>
      \end{enumerate}
    ]], { i(1) })),

  s(text('item', 'Itemize', 'Create a listing with multiple items'),
    fmta([[
      \begin{itemize}
        \item <>
      \end{itemize}
    ]], { i(1) })),

  s(text('pac', 'Package', 'Include an external package'),
    fmta([[
      \usepackage[<>]{<>}
    ]], { i(1, 'options'), i(2, 'package') })),

  s(text('br', 'left( right)', 'Create math compatible braces'),
    fmt([[
      \left( {} \right)
    ]], {
      i(1)
    })),

  s(autotext('sq', 'sqrt{}', 'Square-root'),
    fmta("\\sqrt{<>}", { i(1) }),
    { condition = cond.in_mathzone }),








  s(text('sec', 'Section', 'Section including label'),
    fmta([[
      \section{<>}
      \label{sec:<>}

      <>
    ]], { i(1, 'name'), f(labelize, 1), i(0) })),

  s(text('sub', 'Subsection', 'Subsection including label'),
    fmta([[
      \subsection{<>}
      \label{ssec:<>}

      <>
    ]], { i(1, 'name'), f(labelize, 1), i(0) })),

  s(text('ssub', 'Subsection', 'Subsection including label'),
    fmta([[
      \subsubsection{<>}
      \label{sssec:<>}

      <>
    ]], { i(1, 'name'), f(labelize, 1), i(0) })),

  s(text('cit', 'Citation', 'Reference a bibliography entry'),
    fmt([[
      ~\cite{{{}}}
    ]], { i(1, 'entry') })),
}
