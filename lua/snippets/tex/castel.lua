-- ~/.config/nvim/lua/snippets/tex/castel.lua
-- Fixed and sanitized LuaSnip snippets converted from UltiSnips.
-- Preserves as many snippets as possible while removing UltiSnips-only constructs
-- (backtick/python, regex replacements, empty triggers) that caused loader errors.
-- Review the commented-out originals if you want to reintroduce complex behavior.

local ok, ls = pcall(require, "luasnip")
if not ok or not ls then
  vim.notify("LuaSnip not available; skipping tex/castel snippets", vim.log.levels.WARN)
  return {}
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt_ok, fmt = pcall(function() return require("luasnip.extras.fmt").fmt end)

local snippets = {}
local function add(snip)
  table.insert(snippets, snip)
end

-- template
add(s({ trig = "template", wordTrig = true, dscr = "Basic template" }, {
  t({"\\documentclass[a4paper]{article}","","\\usepackage[utf8]{inputenc}","\\usepackage[T1]{fontenc}","\\usepackage{textcomp}","\\usepackage[dutch]{babel}","\\usepackage{amsmath, amssymb}","","% figure support","\\usepackage{import}","\\usepackage{xifthen}","\\pdfminorversion=7","\\usepackage{pdfpages}","\\usepackage{transparent}","\\newcommand{\\incfig}[1]{%","	\\def\\svgwidth{\\columnwidth}","	\\import{./figures/}{#1.pdf_tex}","}","","\\pdfsuppresswarningpagegroup=1","","\\begin{document}","	"}),
  i(0),
  t({"","\\end{document}"})
}))

-- begin / end
add(s({ trig = "beg", wordTrig = true, dscr = "begin{} / end{}" }, {
  t("\\begin{"), i(1, "env"), t({"}", "	"}), i(0), t({"", "\\end{"}), i(1), t("}")
}))

-- table (simplified: removed UltiSnips regex auto-joining)
add(s({ trig = "table", wordTrig = true, dscr = "Table environment" }, {
  t("\\begin{table}["), i(1, "htpb"), t({"]", "	\\centering", "	\\caption{"}),
  i(2, "caption"), t({"}", "	\\label{tab:"}), i(3, "label"), t({"}", "	\\begin{tabular}{"}),
  i(4, "c"), t({"}", "	"}), i(0), t({"", "	\\end{tabular}", "\\end{table}"})
}))

-- figure (simplified)
add(s({ trig = "fig", wordTrig = true, dscr = "Figure environment" }, {
  t("\\begin{figure}["), i(1, "htpb"), t({"]", "	\\centering", "	"}),
  t("\\includegraphics[width=0.8\\textwidth]{"), i(2, "path/to/img"), t({"}", "	\\caption{"}),
  i(3, "caption"), t({"}", "	\\label{fig:"}), i(4, "label"), t({"}", "\\end{figure}"})
}))

-- enumerate / itemize / description
add(s({ trig = "enum", wordTrig = true, dscr = "Enumerate" }, { t({"\\begin{enumerate}","	\\item "}), i(0), t({"","\\end{enumerate}"}) }))
add(s({ trig = "item", wordTrig = true, dscr = "Itemize" }, { t({"\\begin{itemize}","	\\item "}), i(0), t({"","\\end{itemize}"}) }))
add(s({ trig = "desc", wordTrig = true, dscr = "Description" }, { t({"\\begin{description}","	\\item["}), i(1), t("] "), i(0), t({"","\\end{description}"}) }))

-- package
add(s({ trig = "pac", wordTrig = true, dscr = "Package" }, { t("\\usepackage["), i(1, "options"), t("]{"), i(2, "package"), t("}"), i(0) }))

-- logical symbols
add(s({ trig = "=>", wordTrig = true, dscr = "implies" }, { t("\\implies") }))
add(s({ trig = "=<", wordTrig = true, dscr = "implied by" }, { t("\\impliedby") }))
add(s({ trig = "iff", wordTrig = true, dscr = "iff" }, { t("\\iff") }))

-- mk snippet: converted UltiSnips backtick to function_node
add(s({ trig = "mk", wordTrig = true, dscr = "Math" }, {
  t("$"), i(1), t("$"),
  f(function(args)
    local nxt = (args[1] and args[1][1]) or ""
    if nxt == "" then return "" end
    if nxt:match("^[,%.%?%-%s]") then return "" end
    return " "
  end, {2}),
  i(2),
}))

-- display math and align (simplify VISUAL placeholders)
add(s({ trig = "dm", wordTrig = true, dscr = "Display math" }, { t("\\["), i(1), t({"", "\\]"}), i(0) }))
add(s({ trig = "ali", wordTrig = true, dscr = "Align" }, { t({"\\begin{align*}", "	"}), i(1), t({"", "\\end{align*}"}) }))

-- fractions
add(s({ trig = "//", wordTrig = true, dscr = "Fraction" }, { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }))
add(s({ trig = "/", wordTrig = true, dscr = "Fraction" }, { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }))

-- simple math and operators
add(s({ trig = "==", wordTrig = true, dscr = "equals" }, { t("&= "), i(1), t(" \\\\") }))
add(s({ trig = "!=", wordTrig = true, dscr = "neq" }, { t("\\neq ") }))
add(s({ trig = "ceil", wordTrig = true, dscr = "ceil" }, { t("\\left\\lceil "), i(1), t(" \\right\\rceil "), i(0) }))
add(s({ trig = "floor", wordTrig = true, dscr = "floor" }, { t("\\left\\lfloor "), i(1), t(" \\right\\rfloor"), i(0) }))
add(s({ trig = "pmat", wordTrig = true, dscr = "pmat" }, { t("\\begin{pmatrix} "), i(1), t(" \\end{pmatrix} "), i(0) }))
add(s({ trig = "norm", wordTrig = true, dscr = "norm" }, { t("\\|"), i(1), t("\\|"), i(0) }))

-- a few more preserved snippets (simplified defaults)
add(s({ trig = "sum", wordTrig = true, dscr = "sum" }, { t("\\sum_{n="), i(1, "1"), t("}^{"), i(2, "\\infty"), t("} "), i(3, "a_n z^n") }))
add(s({ trig = "taylor", wordTrig = true, dscr = "taylor" }, { t("\\sum_{"), i(1, "k"), t("="), i(2, "0"), t("}^{"), i(3, "\\infty"), t("} "), i(4, "c_k"), t(" (x-a)^{"), i(1), t("} "), i(0) }))
add(s({ trig = "lim", wordTrig = true, dscr = "limit" }, { t("\\lim_{"), i(1, "n"), t(" \\to "), i(2, "\\infty"), t("} ") }))
add(s({ trig = "prod", wordTrig = true, dscr = "product" }, { t("\\prod_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} "), i(0) }))
add(s({ trig = "part", wordTrig = true, dscr = "d/dx" }, { t("\\frac{\\partial "), i(1, "V"), t("}{\\partial "), i(2, "x"), t("} "), i(0) }))

add(s({ trig = "sq", wordTrig = true, dscr = "sqrt" }, { t("\\sqrt{"), i(1), t("}"), i(0) }))
add(s({ trig = "td", wordTrig = true, dscr = "power" }, { t("^{"), i(1), t("}"), i(0) }))
add(s({ trig = "__", wordTrig = true, dscr = "subscript" }, { t("_{"), i(1), t("}"), i(0) }))

-- simple identifiers
add(s({ trig = "xnn", wordTrig = true, dscr = "xn" }, { t("x_{n}") }))
add(s({ trig = "ynn", wordTrig = true, dscr = "yn" }, { t("y_{n}") }))
add(s({ trig = "xii", wordTrig = true, dscr = "xi" }, { t("x_{i}") }))
add(s({ trig = "yii", wordTrig = true, dscr = "yi" }, { t("y_{i}") }))
add(s({ trig = "xjj", wordTrig = true, dscr = "xj" }, { t("x_{j}") }))
add(s({ trig = "yjj", wordTrig = true, dscr = "yj" }, { t("y_{j}") }))
add(s({ trig = "xp1", wordTrig = true, dscr = "x" }, { t("x_{n+1}") }))
add(s({ trig = "xmm", wordTrig = true, dscr = "x" }, { t("x_{m}") }))

-- plot (simplified)
add(s({ trig = "plot", wordTrig = true, dscr = "Plot" }, {
  t("\\begin{figure}["), i(1), t({"]", "	\\centering", "	\\begin{tikzpicture}", "		\\begin{axis}["}),
  t("xmin="), i(2, "-10"), t(", xmax="), i(3, "10"), t({",", "		ymin="}), i(4, "-10"), t(", ymax="), i(5, "10"),
  t({",", "		]", "		\\addplot[domain="}), i(2), t(":"), i(3), t(", samples="), i(6, "100"), t("]{"), i(7), t({"};", "	\\end{axis}", "	\\end{tikzpicture}", "	\\caption{"}), i(8), t({"}", "	\\label{"}), i(9, "label"), t({"}", "\\end{figure}"})
}))

-- tikz node (simplified)
add(s({ trig = "nn", wordTrig = true, dscr = "Tikz node" }, {
  t("\\node["), i(1, "options"), t("] ("), i(2, "name"), t(") at ("), i(3, "0,0"), t(") {$"), i(4), t("$};"), i(0)
}))

-- mathcal, text, cases, SI, etc.
add(s({ trig = "mcal", wordTrig = true, dscr = "mathcal" }, { t("\\mathcal{"), i(1), t("}"), i(0) }))
add(s({ trig = "tt", wordTrig = true, dscr = "text" }, { t("\\text{"), i(1), t("}"), i(0) }))
add(s({ trig = "case", wordTrig = true, dscr = "cases" }, { t({"\\begin{cases}","	"}), i(1), t({"","\\end{cases}"}) }))
add(s({ trig = "SI", wordTrig = true, dscr = "SI" }, { t("\\SI{"), i(1), t("}{"), i(2), t("}") }))

-- convenience snippets
add(s({ trig = "letw", wordTrig = true, dscr = "let omega" }, { t("Let $\\Omega \\subset \\C$ be open.") }))
add(s({ trig = "HH", wordTrig = true, dscr = "H" }, { t("\\mathbb{H}") }))
add(s({ trig = "DD", wordTrig = true, dscr = "D" }, { t("\\mathbb{D}") }))

return snippets

