### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 50cbd85a-2a84-4f2c-836b-7a121a2f4a89
using Plots

# ╔═╡ 3ab9a060-01a8-11ec-26b0-f58b434fab4c
md"
======================================================================================
### SICP: [1.3.4 Procedures As Returned Values（过程作为返回值）](https://sarabander.github.io/sicp/html/1_002e3.xhtml#g_t1_002e3_002e4)

======================================================================================
"

# ╔═╡ a378aca9-2d79-4124-bea6-ba62ab1c3d83
md"
---
#### 1.3.4.1 Square and cube root as fix points
$$\sqrt \; : x \mapsto y \in \{y \;|\; (y > 0) \land (y^2 = x)\}$$
$$\sqrt \; : x \mapsto f(x)$$
$$f(x) := x/y$$

---
"

# ╔═╡ e4443263-e26f-462e-b11a-294fbd259e9a
md"
##### 1.3.4.1.1 SICP-Scheme-like *functional* Julia
"

# ╔═╡ 3df9dd3c-058b-47b6-b39d-570443cc51b9
function averageDamp(f)
	average(x, y) = /(+(x, y), 2)
	function (x)           # definition of anonymous function λ
		average(x, f(x))
	end # λ
end # function averageDamp

# ╔═╡ 2a56d3e3-bb2e-4382-864c-9d3c099cb177
square(x) = ^(x, 2)

# ╔═╡ 53b7806d-489d-45ba-80a9-17bf9ebfc434
averageDamp(square)(10)       # two '(' and two ')'

# ╔═╡ f5a15cb0-a039-43a1-ba4c-2674e672e6ff
(averageDamp(square))(10)     # three '(' and three ')'

# ╔═╡ 81ecbeb5-7c4d-40e8-aeb1-2386277de71d
((averageDamp(square))(10))   # three '(' and three ')'

# ╔═╡ 1fc90de5-9e3d-417b-8475-1ae507eb355c
(averageDamp(square)(10))     # three '(' and three ')'

# ╔═╡ 73c57933-68f8-4e92-8a2a-edf4da95d723
md"
---
##### Cube root as fix point:

$$^3\sqrt \; : x \mapsto y \in \{y \;|\; (y>0) \land (y^3 = x)\}$$
$$^3\sqrt \; : x \mapsto g(x)$$
$$g(x) = x/y^2$$

---
"

# ╔═╡ f05fca2a-638f-47f3-9b64-b1845b4169c7
md"
---
##### 1.3.4.1.2 idiomatic *imperative* Julia ...
###### ... with self-defined abstrac type 'FloatOrInteger', while, ...
"

# ╔═╡ 9b740450-2b0f-4955-a2c7-06b926cd7191
FloatOrSigned = Union{AbstractFloat, Signed}

# ╔═╡ 061844e7-ff4d-4697-9179-7470ca4a0f19
tolerance = 1.0E-6

# ╔═╡ 744ed935-2298-467b-8042-a4ff00f3e40c
function fixedPoint3(f::Function, first_guess::FloatOrSigned)::FloatOrSigned
	#----------------------------------------------
	close_enough(v1, v2) = abs(v1-v2) < tolerance
	#----------------------------------------------
	guess = first_guess
	next = f(guess)
	while !close_enough(guess, next)
		guess = next
		next = f(guess)
	end
	next
end

# ╔═╡ 78462eeb-5f46-48e8-bb0e-a09a35914955
mySqrt1(x) = 
	fixedPoint3(averageDamp(function(y) /(x, y) end), 1.0)

# ╔═╡ 9481d639-2588-4980-b89c-3973b430aa19
mySqrt1(2.0)

# ╔═╡ 1341a65e-4036-4cb4-8c11-51b53abe2c81
mySqrt1(9.0)

# ╔═╡ 50f7fbb2-2b0d-4248-bb9b-5e5539a0ed02
mySqrt1(1000.0)

# ╔═╡ 84279927-18e6-4dce-b622-d7394243162c
mySqrt1(1000.0)^2

# ╔═╡ 8de553b3-28b4-4c72-b1cf-f3420d9df62e
let (x, average) = (2.0, (x, y) -> (x + y)/2.0)
	let fixPoint = fixedPoint3(averageDamp(function(y) x/y end), 1.0)
		plot(y->x/y, [0.5:0.1:4.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 4), aspect_ratio=1, framestyle=:zerolines, title="sqrt($x) := f-point($x):  {y|y >0, y->$x/y}")
		plot!([fixPoint, fixPoint], [-0.5, +2], line=(2, :magenta))
		plot!([-0.5, +2], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ 90dde354-4e26-41c4-8a45-c94f2d524b41
let (x, average) = (9.0, (x, y) -> (x + y)/2.0)
	let fixPoint = fixedPoint3(averageDamp(function(y) x/y end), 1.0)
		plot(y->x/y, [0.5:0.1:9.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 9), aspect_ratio=1, framestyle=:zerolines, title="sqrt($x) := f-point($x): {y|y>0, y->$x/y}")
		plot!([fixPoint, fixPoint], [-0.5, +4], line=(2, :magenta))
		plot!([-0.5, +4], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ 3b884275-d00c-44d6-82dc-93fdd164ef84
myCubeRoot(x) = 
	fixedPoint3(averageDamp(function(y) /(x, ^(y, 2)) end), 1.0)

# ╔═╡ b68f57d8-632c-44e8-b01f-97896eb61a87
myCubeRoot(8)

# ╔═╡ 4e9d7bdc-a11a-4a5e-8ce8-eb6729f8bb22
let (x, average) = (8.0, (x, y) -> (x + y)/2.0)
	let fixPoint = myCubeRoot(x)
		plot(y->x/y^2, [0.5:0.1:9.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 9), aspect_ratio=1, framestyle=:zerolines, title="cube-rt($x):=f-point($x):{y|y>0,y->$x/y^2}")
		plot!([fixPoint, fixPoint], [-0.5, +4], line=(2, :magenta))
		plot!([-0.5, +4], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ 476b8f63-3e5c-4ff4-9913-52d45cfbf5d2
myCubeRoot(1000)

# ╔═╡ 8c2f1771-6e34-4f5c-8bc3-6c44efcbd831
^(myCubeRoot(1000), 3)

# ╔═╡ 0f2fb30c-953c-4763-82ea-63cc7b655283
md"
---
#### 1.3.4.2 [Newton's method](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.4)
#### 1.3.4.2.1 SICP-Scheme-like *functional* Julia
"

# ╔═╡ 9721c79d-3108-4822-8e4e-6cf1832043c1
md"
###### if $$x \mapsto g(x)$$ is a differentiable function then the root $$x$$ of $$g(x)=0$$ is the fixed point of $$x \mapsto f(x)$$ , where:
$$f(x) = x - \frac{g(x)}{Dg(x)}$$

###### and $$Dg(x)$$ is the derivative of $$g(x)$$ evaluated at $$x$$:
$$Dg(x) = \frac{g(x+dx)-g(x)}{dx}\;.$$
"

# ╔═╡ adb7ddea-c6f1-4fdb-8ee8-d88f9d66245b
dx = 1.0E-5

# ╔═╡ a98ed3b7-3c29-43a2-b286-96201a90e3b0
md"
###### 1st (default) *untyped* method of function 'deriv'
"

# ╔═╡ 9cebf2db-98d3-45ff-a6c0-9aee5eef8800
function deriv(g)                      # higher order function
	x -> /(-(g(+(x, dx), g(x))), dx)   # return of anonymous function
end # function deriv

# ╔═╡ 5fd66bfc-79ed-4418-bb25-2c76ea5f85bc
cube(x) = ^(x, 3)

# ╔═╡ bf3e45d1-f1b4-4629-87ac-c8a201231486
md"
---
$$\frac{d x^3}{dx}=3x^2$$
---
"

# ╔═╡ cb39b588-c563-47cf-ac08-a128439982ea
md"
---
###### higher-order function *newtonTransform*:
$$f(x) := x - \frac{g(x)}{Dg(x)}$$

---
"

# ╔═╡ 632e3dcc-12ac-40f9-8175-8ca3c5f149c9
md"
###### 1st (default) *untyped* method of function 'newtonTransform'
"

# ╔═╡ c46bff7d-97b5-4ea6-983f-34a90bf994a4
md"
###### 1st (default) *untyped* method of function 'newtonsMethod'
"

# ╔═╡ 66dd1ad7-4d0e-4ced-bb5f-81b3cae32a3a
md"
###### Abstractions and first-class procedures
"

# ╔═╡ 2477acc6-2c99-41c6-8df9-e5d96b343686
md"
###### 1st (default) *untyped* method of function 'fixedPointOfTransform'
"

# ╔═╡ 7ea6c3cc-acf8-4264-bd38-c9e688540bec
function fixedPointOfTransform(g, transform, guess)
	fixedPoint3(transform(g), guess)
end # function fixedPointOfTransform

# ╔═╡ d07869fd-7609-4944-a000-eb771cca1084
md"
---
##### 1.3.4.2.2 idiomatic *imperative* or *typed* Julia
"

# ╔═╡ c28ec2c2-db7b-4486-b0b2-9bd4ddf88e5a
md"
###### 2nd (specialized) *typed* method of function 'deriv'
"

# ╔═╡ b46d2660-b9b5-483f-a23e-fb54e8da978d
function deriv(g::Function)::Function  # higher order function
	x -> (g(x + dx) - g(x))/dx         # return of anonymous function
end # function deriv

# ╔═╡ da57e720-bc7c-4d88-839b-bc6be801fd04
deriv(cube)(5)                   # should be 3*5^2 = 3*25 = 75

# ╔═╡ 3f410f9f-88a0-420d-8b24-46b0ddc03ec9
function newtonTransform(g)
	x -> x - /(g(x), deriv(cube))(x)
end # function newtonTransform

# ╔═╡ 17690bef-d073-4059-9326-1cbbdd04838c
md"
###### 2nd (specialized) *typed* method of function 'newtonTransform'
"

# ╔═╡ 1c6986f9-3fb7-4b5b-9602-c61c78aa2ab8
function newtonTransform(g::Function)::Function
	x -> x - g(x)/deriv(cube)(x)
end # function newtonTransform

# ╔═╡ 3ba4a946-4955-4ddd-91d4-a2a9b6254931
function newtonsMethod(g, guess)
	fixedPoint3(newtonTransform(g), guess)
end # newtonsMethod

# ╔═╡ bee17d7c-beb7-41ff-93c6-671528798b07
md"
###### 2nd (specialized) *typed* method of function 'newtonsMethod'
"

# ╔═╡ cfd15032-261a-49b5-8b48-5d8a5d61263c
function newtonsMethod(g::Function, guess::FloatOrSigned)::FloatOrSigned
	fixedPoint3(newtonTransform(g), guess)
end # function newtonsMethod

# ╔═╡ e2adc870-3c6f-4976-984a-ee25191f37ac
function mySqrt2(x)
	newtonsMethod(y -> -(^(y, 2), x), 1.0)
end # function mySqrt2

# ╔═╡ 8c45df3f-7677-417f-93ec-951cd7e42407
mySqrt2(2.0)

# ╔═╡ 670e471e-4a07-45e3-a912-170c94bb3743
mySqrt2(9.0)

# ╔═╡ 6b08ae2f-68fb-4ff1-9489-2a28da1e635b
mySqrt2(1000.0)

# ╔═╡ 76818ee1-925c-40db-9117-734a6127c2b7
^(mySqrt2(1000.0), 2)

# ╔═╡ aa829480-9608-448d-bf3d-d5bff22a0a7f
let (x, average) = (2.0, (x, y) -> (x + y)/2.0)
	let fixPoint = newtonsMethod(y -> y^2 - x, 1.0)
		plot(y->x/y, [0.5:0.1:4.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 4), aspect_ratio=1, framestyle=:zerolines, title="sqrt($x) := f-point($x): {y|y>0, y->$x/y}")
		plot!([fixPoint, fixPoint], [-0.5, +2], line=(2, :magenta))
		plot!([-0.5, +2], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ 6c7c3dda-27b6-4674-b83d-b38f7d050416
let (x, average) = (9.0, (x, y) -> (x + y)/2.0)
	let fixPoint = newtonsMethod(y -> y^2 - x, 1.0)
		plot(y->x/y, [0.5:0.1:4.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 4), aspect_ratio=1, framestyle=:zerolines, title="sqrt($x) := f-point($x): {y|y >0, y->$x/y}")
		plot!([fixPoint, fixPoint], [-0.5, +4], line=(2, :magenta))
		plot!([-0.5, +4], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ ebcf1358-dbc0-4c6e-9a16-67da0144aa49
md"
###### 2nd (specialized) *typed* method of function 'fixedPointOfTransform'
"

# ╔═╡ 2bd909d0-69b7-40ff-b51b-7330e3f7bb22
function fixedPointOfTransform(g::Function, transform::Function, guess::FloatOrSigned)::FloatOrSigned
	fixedPoint3(transform(g), guess)
end # function fixedPointOfTransform

# ╔═╡ e1e9e42c-4f18-4460-8d10-4242922ffa32
function mySqrt3(x)
	fixedPointOfTransform(y -> /(x, y), averageDamp, 1.0)
end # function mySqrt3

# ╔═╡ 7be65548-fd6f-4df7-9ac5-8613d7b4252d
mySqrt3(2.0)

# ╔═╡ 7575ace3-5894-494b-9fd2-d2559f7b67cf
mySqrt3(9.0)

# ╔═╡ 0e3f8751-c551-4264-8016-810ed7348281
mySqrt3(1000.0)

# ╔═╡ 0f84bc85-ff1a-4578-a320-c8fcddd80596
^(mySqrt3(1000.0), 2)

# ╔═╡ 108a414a-f2df-4944-8a17-2b392cd35375
let (x, average) = (2.0, (x, y) -> (x + y)/2.0)
	let fixPoint = fixedPointOfTransform(y -> x/y, averageDamp, 1.0)
		plot(y->x/y, [0.5:0.1:4.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 4), aspect_ratio=1, framestyle=:zerolines, title="sqrt($x) := f-point($x): {y|y>0, y->$x/y}")
		plot!([fixPoint, fixPoint], [-0.5, +2], line=(2, :magenta))
		plot!([-0.5, +2], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ 881062cb-646a-49c9-a983-ff95b5df51a1
let (x, average) = (9.0, (x, y) -> (x + y)/2.0)
	let fixPoint = fixedPointOfTransform(y -> x/y, averageDamp, 1.0)
		plot(y->x/y, [0.5:0.1:4.0], size=(500, 500),line=:darkblue, xlim=(-0.5, 4), aspect_ratio=1, framestyle=:zerolines, title="sqrt($x) := f-point($x): {y|y>0, y->$x/y}")
		plot!([fixPoint, fixPoint], [-0.5, +4], line=(2, :magenta))
		plot!([-0.5, +4], [fixPoint, fixPoint], line=(2, :magenta))
	end
end

# ╔═╡ 5790449c-19c6-4a54-b4e1-2178724aecaa
md"
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**, Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/26

"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"

[compat]
Plots = "~1.25.10"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "b750bcc41a6e4d5ca929b0db289bb286eaa25ca1"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f9982ef575e19b0e5c7a98c6e75ee496c0f73a93"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.12.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "9f836fb62492f4b0f0d3b06f55983f2704ed0883"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.0"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a6c850d77ad5118ad3be4bd188919ce97fffac47"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.0+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "2a8650452c07a9c89e6a58f296fd638fadaca021"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.11"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "648107615c15d4e09f7eca16307bc821c1f718d8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.13+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "13468f237353112a01b2d6b32f3d0f80219944aa"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.2"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "6f1b25e8ea06279b5689263cc538f51331d7ca17"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.1.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "d9c49967b9948635152edaa6a91ca4f43be8d24c"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.25.10"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "2cf929d64681236a2e074ffafb8d568733d2e6af"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "c6c0f690d0cc7caddb74cef7aa847b824a16b256"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "37c1631cb3cc36a535105e6d5557864c82cd8c2b"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "95c6a5d0e8c69555842fc4a927fc485040ccc31c"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.3.5"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c3d8ba7f3fa0625b062b82853a7d5229cb728b6b"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.1"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "d21f2c564b21a202f4677c0fba5b5ee431058544"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.4"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "bb1064c9a84c52e277f1096cf41434b675cd368b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "66d72dc6fcc86352f01676e8f0f698562e60510f"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.23.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─3ab9a060-01a8-11ec-26b0-f58b434fab4c
# ╟─a378aca9-2d79-4124-bea6-ba62ab1c3d83
# ╟─e4443263-e26f-462e-b11a-294fbd259e9a
# ╠═3df9dd3c-058b-47b6-b39d-570443cc51b9
# ╠═2a56d3e3-bb2e-4382-864c-9d3c099cb177
# ╠═53b7806d-489d-45ba-80a9-17bf9ebfc434
# ╠═f5a15cb0-a039-43a1-ba4c-2674e672e6ff
# ╠═81ecbeb5-7c4d-40e8-aeb1-2386277de71d
# ╠═1fc90de5-9e3d-417b-8475-1ae507eb355c
# ╠═78462eeb-5f46-48e8-bb0e-a09a35914955
# ╠═9481d639-2588-4980-b89c-3973b430aa19
# ╠═50cbd85a-2a84-4f2c-836b-7a121a2f4a89
# ╟─8de553b3-28b4-4c72-b1cf-f3420d9df62e
# ╠═1341a65e-4036-4cb4-8c11-51b53abe2c81
# ╟─90dde354-4e26-41c4-8a45-c94f2d524b41
# ╠═50f7fbb2-2b0d-4248-bb9b-5e5539a0ed02
# ╠═84279927-18e6-4dce-b622-d7394243162c
# ╟─73c57933-68f8-4e92-8a2a-edf4da95d723
# ╠═3b884275-d00c-44d6-82dc-93fdd164ef84
# ╠═b68f57d8-632c-44e8-b01f-97896eb61a87
# ╟─4e9d7bdc-a11a-4a5e-8ce8-eb6729f8bb22
# ╠═476b8f63-3e5c-4ff4-9913-52d45cfbf5d2
# ╠═8c2f1771-6e34-4f5c-8bc3-6c44efcbd831
# ╟─f05fca2a-638f-47f3-9b64-b1845b4169c7
# ╠═9b740450-2b0f-4955-a2c7-06b926cd7191
# ╠═061844e7-ff4d-4697-9179-7470ca4a0f19
# ╠═744ed935-2298-467b-8042-a4ff00f3e40c
# ╟─0f2fb30c-953c-4763-82ea-63cc7b655283
# ╟─9721c79d-3108-4822-8e4e-6cf1832043c1
# ╠═adb7ddea-c6f1-4fdb-8ee8-d88f9d66245b
# ╟─a98ed3b7-3c29-43a2-b286-96201a90e3b0
# ╠═9cebf2db-98d3-45ff-a6c0-9aee5eef8800
# ╠═5fd66bfc-79ed-4418-bb25-2c76ea5f85bc
# ╟─bf3e45d1-f1b4-4629-87ac-c8a201231486
# ╠═da57e720-bc7c-4d88-839b-bc6be801fd04
# ╟─cb39b588-c563-47cf-ac08-a128439982ea
# ╟─632e3dcc-12ac-40f9-8175-8ca3c5f149c9
# ╠═3f410f9f-88a0-420d-8b24-46b0ddc03ec9
# ╟─c46bff7d-97b5-4ea6-983f-34a90bf994a4
# ╠═3ba4a946-4955-4ddd-91d4-a2a9b6254931
# ╠═e2adc870-3c6f-4976-984a-ee25191f37ac
# ╟─aa829480-9608-448d-bf3d-d5bff22a0a7f
# ╠═8c45df3f-7677-417f-93ec-951cd7e42407
# ╟─6c7c3dda-27b6-4674-b83d-b38f7d050416
# ╠═670e471e-4a07-45e3-a912-170c94bb3743
# ╠═6b08ae2f-68fb-4ff1-9489-2a28da1e635b
# ╠═76818ee1-925c-40db-9117-734a6127c2b7
# ╟─66dd1ad7-4d0e-4ced-bb5f-81b3cae32a3a
# ╟─2477acc6-2c99-41c6-8df9-e5d96b343686
# ╠═7ea6c3cc-acf8-4264-bd38-c9e688540bec
# ╠═e1e9e42c-4f18-4460-8d10-4242922ffa32
# ╟─108a414a-f2df-4944-8a17-2b392cd35375
# ╠═7be65548-fd6f-4df7-9ac5-8613d7b4252d
# ╟─881062cb-646a-49c9-a983-ff95b5df51a1
# ╠═7575ace3-5894-494b-9fd2-d2559f7b67cf
# ╠═0e3f8751-c551-4264-8016-810ed7348281
# ╠═0f84bc85-ff1a-4578-a320-c8fcddd80596
# ╟─d07869fd-7609-4944-a000-eb771cca1084
# ╟─c28ec2c2-db7b-4486-b0b2-9bd4ddf88e5a
# ╠═b46d2660-b9b5-483f-a23e-fb54e8da978d
# ╟─17690bef-d073-4059-9326-1cbbdd04838c
# ╠═1c6986f9-3fb7-4b5b-9602-c61c78aa2ab8
# ╟─bee17d7c-beb7-41ff-93c6-671528798b07
# ╠═cfd15032-261a-49b5-8b48-5d8a5d61263c
# ╟─ebcf1358-dbc0-4c6e-9a16-67da0144aa49
# ╠═2bd909d0-69b7-40ff-b51b-7330e3f7bb22
# ╟─5790449c-19c6-4a54-b4e1-2178724aecaa
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
