### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 2043b250-f548-11eb-00d6-795b8871adbf
md"
=====================================================================================
### SICP: [1.2.4 Exponentiation（求幂）](https://sarabander.github.io/sicp/html/1_002e2.xhtml#g_t1_002e2_002e4)
=====================================================================================
"

# ╔═╡ 84860653-d42f-451d-bc70-cf741255766f
md"
###### Θ(n)的线性递归
"

# ╔═╡ 36f9d06e-1cd7-456a-9f10-4cabded70658
md"
---
$$b^n := \cases{1 \;\text{,\;\;\;\;\;\;\;\;\;\; if } n=0 \cr b \cdot b^{n-1} \;\text{,\; if } n>0}$$
---
"

# ╔═╡ 93c2d234-6425-453c-98f2-991bfcd6a04e
expt(b, n) = 
	==(n, 0) ? 
		1 : 
		*(b, expt(b, -(n, 1)))

# ╔═╡ 3ff050b2-ca71-4976-98e2-9e56f869442c
expt( 2, 4)

# ╔═╡ 65b037c4-5494-4bfa-8a8c-af5ac11fca8a
expt( 2.0, 4)

# ╔═╡ c1c57b95-0cdd-4ae5-a589-7ad18f08ee02
expt(10.0, 4)

# ╔═╡ e7bcf0cc-b136-417e-8ab2-48fcb93fcfb0
md"
######  具有 Θ(n) 步和 Θ(1) 空间的线性尾递归（即迭代）过程
只有当语言（如 Scheme）具备尾调用优化（tco）时，Θ(1) 的空间需求才成立。这意味着当函数进行尾递归调用时，栈空间不会增长。但对于 Julia 语言来说并非如此。必须手动将代码转换为像 “while” 或 “for” 这样的重复结构，才能实现 Θ(1) 的空间需求。
"

# ╔═╡ 2631e98e-12fa-4405-a5b2-56cea68d7085
# though recursive with tail calls, this has in Julia O(n) space requirment
function expt2(b, n)
	#----------------------------------------------------------------
	expt_iter(b, counter, product) = 
		==(counter, 0) ? 
			product : 
			expt_iter(b, -(counter, 1), *(b, product))
	#----------------------------------------------------------------
	expt_iter(b, n, 1)
end

# ╔═╡ 5e1117cb-6374-46ef-8380-88e30fa25194
expt2( 2., 4)

# ╔═╡ 3e77f33b-52c4-4b49-8068-a9ebc2bc9b8f
expt2(10., 4)

# ╔═╡ d2e30d5a-c983-4532-8612-6422bb6e034d
md"
###### Θ(log n)的线性递归
"

# ╔═╡ d438b096-e9c9-4edf-b449-550e40b3c183
md"
---
$$b^n := \cases{1\;\;\;\;\;\;\;\;\;\;\text{, if } n=0 \cr \left(b^\frac{n}{2}\right)^2 \;\;,\text{ if } n \text{ is even } \cr \cr b \cdot b^{n-1} \;,\text{ if } n \text{ is odd }}$$
---
"

# ╔═╡ ed53f5d7-0a76-4126-9a47-a28531fc160b
function fast_expt(b, n)
   #----------------------------------------------------------------------------      
   square(x) = *(x, x)
   #----------------------------------------------------------------------------
   n == 0 ? 
   		1 :
   		iseven(n) ? 
			square(fast_expt(b, /(n, 2))) : 
			*(b, fast_expt(b, -(n, 1)))               
end # function fast_expt

# ╔═╡ 87ab9fe1-b060-4d21-a5d2-58abc2d83864
fast_expt(2, 3)

# ╔═╡ 04d1c922-9adc-4d1a-8394-0b417db8493f
fast_expt(2, 4)

# ╔═╡ 1bc5fc5e-33be-433a-99b1-2a78a82026ae
fast_expt(10, 4)

# ╔═╡ 678912be-a971-4a0f-a006-16650eceb0b5
md"
###### 进一步修改
"

# ╔═╡ 00f38ce8-336c-4413-b9f1-7dd027d7c1b2
function fast_expt2(b, n)
    #-------------------------------------------------------------------
	function exp_by_squaring(b, counter, product)
		if ==(counter, 0) 
			product
		elseif iseven(counter)  
			exp_by_squaring(*(b, b), /(counter, 2), product)
		elseif isodd(counter)  
			exp_by_squaring(*(b, b), /(-(counter, 1), 2), *(b, product))
		end # if
	end # function exp_by_squaring
    #-------------------------------------------------------------------
exp_by_squaring(b, n, 1)
end # function fast_expt2

# ╔═╡ f160efc3-e2f1-4ba2-84e0-20270fd0d191
md"
###### 进一步修改
"

# ╔═╡ b1f5abe1-fe2c-44b7-b857-f4480e736683
function fast_expt3(b, n)
	function exp_helper(counter, product1, product2)
		if  counter == 0   
			product2
		elseif iseven(counter)
			exp_helper(counter/2, product1*product1, product2)
		else 
			exp_helper(counter-1, product1, product1*product2)
		end
	end
	exp_helper(n, b, 1)
end

# ╔═╡ 9814f07a-ac2e-4ac1-9fb2-09634ff4411f
md"
---
#### 1.2.4.2 Julia风格 
"

# ╔═╡ 33f3709b-c231-48b2-8018-e3ca84878d0d
FloatOrSigned = Union{AbstractFloat, Signed}

# ╔═╡ 53c46f40-ffaf-4c07-9c3d-fb3b7721b412
# idiomatic Julia/Pluto.jl with 'while' and parallel assignment
#    implementing the tail-recursive expt2
function expt3(b, n)
	counter, product = n, 1
	while !(==(counter, 0))
		counter, product = counter-1, b*product
	end
	product
end

# ╔═╡ e0eefdd6-77ba-42cd-a91c-d187e10eb304
expt3( 2, 3)

# ╔═╡ e3f51ca4-748e-43b0-bb5f-de89c54dfb8d
expt3( 2.0, 3)

# ╔═╡ a3ca5521-e05d-4f74-af9d-824e5c78b767
expt3( 2, 4)

# ╔═╡ 79bcb92b-cebc-44a0-9067-2ddb400cdeed
expt3( 2.0, 4)

# ╔═╡ c39ef59b-5762-4a94-b1e2-d9642c33712a
expt3(10, 4)

# ╔═╡ 2e66fa04-0c39-4fc1-9c3d-cc22c6360d04
expt3(10., 4)

# ╔═╡ ac40d32b-85fd-4520-b914-65d00fec5306
function fast_expt2(b::FloatOrSigned, n::Signed)::FloatOrSigned
	b, counter, product = b, n, 1
	while !(counter == 0)
		if counter == 0  
			product
		elseif iseven(counter)  
			b, counter, product = b*b,  counter/2, product
		elseif isodd(counter)  
			b, counter, product = b*b, (counter-1)/2, b*product
		end # if
	end # while
	product
end # function fast_expt2

# ╔═╡ d0952016-ddda-4a3f-a4db-e3371beb901b
fast_expt2(2, 0)

# ╔═╡ 22b951e6-7681-43a2-8f31-11f773495116
fast_expt2(2, 1)

# ╔═╡ 4b44c3bc-224e-4ea7-b64c-993298ca1840
fast_expt2(2, 2)

# ╔═╡ 2db41570-a1d3-4d13-a375-86389626e5cf
fast_expt2(2, 5)

# ╔═╡ a05b3707-ecd5-4c18-8816-8eb66ec8248c
fast_expt2(2.0, 5)

# ╔═╡ 01e2e126-12cb-45db-8485-4935945e4231
fast_expt2(2.0, 5.0)

# ╔═╡ 0c8f82fa-5444-4a13-a4d1-36a4d911d662
fast_expt2(3, 2)

# ╔═╡ 284ddf81-a77b-49dd-8959-a18024569df4
fast_expt2(3, 4)

# ╔═╡ eba3b22d-1fe7-4a91-92a4-d656bb118e11
fast_expt2(3., 4)

# ╔═╡ 862daa54-d824-453e-bd9e-7e33ce8b5a84
fast_expt2(3., 4.)

# ╔═╡ 6ae38071-27dd-4adf-8aa6-939fa460acd2
fast_expt2(2, 0)

# ╔═╡ 21b88782-5eca-40a1-9abf-3f58ce38cb77
fast_expt2(2, 5)

# ╔═╡ 5754e58c-dabb-40f3-833d-4ecdfde5fe10
fast_expt2(2., 5) 

# ╔═╡ 8c75a957-fe38-4771-ab4d-be2e3cca7b2b
fast_expt2(2., 5.)   # works because of default 1st method

# ╔═╡ f6d87396-1678-450d-8b44-2c4f034c7f7f
fast_expt2(3., 4)

# ╔═╡ bd66cce6-f73a-4456-89c3-9e22a9f49e79
fast_expt2(3., 4.)   # works because of default 1st method

# ╔═╡ 7bfc8458-83fe-4587-ae7b-674677ca9173
function fast_expt3(b::FloatOrSigned, n::Signed)::FloatOrSigned
	counter, product1, product2 = n, b, 1
	while !(counter == 0)
		if counter == 0
			product2
		elseif iseven(counter)
			counter, product1, product2 = counter/2, product1*product1, product2
		else
			counter, product1, product2 = counter-1, product1, product1*product2
		end # if
	end # while
	product2
end # function fast_expt3

# ╔═╡ ce4ab367-b105-491b-8e24-975512a7cef0
fast_expt3(2, 0)

# ╔═╡ d0b0a7f2-40c8-4d0d-b3a7-9a5b378acb22
fast_expt3(2, 5)

# ╔═╡ 19ad6bd8-020b-4d7a-a1c5-223d8f45785d
fast_expt3(2., 5)

# ╔═╡ 122e6139-14d3-4a6e-92cd-4e46d72c6ad8
fast_expt3(2., 5.)

# ╔═╡ f2180ed5-ad9f-4b3b-94c6-8e32cc00e370
fast_expt3(3., 4.)

# ╔═╡ 7f0d2688-5737-4d6e-883f-8d65581be468
fast_expt3(2, 0)

# ╔═╡ 732d5d7b-1d66-4ece-a829-8a0aaa1d3bd1
fast_expt3(2, 5)

# ╔═╡ 7a5442af-5988-4b5b-93d1-15f1e3ecba82
fast_expt3(2., 5)

# ╔═╡ a2a0fcd3-6456-4f0c-93b1-386dbac85dd9
fast_expt3(2., 5.) # works because of 1st untyped default method

# ╔═╡ 255ab325-e1ef-44c3-9a39-82b48bafb16f
fast_expt3(3., 4.) # works because of 1st untyped default method

# ╔═╡ c916eaba-5837-4c29-9eee-5ee48f5fb8b0
function expt4(b::FloatOrSigned, n::Integer)::FloatOrSigned
	product = 1
	for counter = 1:n
		product *= b
	end # for
	product
end # expt4

# ╔═╡ 02487dfb-2abb-4ed4-992a-8f0b4c7b49a0
expt4( 2, 3)

# ╔═╡ 356767c6-265b-4ecb-a02e-cd191d17512a
expt4( 2.0, 3)

# ╔═╡ 46de5dba-e36a-4549-93f7-150f1e4d6b7e
expt4( 2, 4)

# ╔═╡ e4c052c1-4166-4f0b-bf06-f9bf8bd7fe31
expt4( 2., 4)

# ╔═╡ a2df3726-9554-401c-88b5-275beffc4542
expt4(10, 4)

# ╔═╡ 887c4e73-c9c5-4ceb-a6b9-d9f60a413af3
expt4(10., 4)

# ╔═╡ a539922e-33d8-4209-9030-c72eb099a83c
md"
---
#### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/24
- **Wikipedia**; [Exponentiation by Squaring] (https://en.m.wikipedia.org/wiki/Exponentiation_by_squaring); 2022/08/24
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
# ╟─2043b250-f548-11eb-00d6-795b8871adbf
# ╟─84860653-d42f-451d-bc70-cf741255766f
# ╟─36f9d06e-1cd7-456a-9f10-4cabded70658
# ╠═93c2d234-6425-453c-98f2-991bfcd6a04e
# ╠═3ff050b2-ca71-4976-98e2-9e56f869442c
# ╠═65b037c4-5494-4bfa-8a8c-af5ac11fca8a
# ╠═c1c57b95-0cdd-4ae5-a589-7ad18f08ee02
# ╟─e7bcf0cc-b136-417e-8ab2-48fcb93fcfb0
# ╠═2631e98e-12fa-4405-a5b2-56cea68d7085
# ╠═5e1117cb-6374-46ef-8380-88e30fa25194
# ╠═3e77f33b-52c4-4b49-8068-a9ebc2bc9b8f
# ╟─d2e30d5a-c983-4532-8612-6422bb6e034d
# ╟─d438b096-e9c9-4edf-b449-550e40b3c183
# ╠═ed53f5d7-0a76-4126-9a47-a28531fc160b
# ╠═87ab9fe1-b060-4d21-a5d2-58abc2d83864
# ╠═04d1c922-9adc-4d1a-8394-0b417db8493f
# ╠═1bc5fc5e-33be-433a-99b1-2a78a82026ae
# ╟─678912be-a971-4a0f-a006-16650eceb0b5
# ╠═00f38ce8-336c-4413-b9f1-7dd027d7c1b2
# ╠═d0952016-ddda-4a3f-a4db-e3371beb901b
# ╠═22b951e6-7681-43a2-8f31-11f773495116
# ╠═4b44c3bc-224e-4ea7-b64c-993298ca1840
# ╠═2db41570-a1d3-4d13-a375-86389626e5cf
# ╠═a05b3707-ecd5-4c18-8816-8eb66ec8248c
# ╠═01e2e126-12cb-45db-8485-4935945e4231
# ╠═0c8f82fa-5444-4a13-a4d1-36a4d911d662
# ╠═284ddf81-a77b-49dd-8959-a18024569df4
# ╠═eba3b22d-1fe7-4a91-92a4-d656bb118e11
# ╠═862daa54-d824-453e-bd9e-7e33ce8b5a84
# ╟─f160efc3-e2f1-4ba2-84e0-20270fd0d191
# ╠═b1f5abe1-fe2c-44b7-b857-f4480e736683
# ╠═ce4ab367-b105-491b-8e24-975512a7cef0
# ╠═d0b0a7f2-40c8-4d0d-b3a7-9a5b378acb22
# ╠═19ad6bd8-020b-4d7a-a1c5-223d8f45785d
# ╠═122e6139-14d3-4a6e-92cd-4e46d72c6ad8
# ╠═f2180ed5-ad9f-4b3b-94c6-8e32cc00e370
# ╟─9814f07a-ac2e-4ac1-9fb2-09634ff4411f
# ╠═33f3709b-c231-48b2-8018-e3ca84878d0d
# ╠═53c46f40-ffaf-4c07-9c3d-fb3b7721b412
# ╠═e0eefdd6-77ba-42cd-a91c-d187e10eb304
# ╠═e3f51ca4-748e-43b0-bb5f-de89c54dfb8d
# ╠═a3ca5521-e05d-4f74-af9d-824e5c78b767
# ╠═79bcb92b-cebc-44a0-9067-2ddb400cdeed
# ╠═c39ef59b-5762-4a94-b1e2-d9642c33712a
# ╠═2e66fa04-0c39-4fc1-9c3d-cc22c6360d04
# ╠═ac40d32b-85fd-4520-b914-65d00fec5306
# ╠═6ae38071-27dd-4adf-8aa6-939fa460acd2
# ╠═21b88782-5eca-40a1-9abf-3f58ce38cb77
# ╠═5754e58c-dabb-40f3-833d-4ecdfde5fe10
# ╠═8c75a957-fe38-4771-ab4d-be2e3cca7b2b
# ╠═f6d87396-1678-450d-8b44-2c4f034c7f7f
# ╠═bd66cce6-f73a-4456-89c3-9e22a9f49e79
# ╠═7bfc8458-83fe-4587-ae7b-674677ca9173
# ╠═7f0d2688-5737-4d6e-883f-8d65581be468
# ╠═732d5d7b-1d66-4ece-a829-8a0aaa1d3bd1
# ╠═7a5442af-5988-4b5b-93d1-15f1e3ecba82
# ╠═a2a0fcd3-6456-4f0c-93b1-386dbac85dd9
# ╠═255ab325-e1ef-44c3-9a39-82b48bafb16f
# ╠═c916eaba-5837-4c29-9eee-5ee48f5fb8b0
# ╠═02487dfb-2abb-4ed4-992a-8f0b4c7b49a0
# ╠═356767c6-265b-4ecb-a02e-cd191d17512a
# ╠═46de5dba-e36a-4549-93f7-150f1e4d6b7e
# ╠═e4c052c1-4166-4f0b-bf06-f9bf8bd7fe31
# ╠═a2df3726-9554-401c-88b5-275beffc4542
# ╠═887c4e73-c9c5-4ceb-a6b9-d9f60a413af3
# ╟─a539922e-33d8-4209-9030-c72eb099a83c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
