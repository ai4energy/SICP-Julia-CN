### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 46f0e7c0-c22e-11ec-29ae-b5e9190145a5
md"
======================================================================================
#### [SICP\_2.3.4\_ExampleHuffmanEncodingTrees.jl(实例： Huffman 编码树)](https://sarabander.github.io/sicp/html/2_002e3.xhtml#g_t2_002e3_002e4)
======================================================================================
"

# ╔═╡ 6d885af4-0509-4e21-b52c-98268ee8d152
md"
---
##### Fixed-length vs. variable-length code
"

# ╔═╡ b2efbf8b-f3dd-4a8a-bc83-6595c0335e5e
md"
                                      o
                                    /   \
                                  /       \
                                /           \
                              /               \
                            /                   \
                          /                       \
                        o                           o  
                      /   \                       /   \
                    /       \                   /       \
                  /           \               /           \
                 o              o            o              o
               /   \          /   \        /   \          /   \
             A       B      C       D     E      F      G       H
             =       =      =       =     =      =      =       =
            000     001    010     011   100    101    110     111

  Fig. 2.3.4.1  *Fixed*-length code and binary decision tree

---

"

# ╔═╡ ded66b16-86c6-4d2c-adaa-b501eabb59ab
md"
---

                                      o
                                    /   \
                                  /       o
                                /        /  \
                              /        /      \
                            /        /          \
                          /        /              \
                        A        /                  o  
                               /                  /   \
                              o                  /       \
                           /  \               /           \
                         /      o            o              o
                       /      /   \        /   \          /   \
             A       B      C       D     E      F      G       H
             =       =      =       =     =      =      =       =
             0      100   1010    1011  1100   1101   1110    1111

Fig. 2.3.4.2 *Variable*-length *prefix* code and binary decision tree

---
"

# ╔═╡ 4f7e86d7-a35c-47fe-b0bf-2537f61c74a0
md"
---
#### 2.3.4.1 Scheme-like Julia
"

# ╔═╡ c7d18353-d81b-40a4-849a-401e58522f93
md"
###### Constructors $$Cons, cons, list$$
"

# ╔═╡ 4aae7780-f679-46d7-bb90-c7c835ce06ad
struct Cons
	car
	cdr
end

# ╔═╡ 29922c54-85c3-4bf1-aee8-3dd71e941847
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ c85a9432-1d06-4238-9900-ed32b8d23989
function cons(car::Any, list2::Vector)::Vector
	conslist = list2
	pushfirst!(conslist, car)
	conslist
end

# ╔═╡ 67916d64-7136-45a0-8412-8d196969db78
function cons(list1::Vector, list2::Vector)::Vector
	conslist = push!([], list1)
	for xi in list2
		push!(conslist, xi)
	end
	conslist
end

# ╔═╡ 76ba25ee-9671-43f5-adb6-5ee26ae1a7dc
function list(xs...)
	push!([], xs...)
end

# ╔═╡ 8c164cde-af32-4da1-b68e-569286f17df4
md"
###### Selectors $$car, cdr, cadr, caddr, cadddr$$
"

# ╔═╡ 687d78f7-8387-4f33-98af-d6d08191451c
car(cell::Cons) = cell.car

# ╔═╡ c155d60d-2408-4b1f-b9fd-e1d373a180ca
car(x::Vector) = x[1]

# ╔═╡ 4507d8e6-19a5-4f4d-88a3-fac771b2bbf9
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ e04d1f56-f985-4317-83dd-b568996e30f3
cdr(x::Vector) = x[2:end]

# ╔═╡ fa253810-e8c8-4e17-852f-699ddd6f4e8b
cadr(x) = car(cdr(x))

# ╔═╡ 554bc628-52ef-47a7-bf57-68ebd2e3bed8
caddr(x) = car(cdr(cdr(x)))

# ╔═╡ e06c43df-52b0-4a17-8c79-050585d0cd6c
cadddr(x) = car(cdr(cdr(cdr(x))))

# ╔═╡ cbc0dcec-bafb-4508-b686-4ec3a76efd8e
md"
###### predicate $$isnull$$
"

# ╔═╡ bbea3bce-d47a-4ab4-9d0a-4901b2ece1a9
isnull = isempty

# ╔═╡ cf34593e-5b03-4685-99ca-0da14694ab57
md"
---
##### Generating [Huffman trees](https://en.wikipedia.org/wiki/Huffman_coding)
using Julia's *set-constructor* $$Set([itr])$$
"

# ╔═╡ a635f26f-e54d-4ecc-9917-d9072e9bf076
md"
---
                         ({A, B, C, D, E, F, G, H}, 17)
                                       o
                                      / \
                                    /     \
                                  /         o({B, C, D, E, F, G, H}, 9)
                                /          /  \
                              /          /      \
                            /          /          \
                          /          /              \
                        /          /                  \
                    ({A},8)     /                      o({E, F, G, H}, 4)
                               /                       / \
                             /                       /     \
             ({B, C, D}, 5)o                       /          \
                         /  \                    /              \
                       /     o({C,D},2)        o({E,F},2)         o({G,H},2)
                     /      / \               / \                / \
                   /      /     \           /     \            /     \
                 /      /         \       /         \       /         \
            ({B},3) ({C},1)   ({D},1) ({E},1)   ({F},1)  ({G},1)    ({H},1)

              A       B       C       D       E       F       G       H
              =       =       =       =       =       =       =       =
              0      100    1010    1011    1100    1101    1110    1111

Fig. 2.3.4.3 [HUFFMAN-code](https://en.wikipedia.org/wiki/Huffman_coding): *Variable*-length *prefix* code and binary decision tree (similar to Fig. 2.18 in SICP)

---
"

# ╔═╡ 084156d1-cd71-44e3-8963-3dbf0f4fd2d8
initial_Leaves = [(Set([:A]), 8), (Set([:B]), 3), (Set([:C]), 1), (Set([:D]), 1), (Set([:E]), 1), (Set([:F]), 1), (Set([:G]), 1), (Set([:H]), 1)]

# ╔═╡ ebd519cb-c105-4f41-a69b-31d3991a75c8
merge1 = [(Set([:A]), 8), (Set([:B]), 3), (∪(Set([:C]), Set([:D])), 2), (Set([:E]), 1), (Set([:F]), 1), (Set([:G]), 1), (Set([:H]), 1)]

# ╔═╡ 6496de45-5b95-4c0a-8287-c6bc2d4d178d
merge2 = [(Set([:A]), 8), (Set([:B]), 3), (∪(Set([:C]), Set([:D])), 2), (∪(Set([:E]), Set([:F])), 2), (Set([:G]), 1), (Set([:H]), 1)]

# ╔═╡ 0bf04eb5-7c6d-46ec-a9e5-a66a3068b913
merge3 = [(Set([:A]), 8), (Set([:B]), 3), (∪(Set([:C]), Set([:D])), 2), (∪(Set([:E]), Set([:F])), 2), (∪(Set([:G]), Set([:H])), 2)]

# ╔═╡ 4ce27f1a-ae8c-43ea-8090-f855236dfdf2
merge4 = [(Set([:A]), 8), (Set([:B]), 3), (∪(Set([:C]), Set([:D])), 2), (∪(Set([:E]), Set([:F]), Set([:G]), Set([:H])), 4)]

# ╔═╡ 1bf3daf3-0960-4903-b9df-00103f4a6fae
merge5 = [(Set([:A]), 8), (∪(Set([:B]), Set([:C]), Set([:D])), 5), (∪(Set([:E]), Set([:F]), Set([:G]), Set([:H])), 4)]

# ╔═╡ abd8038d-99b2-4dda-846c-0b81f610eab1
merge6 = [(Set([:A]), 8), (∪(Set([:B]), Set([:C]), Set([:D]), Set([:E]), Set([:F]), Set([:G]), Set([:H])), 9)]

# ╔═╡ 60cb39a0-e39e-428b-accf-dca38ae285b4
final_merge = [(∪(Set([:A]), Set([:B]), Set([:C]), Set([:D]), Set([:E]), Set([:F]), Set([:G]), Set([:H])), 17)]

# ╔═╡ 1b1afceb-444a-4cd8-ab7a-2eeeb772db2d
md"
---
##### Representing [Huffman trees](https://en.wikipedia.org/wiki/Huffman_coding)
"

# ╔═╡ 2d3e067d-1f8d-4673-af94-93fd765f4a7e
make_leaf(symbol, weight) = list(:leaf, symbol, weight)

# ╔═╡ b687cb0b-5443-4495-a773-c09f4cb13bd0
isleaf(object) =  isequal(car(object), :leaf)

# ╔═╡ bed90016-25b3-4fb0-b835-6d8904574df7
symbol_leaf = cadr

# ╔═╡ 1fb98c73-aced-4389-93b4-e63c3bdb2fea
weight_leaf = caddr

# ╔═╡ d37f9c0d-7536-4644-8778-d37dea2368a3
function append3(list1::Array, list2::Array)::Array
	#----------------------------------------------
	null(list::Array)::Bool = list == []
	#----------------------------------------------
	list1_list2 = list2
	while !null(list1)
		list1, list1_list2 = list1[1:end-1], cons(last(list1),list1_list2)
	end # while
	list1_list2
end # function append3

# ╔═╡ 2377e61f-ffc9-454d-9df8-ae5949cd4bd6
left_branch_tree = car

# ╔═╡ fb4d281e-73c2-43d4-9b8e-ad6b2c98bc00
right_branch_tree = cadr

# ╔═╡ fd2964c7-8d47-43f5-99ab-522f01c14cf2
function symbols(tree)
	isleaf(tree) ? list(symbol_leaf(tree)) : caddr(tree)
end

# ╔═╡ 6c0290ad-331a-4323-8fc9-06daa0b2124c
function weight_tree(tree)
	isleaf(tree) ? weight_leaf(tree) : cadddr(tree)
end

# ╔═╡ e0cd109a-ddb2-420b-acfd-dfebefa25887
function make_code_tree(left, right)
	list(left, right, append3(symbols(left), symbols(right)), 
		weight_tree(left) + weight_tree(right))
end # function make_code_tree

# ╔═╡ 043cdf0f-388c-4cf1-8d66-e0c431deec26
md"
###### make leaves
"

# ╔═╡ a33b5af2-817b-463d-a74b-9ebcc207eaeb
leafA = make_leaf(:A, 8) 

# ╔═╡ 7cbb1c24-51f5-4fa5-a77f-59d56e2d8645
leafB = make_leaf(:B, 3)

# ╔═╡ 63170f22-1f16-44ea-be4f-92607253d65f
leafC = make_leaf(:C, 1)

# ╔═╡ ef9a3f07-a2ce-4724-bd05-79331fe0e144
leafD = make_leaf(:D, 1)

# ╔═╡ adbb2466-c635-48df-b614-8209c7d17783
leafE = make_leaf(:E, 1)

# ╔═╡ 90b48650-92ac-438e-a69c-8190da3b8b2b
leafF = make_leaf(:F, 1)

# ╔═╡ e225ba2f-400b-4a8e-83c6-7223bdc0d8a4
leafG = make_leaf(:G, 1)

# ╔═╡ 0e6487dd-bba1-4e53-911f-b8cac1c68ad1
leafH = make_leaf(:H, 1)

# ╔═╡ 5f885533-f8c7-4eb9-aa1b-e72c46b1cad3
md"
###### make subtrees and tree
"

# ╔═╡ e8ced582-ec97-4312-909f-c6c1c1293fe2
treeGH = make_code_tree(leafG, leafH)

# ╔═╡ a040d9e5-3398-4442-85ef-48c3232829aa
treeEF = make_code_tree(leafE, leafF)

# ╔═╡ 869f50fb-9526-4b86-ae7c-d4cd8280b257
treeCD = make_code_tree(leafC, leafD)

# ╔═╡ e9e369b7-a180-42b2-8ef3-a638b45aab8a
treeBCD = make_code_tree(leafB, treeCD)

# ╔═╡ 6c3396bd-8edb-450e-a1c1-6e0b5b9d7918
treeEFGH = make_code_tree(treeEF, treeGH)

# ╔═╡ bebbe08b-27cf-4c05-a280-4ec0bb34bf17
treeBCDEFGH = make_code_tree(treeBCD, treeEFGH)

# ╔═╡ fc3f6597-235f-463d-a18c-5e91e6d382c9
treeABCDEFGH = make_code_tree(leafA, treeBCDEFGH)

# ╔═╡ cd54a65e-4522-4aee-9abd-2bb204b9b743
md"
---
##### The decoding procedure
"

# ╔═╡ b7d6b443-ed01-4b59-aa28-56852e569b64
sample_tree = treeABCDEFGH;

# ╔═╡ 6fd8466d-f5b6-4890-84da-a879bd639fa9
sample_message = [0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0] # Exercise 2.67

# ╔═╡ 5cf7ae78-97ed-49bc-abc5-c73926fbc724
function choose_branch(bit, branch)
	if bit == 0
		left_branch_tree(branch)
	elseif bit == 1
		right_branch_tree(branch)
	else
		("bad bit --- CHOOSE-BRANCH", bit)
	end # if
end # function choose_branch

# ╔═╡ a65d4576-56ab-468d-92cb-dcd2502b34c0
function decode(bits, tree)
	function decode_1(bits, current_branch)
		if isnull(bits)
			[]
		else
			let next_branch = choose_branch(car(bits), current_branch)
				if isleaf(next_branch)
					cons(symbol_leaf(next_branch), decode_1(cdr(bits), tree))
				else
					decode_1(cdr(bits), next_branch)
				end # if
			end # let
		end # if
	end # function decode_1
	decode_1(bits, tree)
end # function decode

# ╔═╡ a241116b-939f-481b-85ee-d9505d54e23c
treeGH

# ╔═╡ c9fbab7a-dd22-4404-ad27-0b2efd7986a4
decode([0], treeGH)

# ╔═╡ 4d614167-92d9-4b29-a79d-97bd509fbb56
decode([1], treeGH)

# ╔═╡ f7080776-7257-4d52-883f-5ba29e6d212a
decode(sample_message, sample_tree)

# ╔═╡ 864d78ff-4fb7-46de-b783-b3b9ee0016f1
md"
###### Sets of weighted elements
"

# ╔═╡ 186345e6-77a2-4529-b5fd-2227396d7ad7
function adjoin_set(x, set)
	#---------------------------------------------
	weight = cadr
	#---------------------------------------------
	if isnull(set)
		list(x)
	elseif weight(x) > weight(car(set))
		cons(x, set)
	else 
		cons(car(set), adjoin_set(x, cdr(set)))
	end # if
end # function adjoin_set

# ╔═╡ a8c58881-69ef-49d0-9a84-3703a5142358
setA = adjoin_set([:A, 4], [])

# ╔═╡ 3ba2c2b9-137d-4ab6-bdc9-53ddf405d708
setB = adjoin_set([:B, 2], setA)

# ╔═╡ 1500aef7-4a9a-4fa0-b151-2d3f778cd88c
setC = adjoin_set([:C, 1], setB)

# ╔═╡ c57b0601-b56a-4bb9-b66e-fb839313af83
setD = adjoin_set([:D, 1], setC)

# ╔═╡ 2697d33b-5054-449c-89d5-a6df43ac7eb5
function make_leaf_set(pairs)
	if isnull(pairs)
		[]
	else 
		let pair = car(pairs)
			adjoin_set(make_leaf(car(pair), cadr(pair)), make_leaf_set(cdr(pairs)))
		end # let
	end # if
end # function make_leaf_set

# ╔═╡ 34aeeee2-ebae-4ecd-a2fe-980033985ac0
ordered_set_of_leaves = make_leaf_set(setD)

# ╔═╡ 9dfbaeb4-a6aa-4f7b-a59c-ba9c9b0862fd
treeDC =
make_code_tree(ordered_set_of_leaves[1], ordered_set_of_leaves[2])

# ╔═╡ 1e182418-b12c-4fc7-91d8-f701078e76d1
treeBDC = make_code_tree(ordered_set_of_leaves[3], treeDC)

# ╔═╡ 33d2ab1f-65e7-46df-bb41-2282470c85d7
treeABDC = make_code_tree(ordered_set_of_leaves[4], treeBDC)

# ╔═╡ ddfe8ae6-c7e5-4747-b66f-706474af7791
decode(sample_message, treeABDC) 

# ╔═╡ 4933eac8-1847-467e-931b-a8486a1692fd
md"
---
#### 2.3.4.2 idiographic Julia
"

# ╔═╡ 25f70a05-ce58-4bb2-b45b-a77978701196
md"
##### Representing [Huffman trees](https://en.wikipedia.org/wiki/Huffman_coding)
"

# ╔═╡ 7209486c-229c-480f-a91e-6fd676c44886
make_leaf2(symbol, weight) = (:leaf, Set([symbol]), weight)

# ╔═╡ 24eece44-8ae9-4c40-bc56-0feffa3e8902
isleaf2(tree) =  tree[1] == :leaf

# ╔═╡ ae298b4a-315a-4b3c-a2f5-4bd7d2edc889
symbol_leaf2(tree) = collect(tree[2])[1]  # convert set to array

# ╔═╡ bb497107-31e8-4f5b-8125-2cf311017fd7
md"
###### make leaves
"

# ╔═╡ d9ff76e8-a489-496e-a2b8-3007a4179ca0
leaf2A = make_leaf2(:A, 8)

# ╔═╡ 92eb506b-e0ba-4545-b186-4753cd4f7940
symbol_leaf2(leaf2A)

# ╔═╡ 0b04fe18-4681-4973-95a6-80b28ff30309
leaf2B = make_leaf2(:B, 3)

# ╔═╡ 8f8dda6b-3c44-4b4f-969c-cc1512f903aa
leaf2C = make_leaf2(:C, 1)

# ╔═╡ 82468da0-af9d-4bbc-b048-f66a9a6fbd58
leaf2D = make_leaf2(:D, 1)

# ╔═╡ f41b1faa-7f3e-4dd2-b2cd-1f8228769bbd
leaf2E = make_leaf2(:E, 1)

# ╔═╡ 8c8ce307-70af-470e-a741-0332f32553cd
leaf2F = make_leaf2(:F, 1)

# ╔═╡ 89bcb694-f093-4cfc-9d86-e2fdbb5f73c9
leaf2G = make_leaf2(:G, 1)

# ╔═╡ 83f3d0eb-bee9-45f8-aeb7-87951f062390
leaf2H = make_leaf2(:H, 1)

# ╔═╡ 76b0f767-1b80-4cad-ac65-ce713bfdac49
initial_Leaves2 = [leafA, leafB, leafC, leafD, leafE, leafF, leafG, leafH]

# ╔═╡ c2f95c88-082a-48cf-8bc8-aabb191f55a5
md"
###### make subtrees and tree
"

# ╔═╡ c010a2e4-cb6c-4643-b3bc-0ee70b05c589
function weight_tree2(tree)
	isleaf2(tree) ? tree[3] : tree[4]
end

# ╔═╡ d6cf4fe9-e740-48c5-a42c-c277f571fb08
function make_code_tree2(left, right)
	#---------------------------------------
	leaf_set(tree) = 
		tree[1] == :leaf ? tree[2] : tree[3]
	#---------------------------------------
	(left, right, ∪(leaf_set(left), leaf_set(right)), 
		weight_tree2(left) + weight_tree2(right))
end # function make_code_tree2

# ╔═╡ bab90c8a-53b0-4ed7-843b-15eeecb3a2ce
leaf2G

# ╔═╡ 59d0bfa6-7193-423d-b49d-5aaabb6d4c8c
 tree2GH = make_code_tree2(leaf2G, leaf2H)

# ╔═╡ 50113454-cc2f-4d41-beb2-721c84fc74f8
tree2EF = make_code_tree2(leaf2E, leaf2F)

# ╔═╡ 14ca2e29-f3b0-49c2-9925-7ff68d6478b0
tree2CD = make_code_tree2(leaf2C, leaf2D)

# ╔═╡ 524a86cf-382d-4056-93d0-1724e6f59b93
tree2BCD = make_code_tree2(leaf2B, tree2CD)

# ╔═╡ 57a666f4-084c-4037-aef3-e7a5502a7de3
tree2EFGH = make_code_tree2(tree2EF, tree2GH)

# ╔═╡ 8f8db07b-1605-4178-8f2c-d770b0cf5bf0
tree2BCDEFGH = make_code_tree2(tree2BCD, tree2EFGH)

# ╔═╡ 74652b92-d4f0-4d22-911e-b1e0c5606505
tree2ABCDEFGH = make_code_tree2(leaf2A, tree2BCDEFGH)

# ╔═╡ 53565b84-62f6-4358-bcb9-d5901cb04aca
md"
---
##### The decoding procedure
"

# ╔═╡ 84650073-7f3b-4fc6-afde-c5028861c215
sample_tree2 = tree2ABCDEFGH

# ╔═╡ 935c0ad6-3e76-4b35-a071-0d7372d81e52
sample_message2 = [0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0] # Exercise 2.67

# ╔═╡ e79b8ba6-09ce-457f-8ca0-d2a308542c58
left_branch_tree2(tree) = tree[1]

# ╔═╡ b90c7f44-5381-4fa3-b13c-8938d318b828
right_branch_tree2(tree) = tree[2]

# ╔═╡ e3d411ea-ebfc-45f7-ad15-03a7e1617e2d
function choose_branch2(bit, branch)
	if bit == 0
		left_branch_tree2(branch)
	elseif bit == 1
		right_branch_tree2(branch)
	else
		("bad bit --- CHOOSE-BRANCH", bit)
	end # if
end # function choose_branch

# ╔═╡ 0ef7909b-03dc-4049-b9db-00b18c5514e9
function decode2(bits, tree)
	function decode_1(bits, current_branch)
		if isempty(bits)
			[]
		else
			let next_branch = choose_branch2(bits[1], current_branch)
				if isleaf2(next_branch)
					cons(symbol_leaf2(next_branch), decode_1(bits[2:end], tree))
				else
					decode_1(bits[2:end], next_branch)
				end # if
			end # let
		end # if
	end # function decode_1
	decode_1(bits, tree)
end # function decode

# ╔═╡ d1e287a4-8498-41b6-8d11-b824c6bc7ab3
tree2GH

# ╔═╡ dc50eb6f-e75f-4e62-8c68-1fad8e83e689
decode2([0], tree2GH)

# ╔═╡ 640af146-783f-4b36-9d07-ffc89ea87664
decode2([1], tree2GH)

# ╔═╡ ca6669ab-4960-4678-8374-b2f2f30f50cf
decode2([0], tree2EF)

# ╔═╡ c8190287-f681-4187-8a7d-5c5e3959ae4d
decode2([1], tree2EF)

# ╔═╡ 87467d80-a07b-4e7b-9156-52cf9f0b8a95
decode2([0], tree2CD)

# ╔═╡ 11ced7f2-e652-42d8-92e8-fe9875ec44e8
decode2([1], tree2CD)

# ╔═╡ 3b949808-af1b-41d2-8a25-613646c45bab
decode2([0], tree2BCD)

# ╔═╡ b9b8aa9a-72e0-4d7e-8a6c-8c73cfea1c54
decode2([1, 0], tree2BCD)

# ╔═╡ a5bd1aaf-c67e-4114-bb10-76225e0e70d7
decode2([1, 1], tree2BCD)

# ╔═╡ 189ea466-9704-42e9-aa49-518ef87e82f3
decode2([0, 0], tree2EFGH)

# ╔═╡ fda5e034-e26a-4dd3-987e-46e5f6f534b1
decode2([0, 1], tree2EFGH)

# ╔═╡ 9a8c822e-01d8-4bac-881f-30e9271b4ccd
decode2([1, 0], tree2EFGH)

# ╔═╡ 0b1544d5-d76a-4cc5-a345-b050d99ead27
decode2([1, 1], tree2EFGH)

# ╔═╡ 565d0458-0b5b-4d22-8a28-d3607aaf82e3
decode2([0, 0], tree2BCDEFGH)

# ╔═╡ e3cc57bc-0990-4baa-b3b5-19f4c3b587a0
decode2([0, 1, 0], tree2BCDEFGH)

# ╔═╡ 5b48e322-004f-4c2c-a3d7-c9852124a9c3
decode2([0, 1, 1], tree2BCDEFGH)

# ╔═╡ 14b0fffb-b874-486c-b14c-cbd424b12b26
decode2([1, 0, 0], tree2BCDEFGH)

# ╔═╡ 15d3b749-d6c0-43a4-9d74-29b6b11f1237
decode2([1, 0, 1], tree2BCDEFGH)

# ╔═╡ 7d0c280c-1f7e-4dce-849b-1ca4bc452e84
decode2([1, 1, 0], tree2BCDEFGH)

# ╔═╡ 30ef666d-1695-4e50-a28c-4cdb29722a8c
decode2([1, 1, 1], tree2BCDEFGH)

# ╔═╡ eb1b497a-89d5-49d4-a6de-360387b42d34
sample_message2

# ╔═╡ 70a5f442-aa4c-4f62-9ac0-dcf4698c8063
sample_tree2

# ╔═╡ 1db71d0a-38e0-41fc-8caf-a98e5178f9b9
decode2(sample_message2, sample_tree2)

# ╔═╡ 2c07ccdb-f9a9-4ede-a8fd-0c86af0d03d5
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/09/20
"

# ╔═╡ 423f6e08-ecea-4d7c-a37c-8e7d15e4deea
md"
---
##### end of ch 2.3.4
This is a **draft** under the [Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/) license. Comments, suggestions for improvement and bug reports are welcome: **claus.moebus(@)uol.de**

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
# ╟─46f0e7c0-c22e-11ec-29ae-b5e9190145a5
# ╟─6d885af4-0509-4e21-b52c-98268ee8d152
# ╟─b2efbf8b-f3dd-4a8a-bc83-6595c0335e5e
# ╟─ded66b16-86c6-4d2c-adaa-b501eabb59ab
# ╟─4f7e86d7-a35c-47fe-b0bf-2537f61c74a0
# ╟─c7d18353-d81b-40a4-849a-401e58522f93
# ╠═4aae7780-f679-46d7-bb90-c7c835ce06ad
# ╠═29922c54-85c3-4bf1-aee8-3dd71e941847
# ╠═c85a9432-1d06-4238-9900-ed32b8d23989
# ╠═67916d64-7136-45a0-8412-8d196969db78
# ╠═76ba25ee-9671-43f5-adb6-5ee26ae1a7dc
# ╟─8c164cde-af32-4da1-b68e-569286f17df4
# ╠═687d78f7-8387-4f33-98af-d6d08191451c
# ╠═c155d60d-2408-4b1f-b9fd-e1d373a180ca
# ╠═4507d8e6-19a5-4f4d-88a3-fac771b2bbf9
# ╠═e04d1f56-f985-4317-83dd-b568996e30f3
# ╠═fa253810-e8c8-4e17-852f-699ddd6f4e8b
# ╠═554bc628-52ef-47a7-bf57-68ebd2e3bed8
# ╠═e06c43df-52b0-4a17-8c79-050585d0cd6c
# ╟─cbc0dcec-bafb-4508-b686-4ec3a76efd8e
# ╠═bbea3bce-d47a-4ab4-9d0a-4901b2ece1a9
# ╟─cf34593e-5b03-4685-99ca-0da14694ab57
# ╟─a635f26f-e54d-4ecc-9917-d9072e9bf076
# ╠═084156d1-cd71-44e3-8963-3dbf0f4fd2d8
# ╠═ebd519cb-c105-4f41-a69b-31d3991a75c8
# ╠═6496de45-5b95-4c0a-8287-c6bc2d4d178d
# ╠═0bf04eb5-7c6d-46ec-a9e5-a66a3068b913
# ╠═4ce27f1a-ae8c-43ea-8090-f855236dfdf2
# ╠═1bf3daf3-0960-4903-b9df-00103f4a6fae
# ╠═abd8038d-99b2-4dda-846c-0b81f610eab1
# ╟─60cb39a0-e39e-428b-accf-dca38ae285b4
# ╟─1b1afceb-444a-4cd8-ab7a-2eeeb772db2d
# ╠═2d3e067d-1f8d-4673-af94-93fd765f4a7e
# ╠═b687cb0b-5443-4495-a773-c09f4cb13bd0
# ╠═bed90016-25b3-4fb0-b835-6d8904574df7
# ╠═1fb98c73-aced-4389-93b4-e63c3bdb2fea
# ╠═d37f9c0d-7536-4644-8778-d37dea2368a3
# ╠═e0cd109a-ddb2-420b-acfd-dfebefa25887
# ╠═2377e61f-ffc9-454d-9df8-ae5949cd4bd6
# ╠═fb4d281e-73c2-43d4-9b8e-ad6b2c98bc00
# ╠═fd2964c7-8d47-43f5-99ab-522f01c14cf2
# ╠═6c0290ad-331a-4323-8fc9-06daa0b2124c
# ╟─043cdf0f-388c-4cf1-8d66-e0c431deec26
# ╠═a33b5af2-817b-463d-a74b-9ebcc207eaeb
# ╠═7cbb1c24-51f5-4fa5-a77f-59d56e2d8645
# ╠═63170f22-1f16-44ea-be4f-92607253d65f
# ╠═ef9a3f07-a2ce-4724-bd05-79331fe0e144
# ╠═adbb2466-c635-48df-b614-8209c7d17783
# ╠═90b48650-92ac-438e-a69c-8190da3b8b2b
# ╠═e225ba2f-400b-4a8e-83c6-7223bdc0d8a4
# ╠═0e6487dd-bba1-4e53-911f-b8cac1c68ad1
# ╟─5f885533-f8c7-4eb9-aa1b-e72c46b1cad3
# ╠═e8ced582-ec97-4312-909f-c6c1c1293fe2
# ╠═a040d9e5-3398-4442-85ef-48c3232829aa
# ╠═869f50fb-9526-4b86-ae7c-d4cd8280b257
# ╠═e9e369b7-a180-42b2-8ef3-a638b45aab8a
# ╠═6c3396bd-8edb-450e-a1c1-6e0b5b9d7918
# ╠═bebbe08b-27cf-4c05-a280-4ec0bb34bf17
# ╠═fc3f6597-235f-463d-a18c-5e91e6d382c9
# ╟─cd54a65e-4522-4aee-9abd-2bb204b9b743
# ╠═b7d6b443-ed01-4b59-aa28-56852e569b64
# ╠═6fd8466d-f5b6-4890-84da-a879bd639fa9
# ╠═a65d4576-56ab-468d-92cb-dcd2502b34c0
# ╠═5cf7ae78-97ed-49bc-abc5-c73926fbc724
# ╠═a241116b-939f-481b-85ee-d9505d54e23c
# ╠═c9fbab7a-dd22-4404-ad27-0b2efd7986a4
# ╠═4d614167-92d9-4b29-a79d-97bd509fbb56
# ╠═f7080776-7257-4d52-883f-5ba29e6d212a
# ╟─864d78ff-4fb7-46de-b783-b3b9ee0016f1
# ╠═186345e6-77a2-4529-b5fd-2227396d7ad7
# ╠═a8c58881-69ef-49d0-9a84-3703a5142358
# ╠═3ba2c2b9-137d-4ab6-bdc9-53ddf405d708
# ╠═1500aef7-4a9a-4fa0-b151-2d3f778cd88c
# ╠═c57b0601-b56a-4bb9-b66e-fb839313af83
# ╠═2697d33b-5054-449c-89d5-a6df43ac7eb5
# ╠═34aeeee2-ebae-4ecd-a2fe-980033985ac0
# ╠═9dfbaeb4-a6aa-4f7b-a59c-ba9c9b0862fd
# ╠═1e182418-b12c-4fc7-91d8-f701078e76d1
# ╠═33d2ab1f-65e7-46df-bb41-2282470c85d7
# ╠═ddfe8ae6-c7e5-4747-b66f-706474af7791
# ╟─4933eac8-1847-467e-931b-a8486a1692fd
# ╟─25f70a05-ce58-4bb2-b45b-a77978701196
# ╠═7209486c-229c-480f-a91e-6fd676c44886
# ╠═24eece44-8ae9-4c40-bc56-0feffa3e8902
# ╠═ae298b4a-315a-4b3c-a2f5-4bd7d2edc889
# ╠═92eb506b-e0ba-4545-b186-4753cd4f7940
# ╟─bb497107-31e8-4f5b-8125-2cf311017fd7
# ╠═d9ff76e8-a489-496e-a2b8-3007a4179ca0
# ╠═0b04fe18-4681-4973-95a6-80b28ff30309
# ╠═8f8dda6b-3c44-4b4f-969c-cc1512f903aa
# ╠═82468da0-af9d-4bbc-b048-f66a9a6fbd58
# ╠═f41b1faa-7f3e-4dd2-b2cd-1f8228769bbd
# ╠═8c8ce307-70af-470e-a741-0332f32553cd
# ╠═89bcb694-f093-4cfc-9d86-e2fdbb5f73c9
# ╠═83f3d0eb-bee9-45f8-aeb7-87951f062390
# ╠═76b0f767-1b80-4cad-ac65-ce713bfdac49
# ╟─c2f95c88-082a-48cf-8bc8-aabb191f55a5
# ╠═c010a2e4-cb6c-4643-b3bc-0ee70b05c589
# ╠═d6cf4fe9-e740-48c5-a42c-c277f571fb08
# ╠═bab90c8a-53b0-4ed7-843b-15eeecb3a2ce
# ╠═59d0bfa6-7193-423d-b49d-5aaabb6d4c8c
# ╠═50113454-cc2f-4d41-beb2-721c84fc74f8
# ╠═14ca2e29-f3b0-49c2-9925-7ff68d6478b0
# ╠═524a86cf-382d-4056-93d0-1724e6f59b93
# ╠═57a666f4-084c-4037-aef3-e7a5502a7de3
# ╠═8f8db07b-1605-4178-8f2c-d770b0cf5bf0
# ╠═74652b92-d4f0-4d22-911e-b1e0c5606505
# ╟─53565b84-62f6-4358-bcb9-d5901cb04aca
# ╠═84650073-7f3b-4fc6-afde-c5028861c215
# ╠═935c0ad6-3e76-4b35-a071-0d7372d81e52
# ╠═0ef7909b-03dc-4049-b9db-00b18c5514e9
# ╠═e79b8ba6-09ce-457f-8ca0-d2a308542c58
# ╠═b90c7f44-5381-4fa3-b13c-8938d318b828
# ╠═e3d411ea-ebfc-45f7-ad15-03a7e1617e2d
# ╠═d1e287a4-8498-41b6-8d11-b824c6bc7ab3
# ╠═dc50eb6f-e75f-4e62-8c68-1fad8e83e689
# ╠═640af146-783f-4b36-9d07-ffc89ea87664
# ╠═ca6669ab-4960-4678-8374-b2f2f30f50cf
# ╠═c8190287-f681-4187-8a7d-5c5e3959ae4d
# ╠═87467d80-a07b-4e7b-9156-52cf9f0b8a95
# ╠═11ced7f2-e652-42d8-92e8-fe9875ec44e8
# ╠═3b949808-af1b-41d2-8a25-613646c45bab
# ╠═b9b8aa9a-72e0-4d7e-8a6c-8c73cfea1c54
# ╠═a5bd1aaf-c67e-4114-bb10-76225e0e70d7
# ╠═189ea466-9704-42e9-aa49-518ef87e82f3
# ╠═fda5e034-e26a-4dd3-987e-46e5f6f534b1
# ╠═9a8c822e-01d8-4bac-881f-30e9271b4ccd
# ╠═0b1544d5-d76a-4cc5-a345-b050d99ead27
# ╠═565d0458-0b5b-4d22-8a28-d3607aaf82e3
# ╠═e3cc57bc-0990-4baa-b3b5-19f4c3b587a0
# ╠═5b48e322-004f-4c2c-a3d7-c9852124a9c3
# ╠═14b0fffb-b874-486c-b14c-cbd424b12b26
# ╠═15d3b749-d6c0-43a4-9d74-29b6b11f1237
# ╠═7d0c280c-1f7e-4dce-849b-1ca4bc452e84
# ╠═30ef666d-1695-4e50-a28c-4cdb29722a8c
# ╠═eb1b497a-89d5-49d4-a6de-360387b42d34
# ╠═70a5f442-aa4c-4f62-9ac0-dcf4698c8063
# ╠═1db71d0a-38e0-41fc-8caf-a98e5178f9b9
# ╟─2c07ccdb-f9a9-4ede-a8fd-0c86af0d03d5
# ╟─423f6e08-ecea-4d7c-a37c-8e7d15e4deea
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
