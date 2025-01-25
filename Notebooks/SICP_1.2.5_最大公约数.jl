### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ cea33580-f5f4-11eb-292b-3d35bf7a4518
md"
===================================================================================
### SICP: [1.2.5 Greatest Common Divisors(最大公约数)](https://sarabander.github.io/sicp/html/1_002e2.xhtml#g_t1_002e2_002e5)
===================================================================================
"

# ╔═╡ 5ea2052f-84ee-4d6a-9b13-681477241161
md"
#### 1.2.5.1 SICP-Scheme-like *functional* Julia ...
###### '%':除法的余数，返回一个与x符号相同、大小小于y的值。这个值总是精确的。
"

# ╔═╡ b7bb02fa-22ad-46f5-9e1b-30fe6e37b157
function gcd1(a, b)
	#-----------------------------------------
	remainder = %              # ... with '%'
	#-----------------------------------------
	==(b, 0) ? 
		a : 
		gcd1(b, remainder(a, b))
end # function gcd1

# ╔═╡ baed6744-f6e3-4862-898d-9d1c8f84ec65
gcd1(206, 40)

# ╔═╡ f5f1726e-be92-4e6a-bc03-573401d8457b
md"
**269, 271** ; both are *adjacent* [prime numbers](https://en.wikipedia.org/wiki/List_of_prime_numbers)
"

# ╔═╡ 3be00d9d-a76c-46a9-99cc-f57f1e1ae285
gcd1(269, 271)   

# ╔═╡ 15522f43-48ad-4067-b0c2-1cf82e177ac2
md"
**7907 	7919** ; both are *adjacent* [prime numbers](https://en.wikipedia.org/wiki/List_of_prime_numbers)
"

# ╔═╡ 5ec142a1-4148-490f-851a-e9c1211057ff
gcd1(7907, 7919)

# ╔═╡ 828d22df-78e2-448f-ac8e-732bd1283d11
md"
---
#### 1.2.5.2 Julia风格代码
"

# ╔═╡ 95e8dfaa-7300-4668-8be3-61cf9d383258
function gcd2(a::Signed, b::Signed)::Signed
	#-----------------------------------------
	remainder = %
	#=----------------------------------------
	b == 0 ? a : gcd(b, remainder(a, b))
	#---------------------------------------=#
	while !(b == 0)
		a,b = b, remainder(a, b) # parallel (!) assignment
	end # while
	a
end # function

# ╔═╡ e5deb81e-c2ff-4fc5-ab2d-462eac4aafb4
gcd2(206, 40)

# ╔═╡ 2cdf2274-4d4e-4cde-99db-253654bdb50d
gcd2(269, 271)  

# ╔═╡ 0caa1383-cffe-41a6-920c-d766bcd05b49
gcd2(7, 7919)

# ╔═╡ 9d66f3ef-b3ef-4efa-93ab-1a0313e415d3
gcd2(7907, 7919)

# ╔═╡ 5cd5cdec-238c-47ae-b079-c25804c6c42e
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**, Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/24
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
# ╟─cea33580-f5f4-11eb-292b-3d35bf7a4518
# ╠═5ea2052f-84ee-4d6a-9b13-681477241161
# ╠═b7bb02fa-22ad-46f5-9e1b-30fe6e37b157
# ╠═baed6744-f6e3-4862-898d-9d1c8f84ec65
# ╟─f5f1726e-be92-4e6a-bc03-573401d8457b
# ╠═3be00d9d-a76c-46a9-99cc-f57f1e1ae285
# ╟─15522f43-48ad-4067-b0c2-1cf82e177ac2
# ╠═5ec142a1-4148-490f-851a-e9c1211057ff
# ╟─828d22df-78e2-448f-ac8e-732bd1283d11
# ╠═95e8dfaa-7300-4668-8be3-61cf9d383258
# ╠═e5deb81e-c2ff-4fc5-ab2d-462eac4aafb4
# ╠═2cdf2274-4d4e-4cde-99db-253654bdb50d
# ╠═0caa1383-cffe-41a6-920c-d766bcd05b49
# ╠═9d66f3ef-b3ef-4efa-93ab-1a0313e415d3
# ╟─5cd5cdec-238c-47ae-b079-c25804c6c42e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
