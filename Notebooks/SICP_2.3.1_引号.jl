### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 353d3930-0a7c-11ec-22fb-2ba2ded89523
md"
======================================================================================
#### [SICP\_2.3.1\_Quotation.jl（引用）](https://sarabander.github.io/sicp/html/2_002e3.xhtml#g_t2_002e3_002e1)
======================================================================================
"

# ╔═╡ 54d272ec-9bb2-4d71-a712-9bd3ca735359
struct Cons
	car
	cdr
end # struct Cons

# ╔═╡ 98d8a477-ef35-4413-b5bf-16ca522b5211
md"
###### 3 methods of function $$cons$$
"

# ╔═╡ 4fd917ac-bff2-4ade-af7d-68feab1d5de8
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ 4f9cf503-e6c0-4fcf-bfca-5219e086423e
function cons(car::Any, list2::Vector)::Vector
	conslist = list2
	pushfirst!(conslist, car)
	conslist
end # function cons

# ╔═╡ 1f6f23aa-571b-4b0a-b700-4faf6da3e781
function cons(list1::Vector, list2::Vector)::Vector
	conslist = push!([], list1)
	for xi in list2
		push!(conslist, xi)
	end # for
	conslist
end # function cons

# ╔═╡ 41911af6-dc2d-4088-ab2c-c239f92b2136
md"
###### 2 methods of function $$car$$
"

# ╔═╡ 1f75b84e-babe-4f6c-af9c-ca7247d8c626
car(cell::Cons) = cell.car

# ╔═╡ c3e0b7ba-115d-499c-9f30-21d3dc3a92cd
car(x::Vector) = x[1]

# ╔═╡ 05ca7292-f9a0-4c30-bec5-094062be6199
md"
###### 2 methods of function $$cdr$$
"

# ╔═╡ 3b7b8373-2a1d-400c-a67c-b6ad69d5a4f1
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ c0f13087-edc7-433b-b715-e408386e11f2
cdr(x::Vector) = x[2:end]

# ╔═╡ 35d094a8-a129-4d0b-b4eb-bd714f6e71c6
md"
###### Definition of symbols
"

# ╔═╡ f4dd7244-0618-457d-90c6-3f5479d1f35b
const a = 1

# ╔═╡ 6c5718e3-aaae-47f9-a98d-33e7c9f56d30
const b = 2

# ╔═╡ d3c5964f-b96f-482d-a4a8-f587d3244192
md"
###### Definition of Scheme-like function $$list$$
"

# ╔═╡ 4361cbda-74d6-4716-942d-b4a37d545ed5
function list(xs...)
	push!([], xs...)
end

# ╔═╡ 67a71799-3e40-48ef-bd29-a8bba877ed7a
list(:a, :b, :c, :d)

# ╔═╡ 04caf83a-9df8-41e2-835d-1bbfc7e6698d
list(23, 45, 17)

# ╔═╡ 0a507b0a-b377-4215-b5ff-cd377162357d
list(list(:Norah, 12), list(:Molly, 9), list(:Anna, 7), list(:Lauren, 6), list(:Charlotte, 4))

# ╔═╡ 6741b890-392a-48f3-b970-b2a289862875
list(a, b)

# ╔═╡ 4ce122e0-9a41-4b66-bf06-501f42aaea46
list(:a, :b)

# ╔═╡ a360ee12-21e7-4742-9469-d8724be60546
list(:a, b)

# ╔═╡ 2b1ee845-cca0-42fb-a88e-987d26445f8e
:(a) == :a

# ╔═╡ 80d84f79-9654-470b-b21f-0b0fb5be1f80
:(a, b, c)

# ╔═╡ 65251062-5e93-4575-b5e0-5b4e489ec870
typeof(:(a, b, c))

# ╔═╡ f311690a-a9f9-436a-a977-5532605a5f71
dump(:(a, b, c))

# ╔═╡ 63ba970c-88f8-4586-b042-27527d2d8e9f
:(a, b, c).head

# ╔═╡ b0b672ef-e8d5-4712-bb33-015279d651ae
:(a, b, c).args

# ╔═╡ b1bf6c2b-154b-46dc-80c3-2c931e00c52f
:(a, b, c).args[1]

# ╔═╡ ff0f7f24-23d9-4481-8990-b098c31bd780
:(a, b, c).args[2:end]

# ╔═╡ 2ae5f8a3-5b8c-4551-8220-870d40e0eb5d
function memq1(item, list)
	#---------------------------------------
	null = isempty
	#---------------------------------------
	if null(list)
		false
	elseif item == car(list)
		list
	else memq1(item, cdr(list))
	end # if
end # function memq1

# ╔═╡ 8dbe5da1-6a52-4beb-8be3-2a49cd248edb
memq1(:apple, [:pear, :banana, :prune])

# ╔═╡ c591ac8a-b2d8-4d11-b416-1971077cf416
memq1(:apple, [:x, [:apple, :sauce], :y, :apple, :pear, :prune])

# ╔═╡ f6b18ff5-05b6-413a-8cde-a4f364fca029
md"
###### idiomatic Julia with $$while, return$$
"

# ╔═╡ f46b37a5-6112-4931-bc77-deb58a1f1dab
# idiomatic Julia with 'while' and 'return'
function memq2(item, list)
	#---------------------------------------
	null = isempty
	#---------------------------------------
	while !null(list)
		if item == car(list)
			return list
		else 
			list = cdr(list)
		end # if
	end # while
	false
end # function memq2

# ╔═╡ b7055361-cda1-4eb9-b32e-49675a851385
memq2(:apple, [:pear, :banana, :prune])

# ╔═╡ faf28e99-40de-464b-8a3a-011689687d30
memq2(:apple, [:x, [:apple, :sauce], :y, :apple, :pear, :prune])

# ╔═╡ d3f74e3d-a30f-49d0-a68d-0bcbd3342be7
# idiomatic Julia with 'while' and 'return'
function memq3(item, list)
	#---------------------------------------
	null = isempty
	#---------------------------------------
	for i in eachindex(list)
		if item == car(list)
			return list
		else
			list = cdr(list)
		end # if
	end # for
	false
end # function memq3

# ╔═╡ 8a179b6d-a76f-4bfd-b47c-1d4af7797f92
memq3(:apple, [:pear, :banana, :prune])

# ╔═╡ f9f772a3-805f-4b99-ace4-9e17c26e5302
memq3(:apple, [:x, [:apple, :sauce], :y, :apple, :pear, :prune])

# ╔═╡ 67816956-b1c3-4334-976f-26b3a1852a81
md"
###### idiomatic Julia with $$findfirst$$
"

# ╔═╡ fb134d51-0c6c-4258-a4ef-903d62d94ef5
findfirst((x -> x == :apple), [:x, [:apple, :sauce], :y, :apple, :pear, :prune])

# ╔═╡ 6c079e06-311b-4bb2-a8e2-3c7b154a4ba8
function memq4(item, list)
	index = findfirst(x -> x == item, list)
	if index !== nothing
		list[index:end]
	else
		index
	end # if
end # function memq4

# ╔═╡ db3624af-6052-453c-8e76-140d14d091eb
memq4(:apple, [:pear, :banana, :prune])

# ╔═╡ fb395bf2-da59-482c-afad-83668c8b674a
memq4(:apple, [:x, [:apple, :sauce], :y, :apple, :pear, :prune])

# ╔═╡ cc75410b-3f61-47e1-9d86-311a14b6681e
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/09/11

---
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
# ╟─353d3930-0a7c-11ec-22fb-2ba2ded89523
# ╠═54d272ec-9bb2-4d71-a712-9bd3ca735359
# ╟─98d8a477-ef35-4413-b5bf-16ca522b5211
# ╠═4fd917ac-bff2-4ade-af7d-68feab1d5de8
# ╠═4f9cf503-e6c0-4fcf-bfca-5219e086423e
# ╠═1f6f23aa-571b-4b0a-b700-4faf6da3e781
# ╟─41911af6-dc2d-4088-ab2c-c239f92b2136
# ╠═1f75b84e-babe-4f6c-af9c-ca7247d8c626
# ╠═c3e0b7ba-115d-499c-9f30-21d3dc3a92cd
# ╟─05ca7292-f9a0-4c30-bec5-094062be6199
# ╠═3b7b8373-2a1d-400c-a67c-b6ad69d5a4f1
# ╠═c0f13087-edc7-433b-b715-e408386e11f2
# ╟─35d094a8-a129-4d0b-b4eb-bd714f6e71c6
# ╠═67a71799-3e40-48ef-bd29-a8bba877ed7a
# ╠═04caf83a-9df8-41e2-835d-1bbfc7e6698d
# ╠═0a507b0a-b377-4215-b5ff-cd377162357d
# ╠═f4dd7244-0618-457d-90c6-3f5479d1f35b
# ╠═6c5718e3-aaae-47f9-a98d-33e7c9f56d30
# ╟─d3c5964f-b96f-482d-a4a8-f587d3244192
# ╠═4361cbda-74d6-4716-942d-b4a37d545ed5
# ╠═6741b890-392a-48f3-b970-b2a289862875
# ╠═4ce122e0-9a41-4b66-bf06-501f42aaea46
# ╠═a360ee12-21e7-4742-9469-d8724be60546
# ╠═2b1ee845-cca0-42fb-a88e-987d26445f8e
# ╠═80d84f79-9654-470b-b21f-0b0fb5be1f80
# ╠═65251062-5e93-4575-b5e0-5b4e489ec870
# ╠═f311690a-a9f9-436a-a977-5532605a5f71
# ╠═63ba970c-88f8-4586-b042-27527d2d8e9f
# ╠═b0b672ef-e8d5-4712-bb33-015279d651ae
# ╠═b1bf6c2b-154b-46dc-80c3-2c931e00c52f
# ╠═ff0f7f24-23d9-4481-8990-b098c31bd780
# ╠═2ae5f8a3-5b8c-4551-8220-870d40e0eb5d
# ╠═8dbe5da1-6a52-4beb-8be3-2a49cd248edb
# ╠═c591ac8a-b2d8-4d11-b416-1971077cf416
# ╟─f6b18ff5-05b6-413a-8cde-a4f364fca029
# ╠═f46b37a5-6112-4931-bc77-deb58a1f1dab
# ╠═b7055361-cda1-4eb9-b32e-49675a851385
# ╠═faf28e99-40de-464b-8a3a-011689687d30
# ╠═d3f74e3d-a30f-49d0-a68d-0bcbd3342be7
# ╠═8a179b6d-a76f-4bfd-b47c-1d4af7797f92
# ╠═f9f772a3-805f-4b99-ace4-9e17c26e5302
# ╟─67816956-b1c3-4334-976f-26b3a1852a81
# ╠═fb134d51-0c6c-4258-a4ef-903d62d94ef5
# ╠═6c079e06-311b-4bb2-a8e2-3c7b154a4ba8
# ╠═db3624af-6052-453c-8e76-140d14d091eb
# ╠═fb395bf2-da59-482c-afad-83668c8b674a
# ╟─cc75410b-3f61-47e1-9d86-311a14b6681e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
