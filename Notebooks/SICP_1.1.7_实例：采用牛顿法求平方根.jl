### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 8bfaa820-fd16-11eb-1583-a75201c2e58a
md"
======================================================================================
### SICP: [1.1.7 Square Roots by Newton's_Method（实例： 采用牛顿法求平方根）](https://sarabander.github.io/sicp/html/1_002e1.xhtml#g_t1_002e1_002e7)
======================================================================================
"

# ╔═╡ 51f5c695-86be-4ae8-83df-20d2538ccc2e
md"
#### 1.1.7.1 SICP-Scheme-like *functional* Julia ...

"

# ╔═╡ 02343a68-6e78-495a-ac9e-bda7fc49e6f9
md"
---
###### Specification of the *square-root* function

$$\sqrt x := \cases{\mathbb R \rightarrow \mathbb R \cr x \mapsto \sqrt x \in \{y \;|\; (y \ge 0) \land (y^2 - x = 0) \}}$$

---
"

# ╔═╡ b77cb3ba-74b0-4760-b0da-0a1672f9132d
md"
###### 不规定类型的 'square'函数
"

# ╔═╡ cc3dea2a-239e-4a4a-bbc0-2866b8ff2395
square(x) = *(x, x)    # prefix operator '*'

# ╔═╡ 62ee0c42-9542-449e-af70-ce055cc51272
square(3)

# ╔═╡ 95918a1c-25a1-4559-b497-6b182902be8c
square(3.0)

# ╔═╡ fad4dff2-ded1-45fd-aadd-0f3bb381d00e
square("oh ")                               # not intented, but '*' is overloaded 

# ╔═╡ f12a62b3-30b8-4359-b310-c5fa1701d2c6
average(x, y) = /(+(x, y), 2)               # '/(...)' generates a Float !

# ╔═╡ 20876704-415e-4486-9c45-5899cbf56005
improve(guess, x) = average(guess, /(x, guess))

# ╔═╡ 82357252-5521-470d-a5f6-e29ca14421dc
good_enough(guess, x) = <( abs( -( square(guess), x)), 0.001)

# ╔═╡ f794e8e7-7fbe-4152-89a2-5fe1efc279e7
function sqrt_iter(guess, x)
	if good_enough(guess, x)
		guess
	else
		sqrt_iter(improve(guess, x), x)
	end # if
end # function

# ╔═╡ a490fedf-ffbd-489a-b7c0-6a13c070749c
sqrt(x) = sqrt_iter(1.0, x)     

# ╔═╡ 7539b320-5e91-4908-8377-8e8d41c25bd6
md"
---
#### 1.1.7.2 Julia写法
###### 定义类型
"

# ╔═╡ 4f5b483d-eb87-45be-8344-bf2596f1fdab
supertype(AbstractFloat)

# ╔═╡ a83f2731-d370-42b2-8b61-fef1ebc0a4b0
subtypes(Real) # AbstractIrrational and Integer are not need in the sqrt context

# ╔═╡ ee19324f-f534-4c36-8568-b983429ddf87
subtypes(AbstractFloat)

# ╔═╡ e370ea64-fca3-4e8e-9190-dd4064a39172
# self-defined abstract type
FloatOrInteger = Union{AbstractFloat, Integer}

# ╔═╡ 2307d1b7-7ee1-4b77-bd46-121a0bb6e646
md"
###### 2nd (specific) *typed* method of function 'square'
"

# ╔═╡ 097f7553-f434-46c3-bcec-972cd47f05ea
sqrt(x::FloatOrInteger)::FloatOrInteger = sqrt_iter(1.0, x)  

# ╔═╡ 78cb860b-158b-4914-b85e-970d5ba8ee1b
sqrt(9)

# ╔═╡ a25dda27-50da-4817-aede-b5969fd42ff4
sqrt( +( 100, 37))

# ╔═╡ 6d3bfba2-3f10-4047-b808-ca8438e78318
sqrt( +( sqrt(2), sqrt(3)))

# ╔═╡ 0ea7ffbc-8fb9-484f-9806-b12ffa90eb82
square( sqrt( 1000))

# ╔═╡ 7fb56f2f-9ad5-4c1c-b1db-9f4b5091d22f
sqrt(9)

# ╔═╡ 3f22b22e-67af-447d-9ba4-3bf04a393e61
sqrt(9.0)

# ╔═╡ c4f34640-67ef-4f71-8d69-a35d446e31bb
sqrt(100. + 37.)

# ╔═╡ e31d5876-7de3-4d13-a05a-ca8f7c0ab8fe
sqrt(sqrt(2.0) + sqrt(3.0))

# ╔═╡ eb54070b-c564-45b2-979c-5074cec390bb
sqrt(1000)^2

# ╔═╡ 2eeceb53-811b-4999-a09b-71897dec7fb6
sqrt(1000.0)^2

# ╔═╡ a6f3f9cd-7a52-4549-9e3a-02b3b1cbd127
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**, Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/23
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
# ╟─8bfaa820-fd16-11eb-1583-a75201c2e58a
# ╟─51f5c695-86be-4ae8-83df-20d2538ccc2e
# ╟─02343a68-6e78-495a-ac9e-bda7fc49e6f9
# ╟─b77cb3ba-74b0-4760-b0da-0a1672f9132d
# ╠═cc3dea2a-239e-4a4a-bbc0-2866b8ff2395
# ╠═62ee0c42-9542-449e-af70-ce055cc51272
# ╠═95918a1c-25a1-4559-b497-6b182902be8c
# ╠═fad4dff2-ded1-45fd-aadd-0f3bb381d00e
# ╠═f794e8e7-7fbe-4152-89a2-5fe1efc279e7
# ╠═20876704-415e-4486-9c45-5899cbf56005
# ╠═f12a62b3-30b8-4359-b310-c5fa1701d2c6
# ╠═82357252-5521-470d-a5f6-e29ca14421dc
# ╠═a490fedf-ffbd-489a-b7c0-6a13c070749c
# ╠═78cb860b-158b-4914-b85e-970d5ba8ee1b
# ╠═a25dda27-50da-4817-aede-b5969fd42ff4
# ╠═6d3bfba2-3f10-4047-b808-ca8438e78318
# ╠═0ea7ffbc-8fb9-484f-9806-b12ffa90eb82
# ╟─7539b320-5e91-4908-8377-8e8d41c25bd6
# ╠═4f5b483d-eb87-45be-8344-bf2596f1fdab
# ╠═a83f2731-d370-42b2-8b61-fef1ebc0a4b0
# ╠═ee19324f-f534-4c36-8568-b983429ddf87
# ╠═e370ea64-fca3-4e8e-9190-dd4064a39172
# ╠═2307d1b7-7ee1-4b77-bd46-121a0bb6e646
# ╠═097f7553-f434-46c3-bcec-972cd47f05ea
# ╠═7fb56f2f-9ad5-4c1c-b1db-9f4b5091d22f
# ╠═3f22b22e-67af-447d-9ba4-3bf04a393e61
# ╠═c4f34640-67ef-4f71-8d69-a35d446e31bb
# ╠═e31d5876-7de3-4d13-a05a-ca8f7c0ab8fe
# ╠═eb54070b-c564-45b2-979c-5074cec390bb
# ╠═2eeceb53-811b-4999-a09b-71897dec7fb6
# ╟─a6f3f9cd-7a52-4549-9e3a-02b3b1cbd127
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
