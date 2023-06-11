local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- dynamic matrix 
local mat = function(args, snip)
	local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j).."x1", i(1)))
		ins_indx = ins_indx+1
		for k = 2, cols do
			table.insert(nodes, t" & ")
			table.insert(nodes, r(ins_indx, tostring(j).."x"..tostring(k), i(1)))
			ins_indx = ins_indx+1
		end
		table.insert(nodes, t{"\\\\", ""})
	end
	return sn(nil, nodes)
end

return {
-- Matrix snippet
s({ trig='([bBpvV])mat(%d+)x(%d+)', regTrig=true, name='matrix', dscr='matrix trigger lets go'},
    fmt([[
    \begin{<>}
    <>\end{<>}]],
    { f(function (_, snip) return snip.captures[1] .. "matrix" end),
    d(1, mat),
    f(function (_, snip) return snip.captures[1] .. "matrix" end)},
    { delimiters='<>' }
)),

-- fraction
s({trig="frac", dscr="Expands 'frac' into '\frac{}{}'"},
  fmta(
    "\\frac{<>}{<>}",
    {
      i(1),
      i(2)
    }
  ),
  {condition = in_mathzone}
),

s({trig="sqrt", dscr="Makes a square root"},
  fmta(
    "\\sqrt{<>}",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="pow", dscr="A raised to power B"},
  fmta(
    "^{<>}",
    {i(1, "exponent")}
  ),
  {condition = in_mathzone}
),

s({trig="lim", dscr="Limit from A to B"},
  fmta(
    "\\lim_{<> \\to <>}{<>}",
    {i(1, "from"), i(2, "to"), i(3, "content")}
  ),
  {condition = in_mathzone}
),

s({trig="mbb", dscr="Mathbb"},
  fmta(
    "\\mathbb{<>}",
    {i(1)}
  ),
  {condition = in_mathzone}
),

-- Brackets
s({trig="big(", dscr="Big normal bracket"},
  fmta(
    "\\left( <> \\right)",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="big[", dscr="Big square bracket"},
  fmta(
    "\\left[ <> \\right]",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="big{", dscr="Big curly bracket"},
  fmta(
    "\\left{ <> \\right}",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="norm", dscr="Norm"},
  fmta(
    "\\lVert <> \\rVert",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="abs", dscr="Absolute"},
  fmta(
    "\\lvert <> \\rvert",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="qed", dscr="Blacksquare"},
  {t("\\blacksquare")},
  {condition = in_mathzone}
),
s({trig=".", dscr="cdot"},
  {t("\\cdot")},
  {condition = in_mathzone}
),


s({trig="inf", dscr="Infinity"},
  {t("\\infty")},
  {condition = in_mathzone}
),

s({trig="int", dscr="Integral"},
  fmta(
    "\\int_{<>}^{<>} <> \\, d<>",
    {i(1, "from"), i(2, "to"), i(3, "content"), i(4, "w.r.t")}
  ),
  {condition = in_mathzone}
),

s({trig="evalat", dscr="Evaluate from a to b"},
  fmta(
    "\\left <> \\right|_{<>}^{<>}",
    {i(1, "content"), i(2), i(3)}
  ),
  {condition = in_mathzone}
),
s({trig="uint", dscr="Unbounded integral"},
  fmta(
    "\\int <> \\, d<>",
    {i(1, "content"), i(2, "w.r.t")}
  ),
  {condition = in_mathzone}
),

s({trig="bar", dscr="Bar"},
  fmta(
    "\\bar{<>}",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="hat", dscr="Hat"},
  fmta(
    "\\hat{<>}",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="vec", dscr="Vector"},
  fmta(
    "\\vec{<>}",
    {i(1)}
  ),
  {condition = in_mathzone}
),
s({trig="sum", dscr="Summation"},
  fmta(
    "\\sum_{<>}^{<>}",
    {i(1), i(2)}
  ),
  {condition = in_mathzone}
),

s({trig="prod", dscr="Product"},
  fmta(
    "\\prod_{<>}^{<>}",
    {i(1),i(2)}
  ),
  {condition = in_mathzone}
),

s({trig="ceil", dscr="Ceiling"},
  fmta(
    "\\left \\lceil <> \\right \\rceil",
    {i(1)}
  ),
  {condition = in_mathzone}
),

s({trig="floor", dscr="Floor"},
  fmta(
    "\\left \\lfloor <> \\right \\rfloor",
    {i(1)}
  ),
  {conditions = in_mathzone}
),
}
