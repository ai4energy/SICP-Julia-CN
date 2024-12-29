### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ a7e53a80-efbc-11eb-01eb-f39291a29b7b
md"
===============================================================================

 ### SICP: [1.1.2 命名和环境](https://sarabander.github.io/sicp/html/1_002e1.xhtml#g_t1_002e1_002e2)

===============================================================================
"

# ╔═╡ 142e3daf-a22c-4122-8668-936fb7cb88b2
md"
###### definition and binding（定义和绑定）
"

# ╔═╡ cb118a0e-e7f3-4588-8005-2313ed701933
size = 2

# ╔═╡ faa86a64-d3c8-41f2-83cb-739ec7e57643
md"
###### evaluation of definition（求值）
"

# ╔═╡ d09b25c4-58be-42b9-a94d-2f72fbf4dd69
size

# ╔═╡ 06a90696-699e-4269-9f73-7cb4f3acc0ca
md"
###### expression in prefix form（前缀表达式）
"

# ╔═╡ 76e143da-f570-40ed-9632-2586d21872f5
*(5, size)

# ╔═╡ 8f9ac6f9-573b-44bd-b22b-669ae55bcbf1
pi_SICP = 3.14159

# ╔═╡ 6689bc4c-9a37-402d-a602-4cae12c318a5
radius = 10

# ╔═╡ 1dd2b96a-5aec-439c-b3e1-6bf41811ae9d
md"
###### nested expressions in prefix form（前缀形式的嵌套表达式）
$$\mathbb{R}  \rightarrow \mathbb{R}$$
$$area: r \mapsto area(r)$$ 
$$area(r) := r^2\pi$$
"

# ╔═╡ 1a71832a-20ba-4807-8c54-a8ff45487a59
*(pi_SICP, *(radius, radius))

# ╔═╡ b462248d-f04f-43e4-b320-2277157d3dce
md"
$$\mathbb{R}  \rightarrow \mathbb{R}$$
$$circumference: r \mapsto circumference(r)$$ 
$$circumference(r) := 2\pi r$$
"

# ╔═╡ 676b0597-c81d-49bb-93a1-74ce4a1ebb65
circumference1 = *(2, pi_SICP, radius)

# ╔═╡ 55017fa6-ad28-4c5a-bf00-23e8f5e75239
md"
---
##### 1.1.2.2 idiomatic *imperative* Julia-code（Julia代码）
"

# ╔═╡ cb51bf29-15c0-484d-9d34-77668d1381ff
typeof(size)

# ╔═╡ 529d628c-b723-4637-b715-6c3ea34ec777
pi                       # Julia's constant π

# ╔═╡ c0e06aa4-d579-443d-a9eb-22c83915a68e
typeof(pi)               # type is irrational !

# ╔═╡ 1cc9f454-4b80-42cb-a371-84073a3ef5f9
π                        # Julia with unicode '\pi [tab]'

# ╔═╡ c561e48b-294d-4f35-a63d-fd7a7176cd14
π 

# ╔═╡ ade5a873-31fb-4303-975b-e5d99bb6646f
typeof(π)                # irrational !

# ╔═╡ e822d1a5-32cb-4b3f-b432-db0d3f7593a8
5 * size

# ╔═╡ eb8bdbd6-ba4d-423a-914b-91b76864a0a6
area = radius^2 * π

# ╔═╡ 8a84aab1-a610-4c6c-accb-8ec04ba57bfa
circumference = 2 * pi * radius

# ╔═╡ ec607645-1751-4b02-9576-a0ae82434c98
circumference2 = 2π * radius      # juxtaposition of 2π

# ╔═╡ 656eaa4d-846c-4849-97ea-266a38f85d41
md"
---
##### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**, Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/23

"

# ╔═╡ b10318d0-4cc0-43bf-af57-72b030992d8f
md"
---
##### end of ch. 1.1.2
===================================================================================

This is a **draft** under the [Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/) license. Comments, suggestions for improvement and bug reports are welcome: **claus.moebus(@)uol.de**

===================================================================================
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
# ╟─a7e53a80-efbc-11eb-01eb-f39291a29b7b
# ╟─142e3daf-a22c-4122-8668-936fb7cb88b2
# ╠═cb118a0e-e7f3-4588-8005-2313ed701933
# ╟─faa86a64-d3c8-41f2-83cb-739ec7e57643
# ╠═d09b25c4-58be-42b9-a94d-2f72fbf4dd69
# ╟─06a90696-699e-4269-9f73-7cb4f3acc0ca
# ╠═76e143da-f570-40ed-9632-2586d21872f5
# ╠═8f9ac6f9-573b-44bd-b22b-669ae55bcbf1
# ╠═6689bc4c-9a37-402d-a602-4cae12c318a5
# ╟─1dd2b96a-5aec-439c-b3e1-6bf41811ae9d
# ╠═1a71832a-20ba-4807-8c54-a8ff45487a59
# ╟─b462248d-f04f-43e4-b320-2277157d3dce
# ╠═676b0597-c81d-49bb-93a1-74ce4a1ebb65
# ╠═55017fa6-ad28-4c5a-bf00-23e8f5e75239
# ╠═cb51bf29-15c0-484d-9d34-77668d1381ff
# ╠═529d628c-b723-4637-b715-6c3ea34ec777
# ╠═c0e06aa4-d579-443d-a9eb-22c83915a68e
# ╠═1cc9f454-4b80-42cb-a371-84073a3ef5f9
# ╠═c561e48b-294d-4f35-a63d-fd7a7176cd14
# ╠═ade5a873-31fb-4303-975b-e5d99bb6646f
# ╠═e822d1a5-32cb-4b3f-b432-db0d3f7593a8
# ╠═eb8bdbd6-ba4d-423a-914b-91b76864a0a6
# ╠═8a84aab1-a610-4c6c-accb-8ec04ba57bfa
# ╠═ec607645-1751-4b02-9576-a0ae82434c98
# ╟─656eaa4d-846c-4849-97ea-266a38f85d41
# ╟─b10318d0-4cc0-43bf-af57-72b030992d8f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
