### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 287e9560-0fe3-11ec-2a3e-bf6c9c52f872
md"
======================================================================================
#### [SICP\_2.3.3\_Example\_RepresentingSets.jl（实例： 集合的表示）](https://sarabander.github.io/sicp/html/2_002e3.xhtml#g_t2_002e3_002e3)
======================================================================================
"

# ╔═╡ 90866eff-5dae-4471-8a7f-22bfea0f32b5
md"
##### 2.3.3.1 Scheme-like Julia
"

# ╔═╡ 31640d3d-f26d-4c35-a970-2a11ba4619bc
struct Cons
	car
	cdr
end

# ╔═╡ e09b1809-ac89-42e7-88dd-fc8250e43316
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons   

# ╔═╡ 115717d7-97a2-4de7-9009-cf3065511586
function cons(car::Any, list2::Vector)::Vector
	conslist = list2
	pushfirst!(conslist, car)
	conslist
end

# ╔═╡ 33f8f1bc-751a-427e-9e6f-1749c578ea40
function cons(list1::Vector, list2::Vector)::Vector
	conslist = push!([], list1)
	for xi in list2
		push!(conslist, xi)
	end # for
	conslist
end # function cons

# ╔═╡ f22286d7-281c-4f43-bf6a-046fed0d8cbe
car(cell::Cons) = cell.car

# ╔═╡ 01d5ad4d-efb2-4e01-991a-8128111e3cc1
car(x::Vector) = x[1]

# ╔═╡ c88e9dee-b21e-408e-9e2f-2149e8a8e7eb
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ be67e330-d698-4df7-9713-16da04efbcab
cdr(x::Vector) = x[2:end]

# ╔═╡ 6e286aa0-a9eb-4ae7-b7a0-83205a31bf52
	isnull = isempty

# ╔═╡ de9ee526-57f8-4285-b9fc-386a30e35178
md"
---
##### Sets as *un*ordered lists
"

# ╔═╡ cd4ac643-0563-4fc9-a2da-fe0cdba70897
function is_element_of_set1(x, set)
	if isnull(set)
		false
	elseif isequal(x, car(set))  # Base.isequal
		true
	else 
		is_element_of_set1(x, cdr(set))
	end # if
end # function is_element_of_set1

# ╔═╡ c48857bf-3307-4d15-b3ba-5ee6a8a5e639
function adjoin_set(x, set)
	if is_element_of_set1(x, set)
		set
	else 
		cons(x, set)
	end # if
end # function adjoin_set

# ╔═╡ 37020afd-77ae-4ff4-a7dc-8f7c546e1144
mySet = adjoin_set(:a, [])

# ╔═╡ 51e9ca0e-689f-4013-9256-e3f909dc370a
is_element_of_set1(:a, mySet)

# ╔═╡ 35537907-111d-44f8-a7ea-39c756004f2c
is_element_of_set1(:b, mySet)

# ╔═╡ 3db5e486-340f-43d5-8774-42b1dcc9bca9
adjoin_set(:b, mySet)

# ╔═╡ 82836622-6fec-4164-8ff1-7752b13440f2
mySet

# ╔═╡ 69e9a119-1876-42cc-80c1-6eeeb5c9525a
function intersection_set1(set1, set2)
	if isnull(set1) || isnull(set2)
		[]
	elseif is_element_of_set1(car(set1), set2)
		cons(car(set1), intersection_set1(cdr(set1), set2))
	else 
		intersection_set1(cdr(set1), set2)
	end # if
end # function intersection_set1

# ╔═╡ f0a96aa7-b93c-4e32-b545-fea9914d4df7
mySet1 = [:a, :b, 3, 4.0]

# ╔═╡ feff5854-7402-46e7-89e4-1a3601f430a2
mySet2 = [:c, :b, 4, 5.0]

# ╔═╡ f1d0c8a6-12f8-4040-b963-c0a2a48a94f9
intersection_set1(mySet1, mySet2)

# ╔═╡ 1d165e97-c545-46f6-9582-5709aa60899b
md"
---
##### Sets as ordered lists
"

# ╔═╡ 53cbae5f-e10c-4395-9f8c-b1e9f78b0a21
function is_element_of_set2(x, set)
	if isnull(set)
		false
	elseif isequal(x, car(set))
		true
	elseif x < car(set)
		false
	else 
		is_element_of_set2(x, cdr(set))
	end # if
end # function is_element_of_set2

# ╔═╡ bf53d058-3603-4811-ac6a-774190cf2c30
mySet3 = [1, 3, 6, 10]

# ╔═╡ 6157b167-98d6-4ba9-9ae5-afef1aa9171c
mySet4 = [6, 7, 10, 11]

# ╔═╡ fb8e14d1-ebf9-44e0-b94e-08535a8a89bb
is_element_of_set2(6, mySet3)

# ╔═╡ 78e62388-243c-4ce1-adea-3c8bf2b5000c
is_element_of_set2(1, mySet3)

# ╔═╡ 64fdfcb1-2e5a-43ff-a0d4-758080df35b3
is_element_of_set2(11, mySet3)

# ╔═╡ fce9a8ee-7c6e-4c52-82ff-2041bbdc9614
function intersection_set2(set1, set2)
	if isnull(set1) || isnull(set2)
		[]
	else 
		let (x1, x2) = (car(set1), car(set2))
			if x1 == x2
				cons(x1, intersection_set2(cdr(set1), cdr(set2)))
			elseif x1 < x2
				intersection_set2(cdr(set1), set2)
			elseif x1 > x2
				intersection_set2(set1,cdr(set2))
			else
				"unknown case"
			end
		end # let
	end # if
end # function intersection_set2

# ╔═╡ 668472d9-b37e-4c78-a86d-e1b283ebc212
intersection_set2(mySet3, mySet4)

# ╔═╡ 2f1bcd82-5d21-4029-8d3a-6ce95a1637e7
md"
---
##### Sets as Binary Trees
"

# ╔═╡ 89caaab8-8c7b-413b-80d0-cbe42140bbe3
md"
---
                 7                    3                           5
                / \                  / \                         / \
               /   \                /   \                       /   \
              /     \              /     \                     /     \
             3       9            1       7                   3       9
            / \       \                  / \                 /       / \
           /   \       \                /   \               /       /   \ 
          /     \       \              /     \             /       /     \
         1       5      11            5       9           1       7      11
                                               \
                                                \
                                                 \
                                                 11

         Fig. 2.3.3.1.left      Fig. 2.3.3.1.middle       Fig. 2.3.3.1.right      


Fig. 2.3.3.1 Binary trees representing the set $$\{1, 3, 5, 7, 9, 11\}$$
(similar to Fig. 2.16 in SICP, 1996)

---
"

# ╔═╡ e49fefb0-4bee-4553-ad85-6c3be022591e
md"
###### Fig. 2.3.3.1.left
Trees are built with the *constructor* function $$adjoin\_set3$$ starting from the *root*
"

# ╔═╡ 9a84039e-a3c4-417f-87f5-f13d8183eaa9
md"
###### Fig. 2.3.3.1.middle
Trees are built with the *constructor* function $$adjoin\_set3$$ starting from the *root*
"

# ╔═╡ 08e11239-3d7d-4727-af53-7c1846df5f95
md"
###### Fig. 2.3.3.1.right
Trees are built with the *constructor* function $$adjoin\_set3$$ starting from the *root*
"

# ╔═╡ 6376f9c2-d385-4908-be15-4e6a81f7cd07
md"
---
###### basic Scheme-like selectors $cadr, caddr, cadddr$
"

# ╔═╡ 0e1796bc-f981-4317-b860-48fde60a1a36
cadr(x) = car(cdr(x))

# ╔═╡ 8d1291a5-4370-4110-be13-cc8d8edbc116
caddr(x) = car(cdr(cdr(x)))

# ╔═╡ d57e45c4-df22-4513-a0a5-c9ae51e8be15
cadddr(x) = car(cdr(cdr(cdr(x))))

# ╔═╡ 66468df0-8ec3-44fa-bc5a-a7ace76636f4
md"
###### tree selectors $$entry, left\_branch, right\_branch$$
"

# ╔═╡ 6bf8bf85-7f46-4956-a36b-70d7b088867b
entry = car

# ╔═╡ 60b27b69-8de3-4145-a771-b343e12b151d
left_branch = cadr

# ╔═╡ 777a812f-c5f7-41d3-bb5d-aca50ffb2edc
right_branch = caddr

# ╔═╡ 41cc6e0b-4da1-4ecc-8386-4307582e2958
md"
###### basic Scheme-like constructor $$list$$
"

# ╔═╡ 48e4f379-78c3-46e7-a477-a10b55736a99
function list(xs...)
	push!([], xs...)
end

# ╔═╡ 0f4287f1-4540-44b5-8ec7-40623e41a6fd
md"
###### tree constructor $$make\_tree$$
"

# ╔═╡ 1b2876b6-f0a3-494a-bf8d-6ef2c5ad5a09
make_tree = list

# ╔═╡ 43922353-9f3a-4ec1-9b68-5367c748da8a
function is_element_of_set3(x, set)
	if isnull(set)
		false
	elseif isequal(x, entry(set))
		true
	elseif x < entry(set)
		is_element_of_set3(x, left_branch(set))
	elseif x > entry(set)
		is_element_of_set3(x, right_branch(set))
	else
		"unknown case"
	end # if
end # function is_element_of_set3

# ╔═╡ 1f8638c9-0552-4ce8-89e5-7c8ec2e55ad5
function adjoin_set3(x, set)
	if isnull(set)
		make_tree(x, [], [])
	elseif x == entry(set)
		set
	elseif x < entry(set)
		make_tree(entry(set), 
			adjoin_set3(x, left_branch(set)), right_branch(set))
	elseif x > entry(set)
		make_tree(entry(set), 
			left_branch(set), adjoin_set3(x, right_branch(set)))
	end # if
end # function adjoin_set3

# ╔═╡ 0b93eaf6-a3cf-42c5-a7d6-0fde6ea7b828
adjoin_set3(7, [])

# ╔═╡ c355b32a-23d8-4748-8108-ff2300c4631f
adjoin_set3(3, adjoin_set3(7, []))

# ╔═╡ 5800685a-1a16-4505-b5ba-d1b779d4e83c
adjoin_set3(9, adjoin_set3(3, adjoin_set3(7, [])))

# ╔═╡ 67fa6416-7b6d-4f6f-a9c7-bea1c5fec43d
adjoin_set3(1, adjoin_set3(9, adjoin_set3(3, adjoin_set3(7, []))))

# ╔═╡ 9ffd76f3-3141-4d55-9d82-38bae85d6e5b
adjoin_set3(5, adjoin_set3(1, adjoin_set3(9, adjoin_set3(3, adjoin_set3(7, [])))))

# ╔═╡ 4dcd00eb-4004-42a4-bb16-15acdde714c4
treeLeft = adjoin_set3(11, adjoin_set3(5, adjoin_set3(1, adjoin_set3(9, adjoin_set3(3, adjoin_set3(7, []))))))

# ╔═╡ a64228a0-38e2-4cf4-bb7b-64e301af9f11
adjoin_set3(3, [])

# ╔═╡ dcdda29b-4bf8-4c05-ab24-136b4d74c024
adjoin_set3(1, adjoin_set3(3, []))

# ╔═╡ 77d294fb-7fd6-4253-a846-b8efa540e444
adjoin_set3(7, adjoin_set3(1, adjoin_set3(3, [])))

# ╔═╡ fabf0277-ed4e-4a85-93ba-89b72afd272b
adjoin_set3(5, adjoin_set3(7, adjoin_set3(1, adjoin_set3(3, []))))

# ╔═╡ f4583da9-f5ef-4ba1-915b-26200e00430b
adjoin_set3(9, adjoin_set3(5, adjoin_set3(7, adjoin_set3(1, adjoin_set3(3, [])))))

# ╔═╡ 79bab69e-ea1f-40c7-9015-aa1e28ef9ca1
treeMiddle = adjoin_set3(11, adjoin_set3(9, adjoin_set3(5, adjoin_set3(7, adjoin_set3(1, adjoin_set3(3, []))))))

# ╔═╡ 250c1422-a470-4fcd-aaca-49abfff2ce63
adjoin_set3(5, [])

# ╔═╡ f73a2cb3-d10c-44b2-9dbf-8aedd4786ae4
adjoin_set3(3, adjoin_set3(5, []))

# ╔═╡ dce58361-537b-4285-bf9c-92775f4f4c89
adjoin_set3(9, adjoin_set3(3, adjoin_set3(5, [])))

# ╔═╡ 4c84887d-1f70-4867-a62b-e33c35e9689b
adjoin_set3(1, adjoin_set3(9, adjoin_set3(3, adjoin_set3(5, []))))

# ╔═╡ bec3d46c-5ead-4880-b10a-b0b33c46b7e0
adjoin_set3(7, adjoin_set3(1, adjoin_set3(9, adjoin_set3(3, adjoin_set3(5, [])))))

# ╔═╡ 3a3c9b75-9ee5-4b3f-afba-2168f019bcc9
treeRight = adjoin_set3(11, adjoin_set3(7, adjoin_set3(1, adjoin_set3(9, adjoin_set3(3, adjoin_set3(5, []))))))

# ╔═╡ 6b01e6e5-5a68-4a9c-83ec-b53467343b62
# left subtree of Fig.2.3.3.1.left
leftSubtree = adjoin_set3(5, adjoin_set3(1, adjoin_set3(3, [])))  

# ╔═╡ 4eebbde7-0931-4017-a65b-e134424cdca3
rightSubtree = adjoin_set3(11, adjoin_set3(9, []))

# ╔═╡ f237b67b-5c30-4d5c-a2cc-ba81903ce868
mySet5 = make_tree(7, leftSubtree, rightSubtree)

# ╔═╡ a9e1f869-bade-45da-bbe9-623a6bff8113
treeLeft == mySet5

# ╔═╡ 6a7bda42-9e38-4802-a4b5-36f85bf0931d
is_element_of_set3(1, mySet5)

# ╔═╡ ebfb04a9-7493-4106-bb2b-de4a357ef871
is_element_of_set3(5, mySet5)

# ╔═╡ 5469fb63-fbaa-4425-8231-c5ef4d30d8b7
is_element_of_set3(11, mySet5)

# ╔═╡ e35da41e-32d7-44a3-a879-b5558d1a7bec
is_element_of_set3(6, mySet5)

# ╔═╡ 6f7707ed-7825-4570-8e96-b403190402d6
md"
---
##### Sets and information retrieval
"

# ╔═╡ e8e5f771-efeb-471d-836d-54d8165dd00d
key = entry

# ╔═╡ 515dc6e4-c222-4fc3-b852-62b1235d39ae
function lookup(given_key, set_of_records)
	if isnull(set_of_records)
		false
	elseif isequal(given_key, key(car(set_of_records)))
		car(set_of_records)
	else 
		lookup(given_key, cdr(set_of_records))
	end # if
end # function lookup

# ╔═╡ f075025b-55cc-41e8-a9ed-d215bb4af07d
database = 
[	["Abelson,Sussman&Sussman", 1985, "Structure and Interpretation of Computer Programs, 1/e"],
	["ASS", 1996, "SICP, 2/e"],
	["Allen", 1978, "Anatomy of Lisp"],
	["Backus", 1978, "Can programming be liberated from the von Neumann style?"],
	["Church", 1941, "The Calculi of Lambda-Conversion"],
	["Friedman&Felleisen", 1987, "The Little Lisper"],
	["Russell&Norvig", 2021, "Artificial Intelligence: A Modern Approach, 4/e"],
	["Winston", 1992, "Artificial Intelligence"]];

# ╔═╡ 32b3dda6-0b28-4eff-958d-39ddda3d2184
database

# ╔═╡ 7cff9a66-94e7-4c2a-8c94-4058999b48c6
database[5]

# ╔═╡ 40afcc74-5a18-48f8-9627-939eec59ef65
database[5][1]

# ╔═╡ 52476761-16c3-4ec0-9396-3258aa2aa574
database[5][2]

# ╔═╡ 634f1a3d-80e2-46a3-8c70-cbb1e0f8422b
database[5][3]

# ╔═╡ 96a063bc-04e4-44a5-b827-d19cfc652e51
lookup("Russell&Norvig", database)

# ╔═╡ 6d73ae3f-fcbf-47b0-9384-0eaa896e68c7
lookup("ASS", database)

# ╔═╡ c9fd0ecd-86e0-4fd0-95fd-6a0b8ff0371f
md"
---
##### 2.3.3.2 idiographic Julia
"

# ╔═╡ df980bac-44e9-4893-956a-3fd30ce02acd
mySet1

# ╔═╡ 4da50963-2117-449b-b377-6c4cbacbe778
mySet2

# ╔═╡ c360d756-f060-4d5e-848c-32740d30e8ad
intersect(mySet1, mySet2)

# ╔═╡ bc823da7-3b6a-40ee-b2e6-0b590e96c090
∩(mySet1, mySet2)

# ╔═╡ aabf82c3-906d-489a-bf67-576293fa261f
union(mySet1, mySet2)

# ╔═╡ a41c8598-850f-46b8-9c07-cf77a803f989
∪(mySet1, mySet2)

# ╔═╡ d5b6372f-7c48-4074-ad3e-407442a47273
setdiff(mySet1, mySet2)

# ╔═╡ 31f34dfa-ba4e-443c-a032-68eb667afc86
setdiff(mySet2, mySet1)

# ╔═╡ 8c2a5585-2d23-4c71-8ea1-c5db7e55b942
myDict = Dict([
	(database[5][1], (database[5][2], database[5][3])),
	(database[4][1], (database[4][2], database[4][3])),
	(database[6][1], (database[6][2], database[6][3])),
	(database[3][1], (database[3][2], database[3][3])),
	(database[7][1], (database[7][2], database[7][3])),
	(database[2][1], (database[2][2], database[2][3])),
	(database[8][1], (database[8][2], database[8][3])),
	(database[1][1], (database[1][2], database[1][3]))
])

# ╔═╡ f40b9c56-f308-4d89-baa3-465e7e3fa919
keys(myDict)

# ╔═╡ f507116f-caf2-4d93-8287-9193bfbf3d3d
values(myDict)

# ╔═╡ 8934372c-2940-4685-b180-547632289315
haskey(myDict, "Church")

# ╔═╡ 4ce40ff7-42fa-4e46-889d-a57bebe50f95
haskey(myDict, "ASS")

# ╔═╡ dea9a374-a00f-4e22-8e84-fb7b0e4ef53f
get(myDict, "ASS", "no entry found")

# ╔═╡ 09fdf039-29e0-4e60-a3ef-16d3814c4184
get(myDict, "Church", "no entry found")

# ╔═╡ f166c71d-0cb5-4f74-b274-717c0319b4c6
get(myDict, "Kiczales,DesRivieres&Bobrow", "no entry found")

# ╔═╡ cc03266f-6f2d-4743-857b-59e0509e189e
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/09/16
- **Kiczales, G., Des Rivieres, J. & Bobrow, D.G.**; The Art of the Metaobject Protocol; MIT Press, 1991
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
# ╟─287e9560-0fe3-11ec-2a3e-bf6c9c52f872
# ╟─90866eff-5dae-4471-8a7f-22bfea0f32b5
# ╠═31640d3d-f26d-4c35-a970-2a11ba4619bc
# ╠═e09b1809-ac89-42e7-88dd-fc8250e43316
# ╠═115717d7-97a2-4de7-9009-cf3065511586
# ╠═33f8f1bc-751a-427e-9e6f-1749c578ea40
# ╠═f22286d7-281c-4f43-bf6a-046fed0d8cbe
# ╠═01d5ad4d-efb2-4e01-991a-8128111e3cc1
# ╠═c88e9dee-b21e-408e-9e2f-2149e8a8e7eb
# ╠═be67e330-d698-4df7-9713-16da04efbcab
# ╠═6e286aa0-a9eb-4ae7-b7a0-83205a31bf52
# ╟─de9ee526-57f8-4285-b9fc-386a30e35178
# ╠═cd4ac643-0563-4fc9-a2da-fe0cdba70897
# ╠═c48857bf-3307-4d15-b3ba-5ee6a8a5e639
# ╠═37020afd-77ae-4ff4-a7dc-8f7c546e1144
# ╠═51e9ca0e-689f-4013-9256-e3f909dc370a
# ╠═35537907-111d-44f8-a7ea-39c756004f2c
# ╠═3db5e486-340f-43d5-8774-42b1dcc9bca9
# ╠═82836622-6fec-4164-8ff1-7752b13440f2
# ╠═69e9a119-1876-42cc-80c1-6eeeb5c9525a
# ╠═f0a96aa7-b93c-4e32-b545-fea9914d4df7
# ╠═feff5854-7402-46e7-89e4-1a3601f430a2
# ╠═f1d0c8a6-12f8-4040-b963-c0a2a48a94f9
# ╟─1d165e97-c545-46f6-9582-5709aa60899b
# ╠═53cbae5f-e10c-4395-9f8c-b1e9f78b0a21
# ╠═bf53d058-3603-4811-ac6a-774190cf2c30
# ╠═6157b167-98d6-4ba9-9ae5-afef1aa9171c
# ╠═fb8e14d1-ebf9-44e0-b94e-08535a8a89bb
# ╠═78e62388-243c-4ce1-adea-3c8bf2b5000c
# ╠═64fdfcb1-2e5a-43ff-a0d4-758080df35b3
# ╠═fce9a8ee-7c6e-4c52-82ff-2041bbdc9614
# ╠═668472d9-b37e-4c78-a86d-e1b283ebc212
# ╟─2f1bcd82-5d21-4029-8d3a-6ce95a1637e7
# ╟─89caaab8-8c7b-413b-80d0-cbe42140bbe3
# ╟─e49fefb0-4bee-4553-ad85-6c3be022591e
# ╠═0b93eaf6-a3cf-42c5-a7d6-0fde6ea7b828
# ╠═c355b32a-23d8-4748-8108-ff2300c4631f
# ╠═5800685a-1a16-4505-b5ba-d1b779d4e83c
# ╠═67fa6416-7b6d-4f6f-a9c7-bea1c5fec43d
# ╠═9ffd76f3-3141-4d55-9d82-38bae85d6e5b
# ╠═4dcd00eb-4004-42a4-bb16-15acdde714c4
# ╟─9a84039e-a3c4-417f-87f5-f13d8183eaa9
# ╠═a64228a0-38e2-4cf4-bb7b-64e301af9f11
# ╠═dcdda29b-4bf8-4c05-ab24-136b4d74c024
# ╠═77d294fb-7fd6-4253-a846-b8efa540e444
# ╠═fabf0277-ed4e-4a85-93ba-89b72afd272b
# ╠═f4583da9-f5ef-4ba1-915b-26200e00430b
# ╠═79bab69e-ea1f-40c7-9015-aa1e28ef9ca1
# ╟─08e11239-3d7d-4727-af53-7c1846df5f95
# ╠═250c1422-a470-4fcd-aaca-49abfff2ce63
# ╠═f73a2cb3-d10c-44b2-9dbf-8aedd4786ae4
# ╠═dce58361-537b-4285-bf9c-92775f4f4c89
# ╠═4c84887d-1f70-4867-a62b-e33c35e9689b
# ╠═bec3d46c-5ead-4880-b10a-b0b33c46b7e0
# ╠═3a3c9b75-9ee5-4b3f-afba-2168f019bcc9
# ╟─6376f9c2-d385-4908-be15-4e6a81f7cd07
# ╠═0e1796bc-f981-4317-b860-48fde60a1a36
# ╠═8d1291a5-4370-4110-be13-cc8d8edbc116
# ╠═d57e45c4-df22-4513-a0a5-c9ae51e8be15
# ╟─66468df0-8ec3-44fa-bc5a-a7ace76636f4
# ╠═6bf8bf85-7f46-4956-a36b-70d7b088867b
# ╠═60b27b69-8de3-4145-a771-b343e12b151d
# ╠═777a812f-c5f7-41d3-bb5d-aca50ffb2edc
# ╟─41cc6e0b-4da1-4ecc-8386-4307582e2958
# ╠═48e4f379-78c3-46e7-a477-a10b55736a99
# ╟─0f4287f1-4540-44b5-8ec7-40623e41a6fd
# ╠═1b2876b6-f0a3-494a-bf8d-6ef2c5ad5a09
# ╠═43922353-9f3a-4ec1-9b68-5367c748da8a
# ╠═1f8638c9-0552-4ce8-89e5-7c8ec2e55ad5
# ╠═6b01e6e5-5a68-4a9c-83ec-b53467343b62
# ╠═4eebbde7-0931-4017-a65b-e134424cdca3
# ╠═f237b67b-5c30-4d5c-a2cc-ba81903ce868
# ╠═a9e1f869-bade-45da-bbe9-623a6bff8113
# ╠═6a7bda42-9e38-4802-a4b5-36f85bf0931d
# ╠═ebfb04a9-7493-4106-bb2b-de4a357ef871
# ╠═5469fb63-fbaa-4425-8231-c5ef4d30d8b7
# ╠═e35da41e-32d7-44a3-a879-b5558d1a7bec
# ╟─6f7707ed-7825-4570-8e96-b403190402d6
# ╠═e8e5f771-efeb-471d-836d-54d8165dd00d
# ╠═515dc6e4-c222-4fc3-b852-62b1235d39ae
# ╠═f075025b-55cc-41e8-a9ed-d215bb4af07d
# ╠═32b3dda6-0b28-4eff-958d-39ddda3d2184
# ╠═7cff9a66-94e7-4c2a-8c94-4058999b48c6
# ╠═40afcc74-5a18-48f8-9627-939eec59ef65
# ╠═52476761-16c3-4ec0-9396-3258aa2aa574
# ╠═634f1a3d-80e2-46a3-8c70-cbb1e0f8422b
# ╠═96a063bc-04e4-44a5-b827-d19cfc652e51
# ╠═6d73ae3f-fcbf-47b0-9384-0eaa896e68c7
# ╟─c9fd0ecd-86e0-4fd0-95fd-6a0b8ff0371f
# ╠═df980bac-44e9-4893-956a-3fd30ce02acd
# ╠═4da50963-2117-449b-b377-6c4cbacbe778
# ╠═c360d756-f060-4d5e-848c-32740d30e8ad
# ╠═bc823da7-3b6a-40ee-b2e6-0b590e96c090
# ╠═aabf82c3-906d-489a-bf67-576293fa261f
# ╠═a41c8598-850f-46b8-9c07-cf77a803f989
# ╠═d5b6372f-7c48-4074-ad3e-407442a47273
# ╠═31f34dfa-ba4e-443c-a032-68eb667afc86
# ╠═8c2a5585-2d23-4c71-8ea1-c5db7e55b942
# ╠═f40b9c56-f308-4d89-baa3-465e7e3fa919
# ╠═f507116f-caf2-4d93-8287-9193bfbf3d3d
# ╠═8934372c-2940-4685-b180-547632289315
# ╠═4ce40ff7-42fa-4e46-889d-a57bebe50f95
# ╠═dea9a374-a00f-4e22-8e84-fb7b0e4ef53f
# ╠═09fdf039-29e0-4e60-a3ef-16d3814c4184
# ╠═f166c71d-0cb5-4f74-b274-717c0319b4c6
# ╟─cc03266f-6f2d-4743-857b-59e0509e189e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
