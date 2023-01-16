local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
-- Examples of complete snippets using fmt and fmta
-- \texttt
s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
  fmta(
    "\\texttt{<>}",
    { i(1) }
  )
),


-- Equation
s({trig="eq", dscr="Expands 'eq' into an equation environment"},
  fmta(
     [[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
     { i(1) }
  )
),

-- Align
s({trig="align", dscr="Expands 'align' into an align environment"},
  fmta(
     [[
       \begin{align}
           <>
       \end{align}
     ]],
     { i(1) }
  )
),

-- Begin environment
s({trig="begin", dscr="Expands begin into a begin environment"},
  fmta(
    [[
      \begin{<>}
        <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      rep(1),
    }
  )
),



s({trig="mm", dscr="Inline math"},
  fmta(
    "\\(<>\\)",
    {i(1)}
  )
),

s({trig="mmm", dscr="Multi-line math"},
  fmta(
    "\\[<>\\]",
    {i(1)}
  )
),

-- Sections
s({trig="sec", dscr="Section"},
  fmta(
    "\\section{<>}",
    {i(1)}
  )
),

s({trig="ssec", dscr="Subsection"},
  fmta(
    "\\subsection{<>}",
    {i(1)}
  )
),

s({trig="sssec", dscr="Sub-subsection"},
  fmta(
    "\\subsubsection{<>}",
    {i(1)}
  )
),




}
