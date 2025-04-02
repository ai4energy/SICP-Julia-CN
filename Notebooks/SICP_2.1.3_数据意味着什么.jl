### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ fa6c0100-1611-11ec-3128-5b6990f1847c
md"
=====================================================================================
#### SICP: [2.1.3 What Is Meant by Data(数据意味着什么)](https://sarabander.github.io/sicp/html/2_002e1.xhtml#g_t2_002e1_002e3)

=====================================================================================
"

# ╔═╡ 0553bca4-5045-463b-adea-965f01caaaef
md"
##### 2.1.3.1 Axioms of ADT Rational Number
---
###### Axiom 1: 
$$numer(make\_rat(n, d)) == n$$
###### Axiom 2: 
$$denom(make\_rat(n, d)) == d$$

---
"

# ╔═╡ 1b3ecdf5-2317-41c1-9866-24be93c1deec
md"
##### 2.1.3.2 Axioms of Cons-Cells
---
###### Axiom 1: 
$$car(cons(x, y)) == x$$
###### Axiom 2: 
$$cdr(cons(x, y)) == y$$

---
"

# ╔═╡ ab6b08f0-cb20-41e5-b2cf-05f3d06371b7
md"
---
##### 2.1.3.3 SICP-Scheme-like *functional* Julia 
##### 2.1.3.3.1 *Procedural* Representation of *Data* (enables OOP)
"

# ╔═╡ 4ac4b9ce-a27b-40e5-84df-791c8b9ae748
md"
###### OOP: object $$cons$$ understands messages $$:car$$ and $$:cdr$$
"

# ╔═╡ a04adb02-f6c0-484d-b743-47424a2681a0
function cons(x, y)
	#-------------------------------------
	function dispatch(message)
		==(message, :car) ? x :
		==(message, :cdr) ? y :
		"error not 0 or 1 but $message"
	end # function dispatch
	#-------------------------------------
	dispatch # return the dispatch-function
end # function cons

# ╔═╡ 2613f7e7-1070-47d1-8ef3-9dc7f2282881
function car(cons)
	cons(:car)
end

# ╔═╡ d6ea1838-3b0a-4797-8032-0d2dc210ade0
function cdr(cons)
	cons(:cdr)
end

# ╔═╡ cb6716a8-180a-45e9-b1a0-2146ff71cb3a
md"
##### 2.1.3.3.2 Applications
"

# ╔═╡ 2e055300-f8e5-42df-a8e7-872f9f337845
x, y = :a, :b                            # make tuple

# ╔═╡ 4aca5493-ff3d-46c1-9215-af3bc769d28e
z = cons(x, y)                           # make cons-cell

# ╔═╡ bcc2047e-0cdb-4763-af16-5c97994ef517
car(cons(x, y))                          # apply car == select first element of tuple

# ╔═╡ 881e3a90-8b68-47ed-9d79-d8ed5ab1faa6
cdr(cons(x, y))                          # apply cdr == select second element of tuple

# ╔═╡ 301d3021-02d3-41cf-8ffa-026370af7e5f
car(z)

# ╔═╡ 6c7b6bea-ba2a-419e-8304-d78cdf837386
cdr(z)

# ╔═╡ a99b80d7-5033-4f1d-8432-2bdc237aabe1
md"
###### OO-orientated Message Passing
(s.a. Smalltalk or [Pharo](https://files.pharo.org/media/pharoCheatSheet.pdf))
"

# ╔═╡ 71a71be8-8b62-478b-abf8-8cae7b324420
objAB = cons(:a, :b)

# ╔═╡ a06a1086-b24b-4127-9096-412314c63a09
objAB(:car) == :a  # ==> true --> :)      unary message ala Pharo or Smalltalk

# ╔═╡ 8a98bcac-3e71-4ac3-af59-ecd96ddbbd79
objAB(:cdr) == :b  # ==> true --> :)      unary message ala Pharo or Smalltalk

# ╔═╡ 6a50a311-6479-4334-80f5-820dc6600fcd
md"
##### 2.1.3.3.3 Axioms
"

# ╔═╡ 9e4a7729-3f1c-4be5-8a71-31f67685d3e6
car(cons(x, y))

# ╔═╡ 150b7adc-aff4-4b87-8ac3-316657b1fd0e
cdr(cons(x, y))

# ╔═╡ 168aa8a3-cfd8-4758-8161-6dd955468a7a
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/30
- **pharoCheatSheet**; [https://files.pharo.org/media/pharoCheatSheet.pdf](https://files.pharo.org/media/pharoCheatSheet.pdf); last visit 2023/02/26.

"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─fa6c0100-1611-11ec-3128-5b6990f1847c
# ╟─0553bca4-5045-463b-adea-965f01caaaef
# ╟─1b3ecdf5-2317-41c1-9866-24be93c1deec
# ╟─ab6b08f0-cb20-41e5-b2cf-05f3d06371b7
# ╟─4ac4b9ce-a27b-40e5-84df-791c8b9ae748
# ╠═a04adb02-f6c0-484d-b743-47424a2681a0
# ╠═2613f7e7-1070-47d1-8ef3-9dc7f2282881
# ╠═d6ea1838-3b0a-4797-8032-0d2dc210ade0
# ╟─cb6716a8-180a-45e9-b1a0-2146ff71cb3a
# ╠═2e055300-f8e5-42df-a8e7-872f9f337845
# ╠═4aca5493-ff3d-46c1-9215-af3bc769d28e
# ╠═bcc2047e-0cdb-4763-af16-5c97994ef517
# ╠═881e3a90-8b68-47ed-9d79-d8ed5ab1faa6
# ╠═301d3021-02d3-41cf-8ffa-026370af7e5f
# ╠═6c7b6bea-ba2a-419e-8304-d78cdf837386
# ╟─a99b80d7-5033-4f1d-8432-2bdc237aabe1
# ╠═71a71be8-8b62-478b-abf8-8cae7b324420
# ╠═a06a1086-b24b-4127-9096-412314c63a09
# ╠═8a98bcac-3e71-4ac3-af59-ecd96ddbbd79
# ╟─6a50a311-6479-4334-80f5-820dc6600fcd
# ╠═9e4a7729-3f1c-4be5-8a71-31f67685d3e6
# ╠═150b7adc-aff4-4b87-8ac3-316657b1fd0e
# ╟─168aa8a3-cfd8-4758-8161-6dd955468a7a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
