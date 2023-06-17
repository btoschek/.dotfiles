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

  -- {{{ Greek letters

  s(autotext(';a', 'alpha', 'Greek alpha'),
    t('\\alpha'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';A', 'Alpha', 'Greek Alpha'),
    t('\\Alpha'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';b', 'beta', 'Greek beta'),
    t('\\beta'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';B', 'Beta', 'Greek Beta'),
    t('\\Beta'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';g', 'gamma', 'Greek gamma'),
    t('\\gamma'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';G', 'Gamma', 'Greek Gamma'),
    t('\\Gamma'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';d', 'delta', 'Greek delta'),
    t('\\delta'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';D', 'Delta', 'Greek Delta'),
    t('\\Delta'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';e', 'epsilon', 'Greek epsilon'),
    t('\\epsilon'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';E', 'Epsilon', 'Greek Epsilon'),
    t('\\Epsilon'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';z', 'zeta', 'Greek zeta'),
    t('\\zeta'),
    { condition = cond.in_mathzone }
  ),

  s(autotext(';Z', 'Zeta', 'Greek Zeta'),
    t('\\Zeta'),
    { condition = cond.in_mathzone }
  ),

  -- }}}

  -- {{{ Math

  s(autotext('ff', 'Fraction', 'Create a fraction'),
    fmta("\\frac{<>}{<>}", { i(1), i(2) }),
    { condition = cond.in_mathzone }
  ),

  s(autotext('sq', 'sqrt{}', 'Square-root'),
    fmta("\\sqrt{<>}", { i(1) }),
    { condition = cond.in_mathzone }
  ),

  s(autotext('(', 'left( right)', 'Create math compatible braces'),
    fmta([[\left( <> \right)]], { i(1) }),
    { condition = cond.in_mathzone }
  ),

  s(autotext('*', 'multiply', 'Better multiplication symbol'),
    t(' \\cdot '),
    { condition = cond.in_mathzone }
  ),

  -- }}}

  -- Other stuff TODO: Sort

  -- Environments

  s(text('beg', 'Begin', 'Create a new environment'),
    fmta([[
      \begin{<>}
        <>
      \end{<>}
    ]], { i(1), i(0), rep(1) })),

  s(autotext('...', 'ldots', 'Better version of ...'),
    fmt([[
      \ldots
    ]], {})),

  s(text('table', 'Table environment', nil),
    fmta([[
      \begin{table}[<>]
        \centering
        \begin{tabular}{|<>|}
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



  -- {{{ Sections

  s(text('sec', 'Section', 'Section including label'),
    fmta([[
      \section{<>}
      \label{sec:<>}

      <>
    ]], { i(1, 'name'), f(labelize, 1), i(0) })
  ),

  s(text('ssec', 'Subsection', 'Subsection including label'),
    fmta([[
      \subsection{<>}
      \label{ssec:<>}

      <>
    ]], { i(1, 'name'), f(labelize, 1), i(0) })
  ),

  s(text('sssec', 'Subsubsection', 'Subsubsection including label'),
    fmta([[
      \subsubsection{<>}
      \label{sssec:<>}

      <>
    ]], { i(1, 'name'), f(labelize, 1), i(0) })
  ),

  -- }}}

  s(text('cit', 'Citation', 'Reference a bibliography entry'),
    fmt([[
      ~\cite{{{}}}
    ]], { i(1, 'entry') })),
}
