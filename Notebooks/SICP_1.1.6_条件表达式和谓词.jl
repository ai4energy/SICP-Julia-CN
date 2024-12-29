### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 4ba04c25-a29b-4bf0-be10-be3f20279f28
md"
===================================================================================
 ### SICP: [1.1.6 Conditional Expressions and Predicates（条件表达式和谓词）](https://sarabander.github.io/sicp/html/1_002e1.xhtml#g_t1_002e1_002e6)
===================================================================================
"

# ╔═╡ 33f31484-b07f-4550-a829-37f1d4f7feba
md"
#### 1.1.6.1 SICP-Scheme-like *functional* Julia
"

# ╔═╡ 20a147db-1759-4445-a60b-f75e9374864f
md"
---

$$\begin{array}{ccc}
\hline
(cond & (<p_1> & <e_1>) \\
      & (<p_1> & <e_1>) \\
      & ...    & ...    \\
      & (<p_n> & <e_n>)) \\
\hline
\end{array}$$

**Fig. 1.1.6.1** SICP (Scheme/Lisp) conditional expression with *non-strict* evaluation

---

"

# ╔═╡ b649e901-d3bf-4bf0-9ba8-69cd4e6bf550
md"
###### 绝对值函数 $$|x|$$
"

# ╔═╡ 8287786a-0c31-4d58-83fe-ff4d75513ebe
md"
$$|x| = \cases{\;\;\; x \text{ if } x \gt 0 \cr \;\;\; 0  \text{ if } x = 0 \cr -x \text{ if } x < 0}$$
" 

# ╔═╡ 638667fc-0381-47a5-9288-e10b973e10b7
abs1(x) =  
	x  > 0 ?  x : 
	x == 0 ?  0 :
	x  < 0 ? -x : 
	"unidentified case"

# ╔═╡ c0df9843-2a0c-4c00-a3ee-78a153bde39f
abs1(+4.9)

# ╔═╡ 93ac3435-1b97-4a36-8868-69a40e6bfe67
abs1(0.0)

# ╔═╡ 5eaff842-ff87-445a-9749-052ef1ec8cb9
abs1(-4.9)

# ╔═╡ 50969205-37b7-4d35-8fa9-fa151b11632d
abs2(x) = 
	if x > 0 
		x 
	elseif x == 0 
		0 
	else 
		-x
	end # if

# ╔═╡ e1ef77b1-03a2-478b-8fbd-17556c5e51bd
abs2(4.9)

# ╔═╡ 49ac622a-3846-4096-ae67-7380363d395d
abs2(0)

# ╔═╡ 126c883d-243c-4529-bc5a-d23f2337f67f
abs2(-4.9)

# ╔═╡ 17ffb5ef-1b1a-49f6-8f1d-cc14580781af
abs3(x) = 
	if x > 0
		x
	else -x
	end # if

# ╔═╡ 461a492a-6a79-4df5-ac46-a8b915e2afc5
abs3(4.9)

# ╔═╡ 0339e437-491f-4a04-b3ff-4bf6aa8aceaa
abs3(0)

# ╔═╡ b0d5154a-e71d-4212-bf2c-58a13fadf1e7
abs3(-4.9)

# ╔═╡ 752bc49a-35f2-48ea-8ea5-a05783996b3f
abs4(x) = x > 0 ? x : -x

# ╔═╡ 3e388e69-2c1a-4d37-906f-4c67797b27b3
abs4(4.9)

# ╔═╡ 2ab60d27-1cd4-4098-9ebb-08bdc3eeaae9
abs4(0)

# ╔═╡ bd28e726-cc8f-4aa9-bee1-d7f969a60aa4
abs4(-4.9)

# ╔═╡ 7efcf92c-963e-428e-9393-547bd58a7eea
md"
##### 布尔运算
"

# ╔═╡ 6ea1c6c7-56f4-404d-825b-4ddd18e08915
and(x, y) = x && y  # definition of *binary* function 'and' 

# ╔═╡ b3ba0af4-ad8f-4d10-b8ca-336b8df614e3
or(x, y) = x || y

# ╔═╡ 69f36630-a57f-4c63-8e01-f38b0a1649a4
not(x) = !x

# ╔═╡ a7e1951f-bf97-4966-b93b-104c7b165f67
not(true)

# ╔═╡ d41e6ce1-1192-495a-8bfd-74936101efa3
not(false)

# ╔═╡ 4188358b-3a15-4bae-addc-54da9bfc87b8
md"
###### 复合过程 $$x \ge y := (x > y) \lor (x = y)$$
"

# ╔═╡ fad8b34d-30e1-4ff8-a180-59efde3925fa
geEq2(x, y) = x > y || x == y

# ╔═╡ ad41d505-3803-420f-a077-5f147e32b83e
geEq2(3, 5)

# ╔═╡ 2a1fbc65-f991-46e3-8057-35f8085fc394
geEq2(5, 5)

# ╔═╡ d2a400fa-a179-4ae5-94af-8e1af14ae116
geEq2(7, 5)

# ╔═╡ e40e61d9-692e-4838-a84d-11c51911e3d4
md"
###### 复合过程 $$x \ge y := (x \not \lt y)$$
"

# ╔═╡ 7c2f185f-e363-4a8e-8b52-80fef2622aa7
geEq3(x, y) = not(x < y)

# ╔═╡ a96202d4-6f52-40cc-a421-e81bb98c363b
geEq3(5, 3)

# ╔═╡ 5907313d-43b1-4c67-84dd-ea0f5c1f3da8
geEq3(3, 3)

# ╔═╡ b153aba7-acee-4b0e-84e7-1e8aa6f5eea9
geEq3(3, 5)

# ╔═╡ adb0c3c3-97b9-45f1-ae42-e05539dbc427
geEq4(x, y) = !(x < y)

# ╔═╡ e668030b-8d70-4bd2-887c-1bafb6fe5928
geEq4(5, 3)

# ╔═╡ 5decbbfe-402e-472a-9e22-402f7178d3d0
geEq4(3, 3)

# ╔═╡ 6f5a6658-4128-4829-be58-4831b1496d0b
geEq4(3, 5)

# ╔═╡ 18c20c8c-842a-4f03-b3a7-0d5442ae905e
geEq5(x, y) = !<(x, y)

# ╔═╡ d91629d0-79e1-4ddd-9a28-3bc1a9948ff5
geEq5(5, 3)

# ╔═╡ c77e9bd1-5964-411f-831c-9b76b05ff640
geEq5(3, 3)

# ╔═╡ 93fb8d81-c942-420d-ab91-8371a4af3062
geEq5(3, 5)

# ╔═╡ 8208a2ee-8698-4a8c-81e2-3624abc4f7d3
md"
###### '&' 和 '|'
"

# ╔═╡ c40f2fe6-c8ac-4ace-bb54-148506bdb7a1
(&)(true, true, true)

# ╔═╡ 5f74d11d-f384-4453-b268-5c81ee77cf65
(&)(true, true, false)

# ╔═╡ cf1ae6ed-d21a-4ca3-bfee-cbf0e1549667
(|)(true, true, true)

# ╔═╡ f3cc88a0-e5e0-4e75-8953-bd361937140b
(|)(true, true, false)

# ╔═╡ 22f11800-1d96-46d4-9ac0-4ae817f1b4f1
(|)(false, false, false)

# ╔═╡ 7ad09c29-c9cf-49c9-988f-83b7e4b05393
md"
###### 完整 'and'
"

# ╔═╡ f3e3edfa-c5c5-4c1a-805d-c46370298c62
and(x, y, rest...) = (&)(x, y, rest...)  # 2nd (!) method with strict evaluation

# ╔═╡ 70cb087f-17d8-4457-90f1-7cf1d16d9e63
and(true, true)

# ╔═╡ 995d50b4-4e53-4787-b730-df40db2029b1
and(true, false)

# ╔═╡ 9e0cac6c-1121-4e0a-8750-7ad5736974c9
and(true, true, false)

# ╔═╡ 5414db5c-5cc7-4bd5-8c19-aa12e43dfee2
and(true, true, true)

# ╔═╡ 01e00375-4405-4ecb-abf2-8fcb51d6caa4
md"
###### 完整 'or'
"

# ╔═╡ d7ff540f-4b3c-4f4e-a7ad-eb5487fd98d5
or(x, y, rest...) = (|)(x, y, rest...)  # 2nd (!) method with strict evaluation

# ╔═╡ 42c5e112-db6f-4874-a227-5a06d8054102
or(false, true)

# ╔═╡ 63bd6526-ea6b-4b48-9456-4c5f05045ef1
or(false, false)

# ╔═╡ ce79a92e-9bb9-48cd-834c-34eb61c67d18
geEq1(x, y) = or((x > y), (x == y))

# ╔═╡ 91eeb0b4-c921-4672-8bee-1d18b2c3c13c
geEq1(5, 3)

# ╔═╡ 234fcd0f-cebc-4adb-8730-3cd2fad15ba0
geEq1(3, 3)

# ╔═╡ 081df546-68eb-4609-8671-e1a6395d9bb9
geEq1(2, 3)

# ╔═╡ 18ee8e44-abd2-4b6e-a66f-5be2dcda2978
or(true, true, false)

# ╔═╡ 6877d30c-7b37-4ec5-9fc7-d6b5fbe382bd
or(false, false, false)

# ╔═╡ 9326271a-ce21-4254-ab26-a42f87d18bc5
md"
---
#### Julia代码
$$5 < 2 < 10 := (5 < 2) \land (2 < 10)$$
"

# ╔═╡ 96004b6e-d0f7-4afa-8ee2-f61aa84af474
(5 < 2) && (2 < 10)  

# ╔═╡ b00ca9fe-70fa-4d24-808f-581965d76df6
5 < 2 < 10  

# ╔═╡ cedbf13f-be78-43d7-879a-63971f02c8f5
((5 < 2) && (2 < 10)) == (5 < 2 < 10)

# ╔═╡ f6ee94f3-a049-44a1-91ba-bb6daf3d0140
((5 < 2) && (2 < 10)) === (5 < 2 < 10)

# ╔═╡ be1bb1e0-52f5-4158-9625-aa9f900b3d02
5 < 6 < 10 

# ╔═╡ faeff098-044b-49bc-85a3-c0c655de80a6
(5 < 6) && (6 < 10)

# ╔═╡ f7b6234a-1951-4111-9095-418e6a2a4d49
(5 < 6 < 10) == ((5 < 6) && (6 < 10))

# ╔═╡ 9a5d6d10-27d7-4cac-a950-6e5668955067
md"
---
##### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**, Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/23 

- **Arens, T., Hettlich, F., Karpfinger, Chr., Kockelkorn, U., Lichtenegger, K., & Stachel, H.,** Mathematik, 4/e, Heidelberg, Springer Spektrum, [https://doi.org/10.1007/978-3-662-56741-8](https://doi.org/10.1007/978-3-662-56741-8)

- **Nándor Bokor**, 2015 Phys. Educ. 50 733, online [*here*](https://iopscience.iop.org/article/10.1088/0031-9120/50/6/733); last visit 2022/11/08
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
# ╟─4ba04c25-a29b-4bf0-be10-be3f20279f28
# ╟─33f31484-b07f-4550-a829-37f1d4f7feba
# ╟─20a147db-1759-4445-a60b-f75e9374864f
# ╟─b649e901-d3bf-4bf0-9ba8-69cd4e6bf550
# ╟─8287786a-0c31-4d58-83fe-ff4d75513ebe
# ╠═638667fc-0381-47a5-9288-e10b973e10b7
# ╠═c0df9843-2a0c-4c00-a3ee-78a153bde39f
# ╠═93ac3435-1b97-4a36-8868-69a40e6bfe67
# ╠═5eaff842-ff87-445a-9749-052ef1ec8cb9
# ╠═50969205-37b7-4d35-8fa9-fa151b11632d
# ╠═e1ef77b1-03a2-478b-8fbd-17556c5e51bd
# ╠═49ac622a-3846-4096-ae67-7380363d395d
# ╠═126c883d-243c-4529-bc5a-d23f2337f67f
# ╠═17ffb5ef-1b1a-49f6-8f1d-cc14580781af
# ╠═461a492a-6a79-4df5-ac46-a8b915e2afc5
# ╠═0339e437-491f-4a04-b3ff-4bf6aa8aceaa
# ╠═b0d5154a-e71d-4212-bf2c-58a13fadf1e7
# ╠═752bc49a-35f2-48ea-8ea5-a05783996b3f
# ╠═3e388e69-2c1a-4d37-906f-4c67797b27b3
# ╠═2ab60d27-1cd4-4098-9ebb-08bdc3eeaae9
# ╠═bd28e726-cc8f-4aa9-bee1-d7f969a60aa4
# ╟─7efcf92c-963e-428e-9393-547bd58a7eea
# ╠═6ea1c6c7-56f4-404d-825b-4ddd18e08915
# ╠═70cb087f-17d8-4457-90f1-7cf1d16d9e63
# ╠═995d50b4-4e53-4787-b730-df40db2029b1
# ╠═b3ba0af4-ad8f-4d10-b8ca-336b8df614e3
# ╠═42c5e112-db6f-4874-a227-5a06d8054102
# ╠═63bd6526-ea6b-4b48-9456-4c5f05045ef1
# ╠═69f36630-a57f-4c63-8e01-f38b0a1649a4
# ╠═a7e1951f-bf97-4966-b93b-104c7b165f67
# ╠═d41e6ce1-1192-495a-8bfd-74936101efa3
# ╟─4188358b-3a15-4bae-addc-54da9bfc87b8
# ╠═ce79a92e-9bb9-48cd-834c-34eb61c67d18
# ╠═91eeb0b4-c921-4672-8bee-1d18b2c3c13c
# ╠═234fcd0f-cebc-4adb-8730-3cd2fad15ba0
# ╠═081df546-68eb-4609-8671-e1a6395d9bb9
# ╠═fad8b34d-30e1-4ff8-a180-59efde3925fa
# ╠═ad41d505-3803-420f-a077-5f147e32b83e
# ╠═2a1fbc65-f991-46e3-8057-35f8085fc394
# ╠═d2a400fa-a179-4ae5-94af-8e1af14ae116
# ╟─e40e61d9-692e-4838-a84d-11c51911e3d4
# ╠═7c2f185f-e363-4a8e-8b52-80fef2622aa7
# ╠═a96202d4-6f52-40cc-a421-e81bb98c363b
# ╠═5907313d-43b1-4c67-84dd-ea0f5c1f3da8
# ╠═b153aba7-acee-4b0e-84e7-1e8aa6f5eea9
# ╠═adb0c3c3-97b9-45f1-ae42-e05539dbc427
# ╠═e668030b-8d70-4bd2-887c-1bafb6fe5928
# ╠═5decbbfe-402e-472a-9e22-402f7178d3d0
# ╠═6f5a6658-4128-4829-be58-4831b1496d0b
# ╠═18c20c8c-842a-4f03-b3a7-0d5442ae905e
# ╠═d91629d0-79e1-4ddd-9a28-3bc1a9948ff5
# ╠═c77e9bd1-5964-411f-831c-9b76b05ff640
# ╠═93fb8d81-c942-420d-ab91-8371a4af3062
# ╟─8208a2ee-8698-4a8c-81e2-3624abc4f7d3
# ╠═c40f2fe6-c8ac-4ace-bb54-148506bdb7a1
# ╠═5f74d11d-f384-4453-b268-5c81ee77cf65
# ╠═cf1ae6ed-d21a-4ca3-bfee-cbf0e1549667
# ╠═f3cc88a0-e5e0-4e75-8953-bd361937140b
# ╠═22f11800-1d96-46d4-9ac0-4ae817f1b4f1
# ╟─7ad09c29-c9cf-49c9-988f-83b7e4b05393
# ╠═f3e3edfa-c5c5-4c1a-805d-c46370298c62
# ╠═9e0cac6c-1121-4e0a-8750-7ad5736974c9
# ╠═5414db5c-5cc7-4bd5-8c19-aa12e43dfee2
# ╟─01e00375-4405-4ecb-abf2-8fcb51d6caa4
# ╠═d7ff540f-4b3c-4f4e-a7ad-eb5487fd98d5
# ╠═18ee8e44-abd2-4b6e-a66f-5be2dcda2978
# ╠═6877d30c-7b37-4ec5-9fc7-d6b5fbe382bd
# ╠═9326271a-ce21-4254-ab26-a42f87d18bc5
# ╠═96004b6e-d0f7-4afa-8ee2-f61aa84af474
# ╠═b00ca9fe-70fa-4d24-808f-581965d76df6
# ╠═cedbf13f-be78-43d7-879a-63971f02c8f5
# ╠═f6ee94f3-a049-44a1-91ba-bb6daf3d0140
# ╠═be1bb1e0-52f5-4158-9625-aa9f900b3d02
# ╠═faeff098-044b-49bc-85a3-c0c655de80a6
# ╠═f7b6234a-1951-4111-9095-418e6a2a4d49
# ╟─9a5d6d10-27d7-4cac-a950-6e5668955067
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
