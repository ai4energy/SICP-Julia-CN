### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 845f4e62-0d86-11ec-27a5-cb54b6b3e50e
md"
======================================================================================
#### [SICP\_2.3.2\_Example\_SymbolicDifferentiation.jl（实例： 符号求导）](https://sarabander.github.io/sicp/html/2_002e3.xhtml#g_t2_002e3_002e2)
======================================================================================
"

# ╔═╡ a1015f94-2bc3-435e-b97c-dfb213b003e9
md"
##### structure $$Cons$$, constructors $$cons, list$$, selectors $$car, cdr$$
"

# ╔═╡ 644bcfa4-700a-43df-9ba1-3b240f5d1344
struct Cons
	car
	cdr
end

# ╔═╡ 8b8e28c7-6d81-4c8c-9dee-5b2be510871b
car(cell::Cons) = cell.car

# ╔═╡ edba599c-194b-45ac-a8cd-b3f7ba06f9ab
car(x::Vector) = x[1]

# ╔═╡ f5627209-b239-4480-8f30-b8093ac7f240
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ eda10202-c5e3-4654-9c20-6be355dcb630
cdr(x::Vector) = x[2:end]

# ╔═╡ fb1c5d22-54f6-490d-9af0-33ea8e0038b9
function list(xs...)
	push!([], xs...)
end

# ╔═╡ e3df9cf1-69ca-462a-90a9-1ac444f45026
md"
---
##### Representing algebraic expressions
"

# ╔═╡ 3369f0d7-7b81-4a83-95a0-f7cb9f9cb2d1
isvariable(x) = typeof(x) == Symbol

# ╔═╡ c72e1835-30b4-4c70-b0d6-9053fc51219d
isvariable(:a)

# ╔═╡ c3afc2a8-6a9f-407d-a6e6-31f809dc313b
isvariable(4.0)

# ╔═╡ 59457e51-0282-44e1-9b11-e8357a3a088a
isnumber(x) = typeof(x) <: Real

# ╔═╡ a6d3b688-bf1c-45e4-98ad-0515e13eb1b6
isnumber(4)

# ╔═╡ 22d58fcc-ccc9-4d71-89f9-58b4c1e7533b
isnumber(4.0)

# ╔═╡ 93e69708-0ac0-4070-b41a-4fcf7f876b22
isnumber(:x)

# ╔═╡ 343378d9-4bf4-4aeb-a689-491ae9273cfa
function is_same_variable(v1, v2)
	isvariable(v1) && isvariable(v2) && v1 == v2
end

# ╔═╡ c844eca6-2ad2-4773-a90b-838cf57e8edd
is_same_variable(:x, :x)

# ╔═╡ 3601d9e4-8f21-4248-b1ba-46dbaad91034
is_same_variable(:x, :y)

# ╔═╡ a681f393-6956-43e4-a58b-f2e75a0cdf8d
make_sum1(a1, a2) = list(:+, a1, a2)

# ╔═╡ 2bebf3d3-f6ca-4883-9b64-42e54843805f
make_product1(a1, a2) = list(:*, a1, a2)

# ╔═╡ da37b342-c51c-47a5-aeb1-abeac8e9ef6e
make_sum1(5, 6)

# ╔═╡ a4f0c949-2140-4405-b37e-b9a96136431d
make_product1(5, 6)

# ╔═╡ cad3435d-df93-4d04-a486-6ed4f7e63037
function ispair(x) 
	((typeof(x) == Vector{Symbol} || 
	  typeof(x) == Vector{Any}) && length(x) ≥ 2 ) || 
	  typeof(x) == Cons 
end # function ispair

# ╔═╡ bbf6a9b3-1645-4d1a-bcc8-e967018f106e
Cons(1,2)

# ╔═╡ 897a59b1-ef96-44cf-b8fc-8e805ecf23f2
ispair(Cons(1,2))

# ╔═╡ b86a08c4-5a51-4b69-bec3-20cc524e32a5
ispair([])

# ╔═╡ 6e25b818-6ef5-4719-b805-e8a9ee29d427
ispair([:a])

# ╔═╡ 6cb2e77b-e4a8-4a39-8a36-25bb18640fac
l1 = list(:a, :b)

# ╔═╡ c6cb3883-c36f-4cd3-aace-ab3f0607288b
typeof(l1) == Vector{Any}

# ╔═╡ 5c98be42-20f5-49af-9200-35885d51ec02
ispair(l1)

# ╔═╡ 4f73fd43-bc88-4117-b911-93225fb26260
function issum(x)
	ispair(x) && (car(x) == :+)
end

# ╔═╡ f4ada911-f4a7-486d-a3c6-358c2d7cdc95
issum([:+, 2, 3.0])

# ╔═╡ 30490b94-283f-4570-8672-a21228c7407d
make_sum1(5, 6)

# ╔═╡ 6b6ea385-b1fc-46e2-8870-6a354df3b8fb
issum(make_sum1(5, 6))

# ╔═╡ eafe6473-20f7-4c1a-a4da-471122116589
issum(make_product1(5, 6))

# ╔═╡ da705fc0-4d7b-44d9-b622-806d1435e599
function addend(s)
	#--------------------------
	cadr(s) = car(cdr(s))
	#--------------------------
	cadr(s)
end 

# ╔═╡ 8f93dd95-39a2-4386-826a-882e5e54aaa7
addend(make_sum1(5, 6))

# ╔═╡ 429a0d1e-f062-4c42-a02c-712ca40fb02b
function augend(s) 
	#--------------------------
	caddr(s) = car(cdr(cdr(s)))
	#--------------------------
	caddr(s)
end

# ╔═╡ ad4a7cbb-2eeb-4d97-9c3e-a7b6474cf69b
augend(make_sum1(5, 6))

# ╔═╡ 9cfba2ff-1644-4c09-8bb5-3b68aa0acd20
function isproduct(x)
	ispair(x) && (car(x) == :*)
end

# ╔═╡ ba1ab835-99bc-4e4f-98a8-98584ca31800
isproduct(make_product1(5, 6))

# ╔═╡ ccd85055-d249-48db-b54c-ad3ccdc40086
function multiplier(p)
	#--------------------------
	cadr(s) = car(cdr(s))
	#--------------------------
	cadr(p)
end 

# ╔═╡ ad8288d1-87b5-4854-a4c3-ed0085a929c5
multiplier(make_product1(5, 6))

# ╔═╡ 8539426f-6af7-4285-a84b-14e929ced529
function multiplicand(p) 
	#--------------------------
	caddr(s) = car(cdr(cdr(s)))
	#--------------------------
	caddr(p)
end

# ╔═╡ 0f497ebf-8060-4e39-acbb-48c19354e81b
multiplicand(make_product1(5, 6))

# ╔═╡ c240ed6d-55eb-42cf-aa6f-090b2dbfd1f0
md"
---
##### The differentiation program with abstract data
"

# ╔═╡ 68922108-5e0e-4698-b6eb-0a16543c4fb1
function deriv1(exp, var)
	if isnumber(exp)
		0
	elseif isvariable(exp) 
		is_same_variable(exp, var) ? 1 : 0
	elseif issum(exp)
		make_sum1(deriv1(addend(exp), var), deriv1(augend(exp), var))
	elseif isproduct(exp)
		make_sum1(make_product1(multiplier(exp), deriv1(multiplicand(exp), var)),
			make_product1(deriv1(multiplier(exp), var), multiplicand(exp)))
	else "unknown expression type"
	end
end

# ╔═╡ 771cf918-3b39-4c40-9251-e2ca8cee9fdf
md"
---
##### Applications
"

# ╔═╡ ffe27413-d324-422e-a85c-99dd07875873
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(3) = 0$$
"

# ╔═╡ 8a9cb1cb-cc15-4957-869a-550cc45c6a76

deriv1(3, :x) 

# ╔═╡ dfafda3a-b6ea-4f86-ab41-fed695b07701
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(x) = 1$$
"

# ╔═╡ d85c8936-f52a-4d17-b850-493b72081c75
deriv1(:x, :x)

# ╔═╡ ac7a8269-71f2-4c60-b2f1-7303df3d9903
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(y) = 0$$
"

# ╔═╡ 5b86fd00-1918-428b-83db-02bc01c77096
deriv1(:y, :x)

# ╔═╡ 78e30793-0f6e-476a-8253-0673f9c0f9a3
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(3+x) = 0+1$$
"

# ╔═╡ 3abfd313-abf2-46be-b3e7-c8084ae56b26
deriv1(list(:+, 3, :x), :x)

# ╔═╡ 908f4d63-65f3-4baa-b0f5-14066e759c68
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(x+3) = 1+0$$
"

# ╔═╡ 3a823fa2-8c63-4c62-b8a8-5e909a0495dd
deriv1(list(:+, :x, 3), :x)

# ╔═╡ 89e2bec3-a601-48d1-bd39-25621cd1b5c7
md"
---
$$\frac{\mathrm{d}(x*y)}{\mathrm{d}x} = (x*0)+(1*y)$$
"

# ╔═╡ f06ccd1d-443e-4ebe-8bc0-520b3403be62
deriv1(list(:*, :x, :y), :x)

# ╔═╡ bf11d1eb-7cbc-4390-afe0-40848505390c
deriv1([:*, :x, :y], :x)

# ╔═╡ 89f93941-aa5a-4048-9853-babdb09fe3a2
ispair([:*, :x, :y])

# ╔═╡ d0991e11-85eb-46af-89a2-d2664b85eeeb
list(:*, [:*, :x, :y], [:+, :x, 3])

# ╔═╡ 67a60f41-ca28-4ff2-bfdf-5ff04c279a65
list(:*, list(:*, :x, :y), list(:+, :x, 3))

# ╔═╡ 46aed6fe-43db-4895-8723-514878c90399
typeof(list(:*, [:*, :x, :y], [:+, :x, 3]))

# ╔═╡ d70e7c9a-0c5b-4661-bc67-2cd7e88580b7
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}((x*y)*(x+3)) = \frac{\mathrm{d}}{\mathrm{d}x}(x^2y+3xy) = 2xy + 3y$$
"

# ╔═╡ f1a89f14-b420-4024-bd08-7bcc4a6b8e54
deriv1(list(:*, [:*, :x, :y], [:+, :x, 3]), :x)

# ╔═╡ b4e2eee7-da7e-4b19-bb4a-5cc30712acef
deriv1(list(:*, list(:*, :x, :y), list(:+, :x, 3)), :x)

# ╔═╡ 7811f0ee-18f1-4a7c-8f32-84207f53f8c1
md"
##### Reductions
"

# ╔═╡ a13774e5-d336-4064-911d-89afd2dba785
iszero(0.0)

# ╔═╡ 96169b60-f329-459d-93d5-7d88b84ed584
function is_equal_number(exp, num)
	if exp == num
		true
	else false
	end
end

# ╔═╡ b849965e-1a8f-4cdb-95ba-aae2fa1cb17c
is_equal_number(0, 0.0)

# ╔═╡ e8164515-4e43-4ffb-8747-1e99e36fe768
is_equal_number(2, 2.0)

# ╔═╡ a54f48d7-9eb0-454a-8d45-5f6ddc00bc59
is_equal_number(2, 3.0)

# ╔═╡ 14f579c1-c76a-4d33-8dc0-0ebb36626ccf
function make_sum2(a1, a2)
	if is_equal_number(a1, 0.0)
		a2
	elseif is_equal_number(a2, 0.0)
		a1
	elseif isnumber(a1) && isnumber(a2) 
		a1 + a2
	else list(:+, a1, a2)
	end
end

# ╔═╡ 10914935-3607-4e94-9051-a14ba0eaf4cb
make_sum1(5, 6)

# ╔═╡ ce0d69d9-8ef8-4fb1-89c7-6c8919fdcbcd
make_sum2(5, 6)

# ╔═╡ 4fa0d90a-9d11-4e82-bdf9-03a152f689e3
function make_product2(m1, m2)
	if is_equal_number(m1, 0.0) || is_equal_number(m2, 0.0)
		0.0
	elseif is_equal_number(m1, 1.0)
		m2
	elseif is_equal_number(m2, 1.0)
		m1
	elseif isnumber(m1) && isnumber(m2) 
		m1 * m2
	else list(:*, m1, m2)
	end
end

# ╔═╡ ae3aaeb5-4b5d-4d51-98e2-859e794f9581
make_product1(5, 6)

# ╔═╡ 6c54a837-9f55-4ed2-b45f-6edd58ab780e
make_product2(5, 6)

# ╔═╡ 37aa19fb-0ef4-4cdb-8514-5d9aeed5392a
function deriv2(exp, var)
	if isnumber(exp)
		0
	elseif isvariable(exp) 
		is_same_variable(exp, var) ? 1 : 0
	elseif issum(exp)
		make_sum2(deriv2(addend(exp), var), deriv2(augend(exp), var))
	elseif isproduct(exp)
		make_sum2(make_product2(multiplier(exp), deriv2(multiplicand(exp), var)),
			make_product2(deriv2(multiplier(exp), var), multiplicand(exp)))
	else "unknown expression type"
	end
end

# ╔═╡ 7413756e-7918-49f8-9f1a-a9e3e9ab34ba
md"
---
##### Applications with reductions
"

# ╔═╡ 77a7116b-c42e-41eb-adbc-00bb1485fe29
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(3) = 0$$
"

# ╔═╡ 3ca02591-5b87-423c-8eea-a32b3d90d1a8
deriv2(3, :x) 

# ╔═╡ 5eaefcd0-9b6d-4601-a8ef-e59bb32afcb1
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(y) = 0$$
"

# ╔═╡ 708e1ba2-9c0e-475e-9e28-dbf45de18f06
deriv2(:y, :x)

# ╔═╡ cfaf861c-25ff-40c9-841c-90bf209d7eb5
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(x) = 1$$
"

# ╔═╡ e5b19433-dc9e-4695-9ccf-761dd40ddcb7
deriv2(:x, :x)

# ╔═╡ 9805dea6-6785-4b90-92a4-deb1616f23fe
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}(x+3) = 1+0 = 1$$
"

# ╔═╡ 88e589b9-ee19-465d-8f88-8a1a9afd0cde
deriv2(list(:+, :x, 3), :x)

# ╔═╡ c05f064d-2148-44f7-9cce-d64c464dd1f6
md"
---
$$\frac{\mathrm{d}(x*y)}{\mathrm{d}x} = (x*0)+(1*y) = y$$
"

# ╔═╡ e0a7892b-f865-4588-88c0-d089638726ec
deriv2(list(:*, :x, :y), :x)

# ╔═╡ 2dac06cb-afd6-4393-abfc-8d5c2602ee34
md"
---
$$\frac{\mathrm{d}}{\mathrm{d}x}((x*y)*(x+3)) = \frac{\mathrm{d}}{\mathrm{d}x}(x^2y+3xy) = 2xy + 3y$$
"

# ╔═╡ b9122f28-834d-445c-8e77-dd5eb15f9f3c
deriv2([:*, [:*, :x, :y], [:+, :x, 3]], :x)

# ╔═╡ 105045e0-8cd9-410b-bc36-e7dbf1493bff
deriv2(list(:*, [:*, :x, :y], [:+, :x, 3]), :x)

# ╔═╡ 28047c93-08ce-498c-ab8a-a2de99db9c7a
deriv2(list(:*, list(:*, :x, :y), list(:+, :x, 3)), :x)

# ╔═╡ fb63509a-2c06-44f7-b495-956f65a28c07
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/09/12

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
# ╟─845f4e62-0d86-11ec-27a5-cb54b6b3e50e
# ╟─a1015f94-2bc3-435e-b97c-dfb213b003e9
# ╠═644bcfa4-700a-43df-9ba1-3b240f5d1344
# ╠═8b8e28c7-6d81-4c8c-9dee-5b2be510871b
# ╠═edba599c-194b-45ac-a8cd-b3f7ba06f9ab
# ╠═f5627209-b239-4480-8f30-b8093ac7f240
# ╠═eda10202-c5e3-4654-9c20-6be355dcb630
# ╠═fb1c5d22-54f6-490d-9af0-33ea8e0038b9
# ╟─e3df9cf1-69ca-462a-90a9-1ac444f45026
# ╠═3369f0d7-7b81-4a83-95a0-f7cb9f9cb2d1
# ╠═c72e1835-30b4-4c70-b0d6-9053fc51219d
# ╠═c3afc2a8-6a9f-407d-a6e6-31f809dc313b
# ╠═59457e51-0282-44e1-9b11-e8357a3a088a
# ╠═a6d3b688-bf1c-45e4-98ad-0515e13eb1b6
# ╠═22d58fcc-ccc9-4d71-89f9-58b4c1e7533b
# ╠═93e69708-0ac0-4070-b41a-4fcf7f876b22
# ╠═343378d9-4bf4-4aeb-a689-491ae9273cfa
# ╠═c844eca6-2ad2-4773-a90b-838cf57e8edd
# ╠═3601d9e4-8f21-4248-b1ba-46dbaad91034
# ╠═a681f393-6956-43e4-a58b-f2e75a0cdf8d
# ╠═2bebf3d3-f6ca-4883-9b64-42e54843805f
# ╠═da37b342-c51c-47a5-aeb1-abeac8e9ef6e
# ╠═a4f0c949-2140-4405-b37e-b9a96136431d
# ╠═cad3435d-df93-4d04-a486-6ed4f7e63037
# ╠═bbf6a9b3-1645-4d1a-bcc8-e967018f106e
# ╠═897a59b1-ef96-44cf-b8fc-8e805ecf23f2
# ╠═b86a08c4-5a51-4b69-bec3-20cc524e32a5
# ╠═6e25b818-6ef5-4719-b805-e8a9ee29d427
# ╠═6cb2e77b-e4a8-4a39-8a36-25bb18640fac
# ╠═c6cb3883-c36f-4cd3-aace-ab3f0607288b
# ╠═5c98be42-20f5-49af-9200-35885d51ec02
# ╠═4f73fd43-bc88-4117-b911-93225fb26260
# ╠═30490b94-283f-4570-8672-a21228c7407d
# ╠═f4ada911-f4a7-486d-a3c6-358c2d7cdc95
# ╠═6b6ea385-b1fc-46e2-8870-6a354df3b8fb
# ╠═eafe6473-20f7-4c1a-a4da-471122116589
# ╠═da705fc0-4d7b-44d9-b622-806d1435e599
# ╠═8f93dd95-39a2-4386-826a-882e5e54aaa7
# ╠═429a0d1e-f062-4c42-a02c-712ca40fb02b
# ╠═ad4a7cbb-2eeb-4d97-9c3e-a7b6474cf69b
# ╠═9cfba2ff-1644-4c09-8bb5-3b68aa0acd20
# ╠═ba1ab835-99bc-4e4f-98a8-98584ca31800
# ╠═ccd85055-d249-48db-b54c-ad3ccdc40086
# ╠═ad8288d1-87b5-4854-a4c3-ed0085a929c5
# ╠═8539426f-6af7-4285-a84b-14e929ced529
# ╠═0f497ebf-8060-4e39-acbb-48c19354e81b
# ╟─c240ed6d-55eb-42cf-aa6f-090b2dbfd1f0
# ╠═68922108-5e0e-4698-b6eb-0a16543c4fb1
# ╟─771cf918-3b39-4c40-9251-e2ca8cee9fdf
# ╟─ffe27413-d324-422e-a85c-99dd07875873
# ╠═8a9cb1cb-cc15-4957-869a-550cc45c6a76
# ╟─dfafda3a-b6ea-4f86-ab41-fed695b07701
# ╠═d85c8936-f52a-4d17-b850-493b72081c75
# ╟─ac7a8269-71f2-4c60-b2f1-7303df3d9903
# ╠═5b86fd00-1918-428b-83db-02bc01c77096
# ╟─78e30793-0f6e-476a-8253-0673f9c0f9a3
# ╠═3abfd313-abf2-46be-b3e7-c8084ae56b26
# ╟─908f4d63-65f3-4baa-b0f5-14066e759c68
# ╠═3a823fa2-8c63-4c62-b8a8-5e909a0495dd
# ╟─89e2bec3-a601-48d1-bd39-25621cd1b5c7
# ╠═f06ccd1d-443e-4ebe-8bc0-520b3403be62
# ╠═bf11d1eb-7cbc-4390-afe0-40848505390c
# ╠═89f93941-aa5a-4048-9853-babdb09fe3a2
# ╠═d0991e11-85eb-46af-89a2-d2664b85eeeb
# ╠═67a60f41-ca28-4ff2-bfdf-5ff04c279a65
# ╠═46aed6fe-43db-4895-8723-514878c90399
# ╟─d70e7c9a-0c5b-4661-bc67-2cd7e88580b7
# ╠═f1a89f14-b420-4024-bd08-7bcc4a6b8e54
# ╠═b4e2eee7-da7e-4b19-bb4a-5cc30712acef
# ╟─7811f0ee-18f1-4a7c-8f32-84207f53f8c1
# ╠═a13774e5-d336-4064-911d-89afd2dba785
# ╠═96169b60-f329-459d-93d5-7d88b84ed584
# ╠═b849965e-1a8f-4cdb-95ba-aae2fa1cb17c
# ╠═e8164515-4e43-4ffb-8747-1e99e36fe768
# ╠═a54f48d7-9eb0-454a-8d45-5f6ddc00bc59
# ╠═14f579c1-c76a-4d33-8dc0-0ebb36626ccf
# ╠═10914935-3607-4e94-9051-a14ba0eaf4cb
# ╠═ce0d69d9-8ef8-4fb1-89c7-6c8919fdcbcd
# ╠═4fa0d90a-9d11-4e82-bdf9-03a152f689e3
# ╠═ae3aaeb5-4b5d-4d51-98e2-859e794f9581
# ╠═6c54a837-9f55-4ed2-b45f-6edd58ab780e
# ╠═37aa19fb-0ef4-4cdb-8514-5d9aeed5392a
# ╟─7413756e-7918-49f8-9f1a-a9e3e9ab34ba
# ╟─77a7116b-c42e-41eb-adbc-00bb1485fe29
# ╠═3ca02591-5b87-423c-8eea-a32b3d90d1a8
# ╟─5eaefcd0-9b6d-4601-a8ef-e59bb32afcb1
# ╠═708e1ba2-9c0e-475e-9e28-dbf45de18f06
# ╟─cfaf861c-25ff-40c9-841c-90bf209d7eb5
# ╠═e5b19433-dc9e-4695-9ccf-761dd40ddcb7
# ╟─9805dea6-6785-4b90-92a4-deb1616f23fe
# ╠═88e589b9-ee19-465d-8f88-8a1a9afd0cde
# ╟─c05f064d-2148-44f7-9cce-d64c464dd1f6
# ╠═e0a7892b-f865-4588-88c0-d089638726ec
# ╟─2dac06cb-afd6-4393-abfc-8d5c2602ee34
# ╠═b9122f28-834d-445c-8e77-dd5eb15f9f3c
# ╠═105045e0-8cd9-410b-bc36-e7dbf1493bff
# ╠═28047c93-08ce-498c-ab8a-a2de99db9c7a
# ╟─fb63509a-2c06-44f7-b495-956f65a28c07
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
