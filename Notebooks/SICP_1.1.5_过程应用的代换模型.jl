### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 0b0790f0-b6f6-11ef-25f1-91793709356b
md"
===================================================================================
#### SICP: 1.1.5 [The Substitution Model for Procedure Application（过程应用的代换模型）](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book.html)

===================================================================================
"

# ╔═╡ 0ea9ee43-7ed8-47d9-b2c1-03ea8a45fc15
md"
$f(a) = sumOfSquares(a + 1, a * 2)$

$\;$

$sumOfSquares(x, y) = square(x) + square(y)$

$\;$

$square(x) = x * x$

$\;$

执行 $f(5)$:

$f(5) \mapsto sumOfSquares(5 + 1, 5 * 2)$

$\;$

两种计算方式

$\;$

"

# ╔═╡ 93ca9e2e-7e68-495c-ba9a-6d6be46a9b7f
md"
---
###### 逐级计算

- *Evaluation* by reduction of arguments

$sumOfSquares(5 + 1, 5 * 2) \mapsto sumOfSquares(6, 10)$

$\;$

- *Expansion* by substitution of nonprimitive function call by function's body

$sumOfSquares(6, 10) \mapsto square(6) + square(10)$

$\;$

- *Expansion* by substitution of nonprimitive function call by function's body

$square(6) + square(10) \mapsto 6 * 6 + 10 * 10$

$\;$

- *Evaluation* by reduction of primitive expressions

$6 * 6 + 10 * 10 \mapsto 36 + 100$

$\;$

- *Evaluation* by reduction of primitive expressions

$36 + 100 \mapsto 136$

$\;$

"

# ╔═╡ 17e4b07e-e167-4f00-8880-a46af72ff192
md"
---
###### 先展开后运算

- *Expansion* by *substitution* of function *head* by function *body*

$sumOfSquares(5 + 1, 5 * 2) \mapsto square(5 + 1) + square(5 * 2)$

$\;$

- *Expansion* by *substitution* of function *head* by function *body*

$square(5 + 1) + square(5 * 2) \mapsto (5+1) * (5+1) + (5*2) * (5*2)$

$\;$

- *Evaluation* by *reduction* of *primitive* expressions

$(5+1) * (5+1) + (5*2) * (5*2) \mapsto 6 * 6 + 10 * 10$

$\;$

- *Evaluation* by *reduction* of *primitive* expressions

$6 * 6 + 10 * 10 \mapsto 36 + 100$

$\;$

- *Evaluation* by *reduction* of *primitive* expressions

$36 + 100 \mapsto 136$

$\;$

"

# ╔═╡ 05e1dcb0-a94c-4c8f-b1d1-f0e9c4f8e8a0
begin
f(a) = sumOfSquares(a + 1, a * 2)
sumOfSquares(x, y) = square(x) + square(y)
square(x) = x * x
f(5)
end

# ╔═╡ 1d6258a3-dc05-40e2-94bf-604a33e3fb7a
md"
---
##### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**; [*Structure and Interpretation of Computer Programs*](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book.html), Cambridge, Mass.: MIT Press, (2/e), 1996; last visit 2024/012/10
"

# ╔═╡ Cell order:
# ╟─0b0790f0-b6f6-11ef-25f1-91793709356b
# ╟─0ea9ee43-7ed8-47d9-b2c1-03ea8a45fc15
# ╟─93ca9e2e-7e68-495c-ba9a-6d6be46a9b7f
# ╟─17e4b07e-e167-4f00-8880-a46af72ff192
# ╠═05e1dcb0-a94c-4c8f-b1d1-f0e9c4f8e8a0
# ╟─1d6258a3-dc05-40e2-94bf-604a33e3fb7a
