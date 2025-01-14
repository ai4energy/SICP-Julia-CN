### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 45de6af0-f228-11eb-3398-0ba586081633
md"
===================================================================================
 ### SICP: [1.2.1 Linear Recursion and Iteration（线性的递归和迭代）](https://sarabander.github.io/sicp/html/1_002e2.xhtml#g_t1_002e2_002e1)
===================================================================================
"

# ╔═╡ 71a5c80b-d0c1-4269-88f3-d75cbc4ecce5
md"
#### 1.2.1.1 SICP-Scheme-like *functional* Julia
"

# ╔═╡ b7a1a820-167e-4509-9132-16d1e373a599
md"
---
$$fac(n):= 1 \cdot 2 \cdot 3 \; \cdot \; ... \; \cdot \; (n-1) \cdot n = n*(n-1)! = \prod_{i=1}^n i$$
递归函数阶乘

---
"

# ╔═╡ 76c277f3-f31f-4f6b-aae1-94fbbda60be4
function factorial(n)
	==(n, 1) ? 
		1 : 
		*(n, factorial(-(n, 1)))
end # function

# ╔═╡ ab72cb48-9398-42e1-8ed7-8bc8db399ac5
factorial(6)

# ╔═╡ 362f76e2-6ba0-4564-90df-3c4258d88c83
factorial(6.)      

# ╔═╡ 37a3a9c0-4d72-4513-b685-4349f7e8ad20
md"
---
$$5040 = \cases{
7 * fact(6) \cr 
7 * (6 * fact(5)) \cr
7 * (6 * (5 * fact(4))) \cr
7 * (6 * (5 * (4 * fact(3)))) \cr
7 * (6 * (5 * (4 * (3 * fact(2))))) \cr
7 * (6 * (5 * (4 * (3 * (2 * fact(1)))))) \cr
7 * (6 * (5 * (4 * (3 * (2 * 1)))))) \cr
7 * (6 * (5 * (4 * (3 * 2)))) \cr
7 * (6 * (5 * (4 * 6))) \cr
7 * (6 * (5 * 24)) \cr
7 * (6 * 120) \cr
7 * 720 \cr
5040
}$$


**Fig. 1.2.1.1**: A linear recursive process for computing $$7!$$

---
"

# ╔═╡ 27d1c562-2b1c-41a0-aec9-787834d9d8b4
factorial(7)

# ╔═╡ 4a17ecb7-9460-48cb-855f-4a49a21bbc9d
fact_iter(product, counter, max_count) = 
	if >(counter, max_count)
		product
	else
		fact_iter(*(counter, product), +(counter, 1), max_count)
end

# ╔═╡ 5d1ec6ed-ce6a-424e-a2af-47b42cd6eb5b
factorial2(n) = fact_iter(1, 1, n)

# ╔═╡ d746cb2f-2768-4917-b214-583080b0cd1b
factorial2(6)

# ╔═╡ bac2caf9-bf94-4aa0-9ce4-2ea462f4f345
factorial2(6.0)       

# ╔═╡ 68a5453c-9c25-4539-a3f8-2d4948dca25d
function factorial3(n)
	#--------------------------------------------------------------
	function fact_iter(product, counter, max_count) 
		if >(counter, max_count)
			product
		else
			fact_iter(*(counter, product), +(counter,1), max_count)
		end # if
	end # function fact_iter
	#--------------------------------------------------------------
	fact_iter(1, 1, n)
end # function factorial3

# ╔═╡ b1d0cf2b-dde7-48c9-8cb4-99a37576a85a
factorial3(6)

# ╔═╡ 3f79201d-bd6e-41b2-aa7e-9a3cc6212c0b
factorial3(6.)         

# ╔═╡ 9d64350e-6a59-4ebe-b8b8-2c0db70b3987
md"
---
#### 1.2.1.2 Julia风格
"

# ╔═╡ 440fc1d0-f088-430c-af05-036ccd7986d4
subtypes(Integer)        # abstract type Integer: subtype Bool undesired here

# ╔═╡ 82c84963-2f87-4023-8134-32e36d164d1b
subtypes(Signed)         # abstract type Signed

# ╔═╡ 03a0d7a7-a12f-45bf-8d24-2c640179166a
#---------------------------------------------------------------
# idiomatic JULIA with 'while'
#---------------------------------------------------------------
function factorial4(n::Signed)::Signed # Float input is blocked!
	product   = 1
	counter   = 1
	max_count = n
	while !(counter > max_count)
		product = counter * product
		counter = counter + 1
	end # while
	product
end
#---------------------------------------------------------------

# ╔═╡ 42d11416-24b0-4bd0-bda6-b8c44b3780fc
factorial4(6)

# ╔═╡ da69a9e9-6644-4086-80ab-fc2a0ae20b0b
factorial4(6.)                  # Float is blocked !

# ╔═╡ 5ed10883-31fb-4f0a-957b-31a746ae0346
md"
###### 3rd *typed* 'AbstractFloat' (specialized) method of function 'factorial'
"

# ╔═╡ 83b0a30b-1923-41b7-9b49-396b98bd597d
#-----------------------------------------------------------
# idiomatic JULIA with 'while' and update '*=' and '+='
#-----------------------------------------------------------
function factorial5(n::AbstractFloat)::AbstractFloat
	product   = 1
	counter   = 1
	max_count = n
	while !(counter > max_count)
		product *= counter
		counter += 1
	end # while
	product
end

# ╔═╡ 653e8ea9-37ca-4326-8e93-753e762c99d5
factorial5(6)              # Integer is blocked !

# ╔═╡ cc773ec8-28b5-427c-bfe1-a96f9cf72365
factorial5(6.)                  

# ╔═╡ e866967c-4b98-4582-9d2a-d13ce8c657ee
md"
###### 使用for替代递归
"

# ╔═╡ 8d102915-60f0-417d-b8cf-eff22f2abd11
FloatOrSigned = Union{AbstractFloat, Signed}

# ╔═╡ c0a7751d-6f41-466d-810f-a3886e766956
#-----------------------------------------------------------
# idiomatic JULIA with 'for' and update '*='
#-----------------------------------------------------------
function factorial6(n::FloatOrSigned)::FloatOrSigned
	product = 1
	for counter = 1:n
		product *= counter
	end # for
	product
end

# ╔═╡ 76619032-3414-42de-b5df-f7299f499413
factorial6(6)

# ╔═╡ 705d89bf-ed5c-4cbb-8d1d-febe7867a785
factorial6(6.)              

# ╔═╡ df32a460-22c6-4a7a-ac7d-0a14dbf5e6a3
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
# ╟─45de6af0-f228-11eb-3398-0ba586081633
# ╟─71a5c80b-d0c1-4269-88f3-d75cbc4ecce5
# ╟─b7a1a820-167e-4509-9132-16d1e373a599
# ╠═76c277f3-f31f-4f6b-aae1-94fbbda60be4
# ╠═ab72cb48-9398-42e1-8ed7-8bc8db399ac5
# ╠═362f76e2-6ba0-4564-90df-3c4258d88c83
# ╟─37a3a9c0-4d72-4513-b685-4349f7e8ad20
# ╠═27d1c562-2b1c-41a0-aec9-787834d9d8b4
# ╠═5d1ec6ed-ce6a-424e-a2af-47b42cd6eb5b
# ╠═4a17ecb7-9460-48cb-855f-4a49a21bbc9d
# ╠═d746cb2f-2768-4917-b214-583080b0cd1b
# ╠═bac2caf9-bf94-4aa0-9ce4-2ea462f4f345
# ╠═68a5453c-9c25-4539-a3f8-2d4948dca25d
# ╠═b1d0cf2b-dde7-48c9-8cb4-99a37576a85a
# ╠═3f79201d-bd6e-41b2-aa7e-9a3cc6212c0b
# ╠═9d64350e-6a59-4ebe-b8b8-2c0db70b3987
# ╠═440fc1d0-f088-430c-af05-036ccd7986d4
# ╠═82c84963-2f87-4023-8134-32e36d164d1b
# ╠═03a0d7a7-a12f-45bf-8d24-2c640179166a
# ╠═42d11416-24b0-4bd0-bda6-b8c44b3780fc
# ╠═da69a9e9-6644-4086-80ab-fc2a0ae20b0b
# ╟─5ed10883-31fb-4f0a-957b-31a746ae0346
# ╠═83b0a30b-1923-41b7-9b49-396b98bd597d
# ╠═653e8ea9-37ca-4326-8e93-753e762c99d5
# ╠═cc773ec8-28b5-427c-bfe1-a96f9cf72365
# ╠═e866967c-4b98-4582-9d2a-d13ce8c657ee
# ╠═8d102915-60f0-417d-b8cf-eff22f2abd11
# ╠═c0a7751d-6f41-466d-810f-a3886e766956
# ╠═76619032-3414-42de-b5df-f7299f499413
# ╠═705d89bf-ed5c-4cbb-8d1d-febe7867a785
# ╟─df32a460-22c6-4a7a-ac7d-0a14dbf5e6a3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
