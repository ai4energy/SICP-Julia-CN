### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 3d033066-0bee-48e9-a4d0-be0e0afdfe68
using Primes

# ╔═╡ ba6ee9c0-0999-11ec-3197-6b273cb47913
md"
=====================================================================================
### SICP: [2.2.3 Sequences As Conventional Interfaces（序列作为一种约定的界面）](https://sarabander.github.io/sicp/html/2_002e2.xhtml#g_t2_002e2_002e3)
=====================================================================================
"

# ╔═╡ 438e40ec-ac14-4541-9086-c051bcf97372
md"
#### 2.2.3.1 SICP-Scheme like *functional* Julia
"

# ╔═╡ aefb9021-5b2c-4b53-8bd6-e14cf4a887b0
md"
##### Introduction
"

# ╔═╡ 94ec5754-ef71-44fb-90e8-a76a54107a27
md"
###### Declaration of [Composite Type](https://docs.julialang.org/en/v1/manual/types/#Composite-Types) $$Cons$$
"

# ╔═╡ 4701208f-3d6b-4039-a9fc-c3de51dd1a60
struct Cons
	car
	cdr
end

# ╔═╡ 04d6ca0c-f67d-4cea-9166-20d98115f350
md"
###### 1st (default) *untyped* method of Scheme-like *constructor* function $$cons$$
"

# ╔═╡ d1bb66f0-18f0-4caf-b44c-7a8f27304859
# idiomatic Julia with 1st method of cons
cons(car, cdr) = Cons(car, cdr) 

# ╔═╡ fc576d60-5ada-4348-a753-b86a81793d01
md"
###### 1st (default) *untyped* method of Scheme-like *selector* function $$car$$
"

# ╔═╡ 1ba55e5f-35ad-4fe4-8b76-dee560fe49e8
# 1st method for car
car(cons::Cons) = cons.car
#     ^-------^------------------------- parameter

# ╔═╡ 8aba03d0-b7af-4c5e-b990-f660b0384bc7
md"
###### 1st (default) *untyped* method of Scheme-like *selector* function $$cdr$$
"

# ╔═╡ 044fe2ab-a4f5-40fd-b61e-58f3904ed4ff
# 1st method for cdr
cdr(cons::Cons) = cons.cdr
#     ^-------^------------------------- parameter

# ╔═╡ ede3a48f-71c0-4ddc-8f98-0590b817ef17
md"
###### $$sumOddSquares$$ as conventional *tree recursion* (like $$count\_leaves$$ in 2.2.2)
"

# ╔═╡ 224586f3-1fbb-41c3-bdc9-51229913a699
md"
---
                                          tree1
                           car(tree1) --->  /\  <--- cdr(tree1)
                                          /    \
                                        /       /\
                                      /       /    \
                                    /       /        \
                                  /       /            \
                                /       /                \
                              /       /                    \
                            /       /                        \
                          /       /\                           \
                        /       /    \                           \
                      /       /       /\                           \    
                    /       /       /    \                           \
                  /       /       /        \                          /\
                /       /       /            \                      /    \
              /       /       /\               \                  /\       \
            /       /       /    \               \              /    \       \
          /       /       /       /\              /\          /       /\       \
        /       /       /       /    \          /    \      /       /    \       \
      1       2       3        4    :nil       5    :nil   6      7     :nil    :nil

                               ^--- car(cdr(car(cdr(car(cdr(tree1))))))

Fig. 2.2.3.1 Binary-tree representation of [1, [2, [3, 4], 5], [6, 7]]

---
"

# ╔═╡ 9f0808b5-1130-4603-9f8b-7359560f5672
md"
---
            tree1
              |
              | cdr                                                    
       1      +-----+------------------------------------+------------------+
          car |     |                                    |                  |
       2      |     +-----------------------+-----+      +-----+-----+      |
              |     |     |                 |     |      |     |     |      |
       3      |     |     +-----+-----+     |     |      |     |     |      |
              |     |     |     |     |     |     |      |     |     |      |
       4      1     2     3     4   :nil    5   :nil     6     7   :nil   :nil

                                ^--- car(cdr(car(cdr(car(cdr(tree1))))))

Fig. 2.2.3.2 Tree-representation of [1, [2, [3, 4], 5], [6, 7]]

---
"

# ╔═╡ 405e17a8-b601-4668-8fc0-cd5a2e99e81e
md"
###### $$even\_fibs$$ as conventional *recursion*
"

# ╔═╡ 2d45ac6d-fc78-48b6-a1c1-3bf8923c857e
md"
##### Sequence Operations
"

# ╔═╡ 9f64b774-8333-48d0-9a60-aede670db6ff
square(x) = *(x, x)

# ╔═╡ 93c3d676-aa0f-40b3-8c57-fd28ca5acf0c
md"
###### 1st (default) *untyped* method of Scheme-like function $$filter2$$
Julia's Base.filter is *different* (see below)
"

# ╔═╡ 602ecf93-2e61-44bc-ab45-06477fdff6f6
md"
###### 1st (default) *untyped* method of Scheme-like function $$accumulate2$$
Julia's Base.accumulate is *different* (see below)
"

# ╔═╡ 8ecd4de0-f81f-4aee-aed9-c85312138bc1
md"
###### 1st (default) *untyped* method of Scheme-like function $$enumerate\_interval$$ ...
###### .... *but* with *keyword* parameter $$initial=:nil$$
"

# ╔═╡ c5992151-e61d-4672-939b-931090fc4275
md"
---
                                    tree2
                      car(tree2) --->  /\  <--- cdr(tree2) 
                                     /    \
                                   /       /\
                                 /       /    \                                     
                               /       /        \                     
                             /       /\           \                            
                           /       /    \           \                         
                         /       /       /\           \                      
                       /       /       /    \           \                   
                     /       /       /\       \           \                
                   /       /       /    \       \           \           
                 /       /       /       /\       \          /\         
               /       /       /       /    \       \      /    \
              1       2       3       4    :nil    :nil   5    :nil 

                                      ^--- car(cdr(car(cdr(car(cdr(tree2))))))

Fig. 2.2.3.1 Binary-tree representation of [1, [2, [3, 4]], 5]

---
"

# ╔═╡ 054cd582-16ec-4c27-8504-192a437e254e
md"
---
                        tree2
                          |
                          | cdr
                   1      +-----+-----------------------------+-----+
                      car |     |                             |     |
                   2      |     +-----------------------+     |     |
                          |     |     |                 |     |     |     
                   3      |     |     +-----+-----+     |     |     |  
                          |     |     |     |     |     |     |     |     
                   4      1     2     3     4   :nil  :nil   5    :nil    

                                            ^--- car(cdr(car(cdr(car(cdr(tree2))))))

Fig. 2.2.3.2 Tree-representation of [1, [2, [3, 4]], 5]

---
"

# ╔═╡ 130a22a0-bbfd-4d69-bd99-194d71906f75
md"
###### function $$enumerate\_tree$$ is defined further below because we use an $$Union$$-type
"

# ╔═╡ 131bbb1f-25c1-4bd2-af72-4177ebda209e
md"
---
          +---------+        +---------+         +--------+         +---------+
          | enumer- |        |         |         |        | squared | accu-   | sum-
     tree |  ate:   | leaves | filter: |  odd    |  map:  |   odd   | mulate: | odd-
    ----->+         +------->+         +-------->+        +-------->+         +-->
          | leaves  |        |  odd?   | leaves  | square | leaves  | +, 0    | sqrd
          +---------+        +---------+         +--------+         +---------+ leaves

Fig. 2.2.3.3 Signal-flow plan for 'sum-odd-squares'

---
"

# ╔═╡ c7615112-8c03-43fb-ad3a-e979f6ae951f
md"
---

          +----------+        +--------+        +---------+         +---------+
          | enumer-  |        |        |        |         |         | accu-   | list
     tree |  ate:    |        |  map:  |  fibs  | filter: |  even   | mulate: | of
    ----->+          +------->+        +------->+         +-------->+         +-->
          | integers |        |  fib   |        |  even?  |  fibs   | cons,() | even
          +----------+        +--------+        +---------+         +---------+ fibs

Fig. 2.2.3.2 Signal-flow plan for 'even-fibs'

---
"

# ╔═╡ ee509ed5-31b9-4657-858c-1dd6e6749c96
records =
 [  [:joe,   :carpenter,    40000],
	[:jim,   :butcher,      45000],
	[:buddy, :software_dev, 50000],
	[:susi,  :software_dev, 52000],           # <== highest software_dev's salary
	[:joanne,:psychologist, 35000],
	[:fred,  :physician,    60000],
    [:syrah, :lawyer,       80000]]
	

# ╔═╡ 56837c07-91a6-452b-8c3a-854bbe6a8423
md"
##### Nested mappings
"

# ╔═╡ 804a253f-28c4-4eb7-8bc9-ac00c3d80f6d
md"

Given a positive integer $$n$$, find all ordered pairs of distinct positive integers $$i$$ and $$j$$, where 

$$1 \le i \lt j \le n,$$

such that $$i + j$$ is prime. (SICP, 1996, p.122)

$$\{(i, j)| 1 \le i \lt j \le n; i,j \in \mathbb{N}, (i + j)\in \mathbb{P}\}$$

##### 
... the solution in Julia for $$n=6$$ is first *unfiltered* then *prime-filtered*:
"

# ╔═╡ 525716f9-cb91-4bf3-92ff-1a5734aeb87b
md"
##### ... SICP-solution transpiled to Julia
"

# ╔═╡ bfaec430-7fc3-4c0f-bf45-0eb87f60dbe3
n = 5

# ╔═╡ 0d153832-c688-4a2a-b7b9-3caceffbd9e3
md"
---
#### 2.2.3.2 Idiomatic *imperative* or *typed* Julia
"

# ╔═╡ 4f873aed-cd34-4309-b3dd-5574d3f41e49
md"
##### Introduction
"

# ╔═╡ bebbb626-47fc-489b-9d62-0839fe196f84
md"
##### Declaration of Type $$Atom$$ as a $$Union$$-Type
"

# ╔═╡ 4c7c873c-21ec-4bf9-a265-fd57e8517cbd
Atom = Union{Number, Symbol, Char, String}

# ╔═╡ 90bb33dc-0e55-480a-8b05-74951991a30b
md"
###### 2nd (specialized) *typed* method of function $$cons$$
"

# ╔═╡ af0c54b1-ac51-4ab0-9a36-380668deb711
# idiomatic Julia with 2nd method of cons
function cons(car::Atom, list::Array)::Array
	pushfirst!(list, car)
end

# ╔═╡ f8fff2ef-3b91-4f56-8e80-838073dd1735
md"
###### 3rd (specialized) *typed* method of function $$cons$$
"

# ╔═╡ 6bc3d0dc-1a83-4016-a5aa-8f5622e11a81
# idiomatic Julia with 3rd method of cons
function cons(list1::Array, list2::Array)::Array
	list1 = push!([], list1)
	append!(list1, list2)
end

# ╔═╡ 450f2841-faae-486c-900d-3b830da5b2bd
function enumerate_interval(low, high; initial = :nil) # keword parameter 'initial'
	if >(low, high)              #   ^----------------- semicolon
		initial
	else
		cons(low, enumerate_interval(+(low, 1), high; initial)) # keyword argument !
	end # if                                    #   ^----------------- semicolon
end # function enumerate_interval

# ╔═╡ ceee3d88-7d76-482e-8eb0-6bb7bbb75b7a
enumerate_interval(2, 7)     # no keyword argument; should be pretty-printed with 'pp'

# ╔═╡ 06f50446-19fe-4826-be42-d9507f2d552a
enumerate_interval(2, 7, initial=[]) # with keyword argument 'initial=[]' !

# ╔═╡ 4f06457e-7100-4798-b47c-aa87e6be98da
md"
###### 2nd (specialized) *typed* method of selector function $$car$$ using arrays
"

# ╔═╡ ba557a9d-8a5a-450b-ae24-48636edd5190
# 2nd method for car
car(x::Array)::Any = x[1]

# ╔═╡ 468937c2-08e9-4d2f-9e5c-0427c52cab4f
md"
###### 2nd (specialized) *typed* method of selector function $$cdr$$ using arrays
"

# ╔═╡ aaf1fddb-440f-4d64-8ee2-17e4463b78a5
# 2nd method for cdr
cdr(x::Array)::Array = x[2:end]

# ╔═╡ 069ee324-eceb-4f42-ae20-aac2e4478b2b
function sumOddSquares(tree)
	#-----------------------------------------------------------------------
				null = isempty         # Julia Base.isempty(collection) -> Bool
	isnumber(x::Any) = typeof(x) <: Number
	          isleaf = isnumber
	       square(x) = *(x, x)
	             odd = isodd           # Julia Base.isodd(x::Number) -> Bool
	#-----------------------------------------------------------------------
	if null(tree)                      # is tree empty ?
		0
	elseif isnumber(tree)              # is leaf ?   
		odd(tree) ? square(tree) : 0   # if is leaf odd ?  then square
	else
		+(sumOddSquares(car(tree)), sumOddSquares(cdr(tree))) # tree recursion
	end
end

# ╔═╡ ea228836-2583-4b0e-9f7a-c2d50f9f8230
function filter2(predicate, sequence)     # Base.filter is Julia builtin function
	#---------------------------------------------------------
	null = isempty
	#---------------------------------------------------------
	if null(sequence)
		[]
	elseif predicate(car(sequence))
		cons(car(sequence), filter2(predicate, cdr(sequence)))
	else
		filter2(predicate, cdr(sequence))
	end # if
end # function filter2

# ╔═╡ bb4388e8-91f0-41f6-ae17-ae50c512c6e3
filter2

# ╔═╡ e2bb2ed2-de48-4e53-b566-1e9b6f6c3aa1
# 'accumulate' is Julia's accumulate(op, A; dims::Integer, [init])
function accumulate2(op, initial, sequence) 
	#-------------------------------------------------------------
	isnull = isempty  # Julia's Base.isempty - function 'isempty'
	#-------------------------------------------------------------
	if isnull(sequence)
		initial
	else
		op(car(sequence), 
			accumulate2(op, initial, cdr(sequence)))
	end # if
end # function accumulate

# ╔═╡ e91a0596-8401-4e34-b1ab-17d6eae08801
function productOfSquaresOfOddElements(sequence)
	accumulate2(*, 1, map(square, filter2(isodd, sequence)))
end

# ╔═╡ 927365af-503e-4005-951b-28c4fbbee92e
function salaryOfHighestPaidSoftwareDev(records)
	#-------------------------------------------------
	isSoftwareDev(record) = record[2] == :software_dev
	salary(record)        = record[3]
	#-------------------------------------------------
	accumulate2(max, 0, map(salary, filter2(isSoftwareDev, records)))
end

# ╔═╡ f495ea83-a03a-45ec-9e0a-971388120632
salaryOfHighestPaidSoftwareDev(records)           # o.k. if its 52000

# ╔═╡ b4d1e9eb-1367-4dda-935c-8d24712dcd96
function flatmap(proc, seq)
	accumulate2(append!, [], map(proc, seq))
end

# ╔═╡ b94fb940-4cfa-4496-aff6-bdd0014a1c5d
function primeSum(pair)
	#-----------------------------------
	cadr(x) = car(cdr(x))
	#-----------------------------------
	isprime(car(pair) + cadr(pair))
end

# ╔═╡ bd062bda-db6f-4511-b03d-1b156eedb09a
md"
###### 1st (default) method of constructor function $$list$$ with *un*typed input and *typed* output generating arrays
"

# ╔═╡ 87996ca9-84c8-46e9-ba71-89baafc2db28
# n-ary Julia-tuples (similar to Scheme lists) are represented as Julia-arrays
list(xs::Any...)::Array = [xs::Any...]::Array

# ╔═╡ 00e8e8e8-592e-4206-80c9-7308d5d6e151
tree1 = list(1, list(2, list(3, 4), 5), list(6, 7))

# ╔═╡ 8824f5f4-4f29-48d7-8d07-a5a767c47ac4
typeof(tree1) <: Vector <: Array

# ╔═╡ 2bba24d2-79ee-4923-a6b5-e0e9a4d410d9
car(tree1)

# ╔═╡ d63ca7af-a13e-4625-bbf5-6024c6a14247
cdr(tree1)

# ╔═╡ 4c640fed-d04b-4e57-9548-98ce7bac9f34
car(cdr(car(cdr(car(cdr(tree1))))))

# ╔═╡ e5889629-d634-4814-996f-9e59222ce1fe
car(cdr(car(cdr(car(cdr(tree1)))))) == 4

# ╔═╡ dfe2820c-be99-4bda-a48b-64c250938404
sumOddSquares(tree1)          # correct if sumOddSquares(tree1) == 84

# ╔═╡ 340e3dad-8b91-471e-84ed-8e4ac555ef49
map(square, list(1, 2, 3, 4, 5))          # Julia's Base.map — Function

# ╔═╡ 20697309-9d88-4d3f-a153-849f229cf47a
map(list(1, 2, 3, 4, 5)) do n             # Julia's Base.map — Function with 'do'
 	square(n)
end # map

# ╔═╡ 1ee151db-1b91-4400-8474-9d689cb73664
filter2(isodd, list(1, 2, 3, 4, 5))    # Julia's filter function is Base.filter 

# ╔═╡ a9366254-3a82-4252-8c47-9b51b9dd504d
filter2(iseven, list(1, 2, 3, 4, 5))   # Julia's filter function is Base.filter 

# ╔═╡ 7bfc28ac-b41e-4c34-88dc-e74cd363922f
accumulate2(+, 0, list(1, 2, 3, 4, 5))

# ╔═╡ 3a205677-c028-4e3d-bd22-e8fd6afcfc4c
accumulate2(*, 1, list(1, 2, 3, 4, 5))

# ╔═╡ 1b862b47-7789-44d9-9005-ce7b77bec837
# initial is ':nil'; result should be pretty printed !
accumulate2(cons, :nil, list(1, 2, 3, 4, 5))  

# ╔═╡ 956b9ccd-6d8c-4afc-b26c-3f477e8b07fe
accumulate2(cons, [], list(1, 2, 3, 4, 5))            # initial is '[]'

# ╔═╡ 6b73e23d-f041-443f-9db6-8e08804542e4
sum(accumulate2(cons, [], list(1, 2, 3, 4, 5)))       # Julia's sum

# ╔═╡ 19d77c84-8b9b-4c0e-95ff-33667cc461b1
tree2 = list(1, list(2, list(3, 4)), 5)

# ╔═╡ b31bd8a2-ef27-4fc8-9790-3ddbdd540667
car(cdr(car(cdr(car(cdr(tree2))))))

# ╔═╡ f493c8c9-4399-475f-9d8a-9aa2b5aa38ea
car(cdr(car(cdr(car(cdr(tree2)))))) == 4

# ╔═╡ 85e2f791-7498-413c-8216-f9ef5c2abd44
tree2                         # tree2 *not* modified !

# ╔═╡ 07720d55-52a0-409a-9f56-d0525e25f129
productOfSquaresOfOddElements(list(1, 2, 3, 4, 5))

# ╔═╡ 43279a01-aded-4f22-a5d4-97057e850dda
nestedListOfOrderedPairs =
	let n = 6
		map(j -> map(i -> list(i, j), 
					enumerate_interval(1, j-1, initial=[])), 	# i
			enumerate_interval(1, n, initial=[]))               # j
	end # let

# ╔═╡ d5551946-391c-479c-bb26-0f3cbd0d46aa
reducedFilteredList = 
	reduce(vcat, map(shortList -> filter2(item -> typeof(item) <:Array, shortList), 					nestedListOfOrderedPairs))

# ╔═╡ ed86ac5c-b2db-4ffe-862c-72e590b6ef65
primeList = 
		filter2(pair -> isprime(pair[1]+pair[2]), reducedFilteredList)

# ╔═╡ 657cb8a0-892f-4e37-83da-8785b20f848e
primeTable =
	sort(
		map(pair->
			let prime = (pair[1]+pair[2])
				(pair[1], pair[2], '|' , prime)
			end, # let
		primeList))

# ╔═╡ 46aafc6d-96ec-4574-a294-8dc3fa9475fe
["j   |", map(tuple->tuple[1], primeTable),
 "  i |", map(tuple->tuple[2], primeTable),
 "i+j |", map(tuple->tuple[3], primeTable)]

# ╔═╡ f2a779f5-d408-467b-9713-c58fe4db6913
let n = 5
	accumulate2(append!, [], 
		map(j -> map(i -> list(i, j), 
					enumerate_interval(1, j-1, initial = [])), # i
			enumerate_interval(1, n, initial = [])))           # j
end # let

# ╔═╡ 19fa3b90-7cae-48dc-95e4-0fa63d4e0339
function makePairSum(pair)
	#-----------------------------------
	cadr(x) = car(cdr(x))
	#-----------------------------------
	list(car(pair), cadr(pair), '|', +(car(pair), cadr(pair)))
end

# ╔═╡ 977a9138-6530-4eaa-8b5f-df45c43864db
function primeSumPairs(n)
	map(makePairSum, 
		filter2(primeSum, 
			flatmap(j -> map(i -> list(i, j), 
					enumerate_interval(1, j-1, initial = [])), 
				enumerate_interval(1, n, initial = []))))
end

# ╔═╡ f3f113a7-274c-4849-b163-ce2290db14b7
primeSumPairs(6)

# ╔═╡ 29fa3f53-4193-465d-b44f-c72510d22725
function permutations(s)
	#-----------------------------------------------------------
	null = isempty
	remove(item, sequence) = filter2(x -> !(x == item), sequence)
	#-----------------------------------------------------------
	if null(s)
		list([])
	else
		flatmap(x -> map(p -> cons(x, p),
				permutations(remove(x, s))), 
			s)
	end
end

# ╔═╡ 02aa90e1-3603-4248-a84e-02cff6efbd41
permutations([1, 2, 3]) 

# ╔═╡ c4492c39-1576-4058-937b-74ffb4a10d4a
length(permutations([1, 2, 3]))            # n! = 3! = 3*2*1 = 6

# ╔═╡ b7940f89-9e29-4411-b387-cddc2ac5dc98
permutations([1, 2, 3, 4])

# ╔═╡ a97870e3-5b41-4b2d-bb7d-42ae62957873
length(permutations([1, 2, 3, 4]))        # n! = 4! = 4*3*2*1 = 24

# ╔═╡ 51c051a4-2376-40c8-a439-dacbde2b4dc4
function permutations2(s)
	#-----------------------------------------------------------
	null = isempty
	remove(item, sequence) = filter2(x -> !(x == item), sequence)
	#-----------------------------------------------------------
	if null(s)
		list([])
	else
		flatmap(x -> map(p -> cons(x, p),
				permutations2(remove(x, s))), 
			s)
	end
end

# ╔═╡ d07b04f7-a9d4-4573-816e-8f1bf565ff2a
permutations2([1, 2, 3])

# ╔═╡ 9db4540d-9498-49c4-95f0-bbbf593bd26a
length(permutations2([1, 2, 3]))           # n! = 3! = 3*2*1 = 6

# ╔═╡ 0ace7457-0f48-4cec-ae8d-ed3407cdd1e5
permutations2([1, 2, 3, 4])

# ╔═╡ b1ceefc6-53dd-464e-9441-45576f582efb
length(permutations2([1, 2, 3, 4]))        # n! = 4! = 4*3*2*1 = 24

# ╔═╡ df45e72d-c361-49a7-8be0-dff4e69f5cba
#---------------------------------------------------------------------------
# idiomatic Julia: backward 'for' and parallel assignment
#---------------------------------------------------------------------------
function fib6(n)
	a     = 1
	b     = 0
	for count = n:-1:1 # from n downto 1 in steps with width 1
		a, b = a + b, a
	end
	b
end

# ╔═╡ cae46dcc-0a3b-4dab-8139-b57c7946a155
function even_fibs(n; nil = [])
	#-------------------------------------------
	even = iseven
	#-------------------------------------------
	function next(k)
		if >(k, n)
			nil
		else
			let f = fib6(k)
				if even(f)
					cons(f, next( +(k, 1)))
				else
					next( +(k, 1))
				end # if
			end # let
		end # if
	end # function next(.)
	#-------------------------------------------
	next(0)
end # function even_fibs

# ╔═╡ a3dc4444-f515-4e06-8985-959d9c0f72ae
even_fibs(10)

# ╔═╡ 7fd4b1d0-793e-4988-b32f-51b3f06b80b5
even_fibs(10; nil=:nil)

# ╔═╡ 262fecaf-08ed-48bb-88b3-7891fbb188bf
 # keyword argument 'initial=[]' is *necessary* to generate an array within 'map'
function even_fibs2(n)
	accumulate2(cons, [], filter2(iseven, map(fib6, enumerate_interval(0, n, initial=[]))))          
end

# ╔═╡ 84669c73-9668-43e4-9201-0b82ec95d9d2
even_fibs2(10)

# ╔═╡ 6c87b825-e4d4-4a58-8730-033798ad4dc7
filter(iseven, map(n -> fib6(n), 0:10))   #  Julia's Base.filter — Function

# ╔═╡ dd5aff36-30ff-41c7-8cad-838f92a86ea8
#-----------------------------------------------------------------------------------
# this method pretty-prints a latent hierarchical cons-structure 
#    as a manifest nested array structure
#-----------------------------------------------------------------------------------
function pp(consList::Cons)::Array
	#-------------------------------------------------------------------------------
	function pp_iter(arrayList, shortList)
		if shortList == :nil
			arrayList
		elseif car(shortList) == :nil && car(shortList) == :nil
			arrayList
		# one-element list
		elseif (typeof(car(shortList)) <: Atom) && (cdr(shortList) == :nil)
			push!(arrayList, car(shortList)) 
		# flat multi-element list
		elseif (typeof(car(shortList)) <: Atom) && (typeof(cdr(shortList)) <: Cons)
			pp_iter(push!(arrayList, car(shortList)), cdr(shortList))
		# nested sublist as last element of multi-element list
		elseif (typeof(car(shortList)) <: Cons) && (cdr(shortList) == :nil)
			pp_iter(push!(arrayList, pp(car(shortList))), cdr(shortList))
		# nested sublist as first element of multi-element list
		elseif (typeof(car(shortList)) <: Cons) && (typeof(cdr(shortList)) <: Cons)
			pp_iter(push!(arrayList, pp(car(shortList))), cdr(shortList))
		else
			"unknown case"
		end # if
	end # pp_iter
	#-------------------------------------------------------------------------------
	pp_iter([], consList)
end

# ╔═╡ e435940c-d785-4c97-aba3-d26abc42e977
pp(even_fibs(10; nil=:nil))

# ╔═╡ 8edb760b-e4ab-4354-8b2c-b53aa15d0a7f
pp(accumulate2(cons, :nil, list(1, 2, 3, 4, 5)))      # pretty-printed as array !

# ╔═╡ dcdb3dbc-5415-4c21-8431-da7bba9553ef
sum(pp(accumulate2(cons, :nil, list(1, 2, 3, 4, 5)))) # Julia's Base.sum - Function

# ╔═╡ 773d8b55-0e59-4272-aea1-a5b5eee4966a
pp(enumerate_interval(2, 7))         # pretty-printed as array

# ╔═╡ f3392214-43c1-4086-bf3a-2dabd678a900
md"
---
##### Sequence Operations
"

# ╔═╡ 03dd4154-4bf1-4059-9511-a78e030a2d9d
md"
##### Declaration of $$Union$$-Type $$FloatOrSigned$$
"

# ╔═╡ 94e37ee5-3158-446d-8422-db00d92910ba
subtypes(AbstractFloat)

# ╔═╡ 65f4abb9-e159-4188-9e37-def73f9fb160
FloatOrSigned = Union{AbstractFloat, Signed}

# ╔═╡ da5ddbad-2fb9-419d-9a09-1f3bb8fb6331
md"
###### 1st (specialized) *typed variant* of function $$accumulate$$ based on Julia's $$reduce:$$
$$reduce := reduce(op, itr; [init])$$
"

# ╔═╡ 06047667-04c2-4ebe-922c-632521cbd084
#= idiomatic Julia-code by substuting 2nd typed method of function 'accumulate2' by Julia's 'reduce' and keyword parameter 'init=...' =#
function accumulate3(op::Function, initial::FloatOrSigned, 	sequence::Vector{<:FloatOrSigned})::FloatOrSigned
		reduce(op, sequence; init=initial)
end

# ╔═╡ 34843a75-2a2c-4e2d-a8c9-ca2dea293914
accumulate3(+, 0, list(1, 2, 3, 4, 5))

# ╔═╡ fb7dd33e-4d99-4997-81bf-3eb8f36a866f
accumulate3(*, 1, list(1, 2, 3, 4, 5))

# ╔═╡ e1aa0ec9-bf27-4268-b60c-42847affc432
md"
###### 1st (specialized) *typed variant* of function $$accumulate$$ based on Julia's $$foldl:$$
$$foldl := foldl(op, itr; [init])$$

"

# ╔═╡ c8c19b7b-ee0e-434a-874e-cb4485b7e80b
# idiomatic Julia-code by substuting 'accumulate' by Julia's 'foldl' and keyword parameter 'init=...'
function accumulate4(op::Function, initial::FloatOrSigned, sequence::Vector{<:FloatOrSigned})::FloatOrSigned
	foldl(op, sequence; init=initial)
end

# ╔═╡ 9f7b140d-7f04-4988-9706-cf7141b9ee9b
accumulate4(+, 0, list(1, 2, 3, 4, 5))

# ╔═╡ 1320fd17-bb69-415a-8ced-a7d300a9b179
accumulate4(*, 1, list(1, 2, 3, 4, 5))

# ╔═╡ 38362da7-c423-4060-a5ca-4822294c8a49
md"
###### 1st (specialized) *typed variant* of function $$accumulate$$ based on Julia's $$foldr:$$
$$foldr := foldr(op, itr; [init])$$
"

# ╔═╡ b430b97f-8ba6-4a0c-a663-4ff3f28d5698
# idiomatic Julia-code by substituting 'accumulate' by Julian 'foldr' and keyword parameter 'init=...'
function accumulate5(op::Function, initial::FloatOrSigned, sequence::Vector{<:FloatOrSigned})::FloatOrSigned
	foldr(op, sequence; init=initial)
end

# ╔═╡ c7a7dfb4-f052-4fa5-ab3b-efc78319f0bd
accumulate5(+, 0, list(1, 2, 3, 4, 5))

# ╔═╡ 9b5fc090-e7d5-4783-8c69-e630f203ab04
accumulate5(*, 1, list(1, 2, 3, 4, 5))

# ╔═╡ 77d8dde4-8b75-49f0-9585-14961937b9e0
md"
###### Declaration of $$Union$$-Type $$FloatOrSignedOrError$$
"

# ╔═╡ efb06abb-c8cd-4778-89e7-44c5eaaf2986
FloatOrSignedOrError = Union{AbstractFloat, Signed, String}

# ╔═╡ e47d1e7d-9671-4972-a98d-35cbdbbd29c7
md"
###### 1st (specialized) *typed variant* of function $$accumulate$$ based on Julia's $$sum:$$
$$sum := sum(f, itr; [init])$$
"

# ╔═╡ dd6f57bb-fea6-4538-b29c-2cafc5e3b9e5
function accumulate6(op::Function, 
	initial::FloatOrSigned, 
	sequence::Vector{<:FloatOrSigned})::FloatOrSignedOrError
	(op == +) ? sum(sequence) : "error: op not +"
end

# ╔═╡ 499bda9e-01f3-4db4-adbd-7f7f529fbfbe
accumulate6(+, 0, list(1, 2, 3, 4, 5))

# ╔═╡ 96b34aed-7c89-48f6-96c2-229c0d2f43bd
accumulate6(*, 1, list(1, 2, 3, 4, 5))  # expects '+' as argument for parameter 'op'

# ╔═╡ d5a40063-9b03-46e2-8607-3081d524b17a
md"
##### Declaration of $$Union$$-Type $$ConsOrArray$$
"

# ╔═╡ 2f6353b8-663a-4ce0-b98b-3433f9932eec
ConsOrArray = Union{Cons, Array}

# ╔═╡ 68c176c8-0892-42ed-bed1-5d8f7a02b33d
md"
###### 2nd (specialized) *typed* method of function $$enumerate\_interval$$ with Julia's $$foldr:$$
$$foldr := foldr(op, itr; [init])$$
"

# ╔═╡ 69ad7e44-b690-44d3-8b70-0dec997e4a26
# idiomatic Julia-code with rightassociative 'foldr'
function enumerate_interval2(low, high; initial=:nil)::ConsOrArray
	foldr(cons, [i for i=low:high]; init=initial)
end

# ╔═╡ 1340206a-e4b9-4445-8e12-e14d0d2e81a0
 # keyword argument 'initial=[]' is *necessary* to generate an array within 'map'
function listFibSquares(n)
	accumulate2(cons, [], map(square, map(fib6, enumerate_interval2(0, n, initial=[]))))
end

# ╔═╡ f3c7318e-eeb0-4716-b7ab-aceab779e9d6
listFibSquares(10)

# ╔═╡ 84cdc675-988f-4e73-aeaa-c948e27df9a7
enumerate_interval2(2, 7) # without keyword argument; must be pretty-printed

# ╔═╡ 6777ff71-2096-494b-bb3d-fd95bdd3ec8b
pp(enumerate_interval2(2, 7))  # pretty-printed

# ╔═╡ d013a895-5e83-4a39-9185-20ff9b3db4e6
# with keyword argument; need not be pretty-printed
enumerate_interval2(2, 7, initial=[]) 

# ╔═╡ a3bf178d-d1f2-4ca8-90fc-56670c5208a6
md"
###### 3rd (specialized) *partial typed* variant of function $$enumerate\_interval$$ ...
"

# ╔═╡ 7a6b6044-6751-4041-99e7-0a608019110f
# idiomatic Julia with array comprehension
function enumerate_interval3(low, high)::Array
	[i for i=low:high]
end

# ╔═╡ e6477766-999b-485a-abf8-a5dcf99c7690
enumerate_interval3(2, 7)

# ╔═╡ 08bdfd0b-be0b-44bc-ba71-adbe8c23f742
AtomOrArray = Union{Atom, Array}

# ╔═╡ 6b04606d-b595-4baa-9a82-f85d3ace78b1
md"
###### Declaration of $$Union$$-Type $$AtomOrArray$$
"

# ╔═╡ 5e0adaac-e483-4b9f-a365-6dd843fa1bd7
function enumerate_tree(tree::AtomOrArray)
	if isempty(tree)
		tree
	elseif typeof(tree) <: Atom
		list(tree)
	else
		append!(enumerate_tree(car(tree)), enumerate_tree(cdr(tree)))
	end # if
end # function enumerate_tree

# ╔═╡ f5a765fe-e03f-4bea-9d26-e4faf548cf8a
enumerate_tree(tree2)

# ╔═╡ 1f7ce44a-9720-404f-847c-c36601874396
function sumOddSquares2(tree)
	accumulate2(+, 0, map(square, filter2(isodd, enumerate_tree(tree))))
end

# ╔═╡ d7a64fd1-7c9d-43af-bd89-58492a633f12
sumOddSquares2(tree1)

# ╔═╡ 06ee405c-1a4d-46ea-a198-7ee15184c2a8
sumOddSquares2(tree2)

# ╔═╡ b2b81a77-78e2-43a4-ba1a-0cc182035faf
enumerate_tree(tree1)

# ╔═╡ fb2c97b5-3eec-467a-ba90-0518ef5c8ba1
enumerate_tree(tree2)

# ╔═╡ 7aae8e88-8d5b-4df1-94de-ace9635f6058
md"
---
##### 2.2.3.3 Idiomatic Julia *Interfaces* with $$filter$$, $$accumulate$$, $$iterate$$
"

# ╔═╡ f8ef8cf1-009e-4b0e-8295-8a914900ef0b
md"
##### Sequence Operations
"

# ╔═╡ 250bcc9f-1f6d-4265-b1ad-3a2784b7cc8a
filter(isodd, list(1, 2, 3, 4, 5))     # Julia's filter function is Base.filter

# ╔═╡ 0828af1f-f07e-4f39-b572-dd99fa8386ce
filter(iseven, list(1, 2, 3, 4, 5))    # Julia's filter function is Base.filter

# ╔═╡ c1692293-64d7-4686-b05b-acaf2c783757
md"
###### Julia's $$accumulate:$$
$$accumulate := accumulate(op, A; dims::Integer, [init])$$
"

# ╔═╡ 1051d718-8a92-4db7-80ca-6d128b442a63
# Julia's accumulate(op, A; dims::Integer, [init])
accumulate(+, list(1, 2, 3, 4, 5), init=0)  

# ╔═╡ 0f951595-bca4-40eb-b43c-1f8a89ddf560
last(accumulate(+, list(1, 2, 3, 4, 5), init=0))

# ╔═╡ 22ef4c14-bc21-44f2-be29-c57c9bad01c3
last(accumulate(+, list(1, 2, 3, 4, 5), init=0)) == sum(list(1, 2, 3, 4, 5))

# ╔═╡ da2d81cd-8247-4882-8d00-7d1d07130cb3
accumulate(*, list(1, 2, 3, 4, 5), init=1)

# ╔═╡ 1089ba05-c3e1-4328-90c3-f07c83696df7
last(accumulate(*, list(1, 2, 3, 4, 5), init=1))

# ╔═╡ 01e8598d-b761-4904-8871-764359fd7738
last(accumulate(*, list(1, 2, 3, 4, 5), init=1)) == prod(list(1, 2, 3, 4, 5))

# ╔═╡ 5086fdfa-df90-486b-8679-633b9da22808
accumulate(cons, list(1, 2, 3, 4, 5), init=:nil)  

# ╔═╡ 1fc937a4-60ac-4d82-8d9f-94677071d552
last(accumulate(cons, list(1, 2, 3, 4, 5), init=:nil)) # this is *not* (1, 2, 3, 4, 5)

# ╔═╡ b7e645ca-a545-455e-b9ef-944da3ebf0b8
md"
###### 4th (specialized) *partial typed* variant of function $$enumerate\_interval$$ ... using of Julia's $$iterate:$$ with $$iter  = (high: -1 : low)$$

$$iterate := iterate(iter [, state]) -> Union\{Nothing, Tuple\{Any, Any\}\}$$

"

# ╔═╡ 1b592487-ad22-4f14-b374-87743b8ec134
function enumerate_interval4(low, high; initial=:nil)
	let intvl = initial
		iter  = (high: -1 : low)
		next = iterate(iter)
		while next !== nothing
			(item, state) = next
			intvl = cons(item, intvl)
			next = iterate(iter, state)
		end # while
		intvl
	end # let
end

# ╔═╡ 89b98a66-0378-47e6-8eb6-77f23406b96b
enumerate_interval4(2, 7)                     # without keyword argument 'initial'

# ╔═╡ 575e5f9c-7a21-4250-9b2e-bbb42bd1ed4c
pp(enumerate_interval4(2, 7))

# ╔═╡ a94203ea-b828-457a-a58e-3362a0307f2e
enumerate_interval4(2, 7; initial=[])         # with keyword argument 'initial=[]'

# ╔═╡ 94efad05-8481-4cd6-a9cb-829671c29c4d
md"
###### 5th (specialized) *partial typed* variant of function $$enumerate\_interval$$
using iterate $$IntervalDown(high, low)$$ with $$iter  = (low: +1 : high)$$

$$iterate := iterate(iter [, state]) -> Union\{Nothing, Tuple\{Any, Any\}\}$$
"

# ╔═╡ de2196da-70b9-4c45-9732-ad5b8e7e4a1e
function enumerate_interval5(low, high; initial=:nil)
	let intvl = initial
		iter  = (low: +1 : high)
		next = iterate(iter)
		while next !== nothing
			(item, state) = next
			intvl = cons(item, intvl)
			next = iterate(iter, state)
		end # while
		intvl
	end # let
end

# ╔═╡ 15df85fb-03e5-4f71-a9eb-ea227579c288
enumerate_interval5(2, 7)                     # without keyword argument 'initial'

# ╔═╡ 8dddc5b9-1837-4d90-b99e-67eb047cf834
pp(enumerate_interval5(2, 7))                 # pretty print

# ╔═╡ e27244e4-3002-47c1-ac01-6065017a5c9d
enumerate_interval5(2, 7, initial=[])         # with keyword argument 'initial=[]'

# ╔═╡ a49378fc-331a-47c4-9caa-0a18145fe994
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/09/05
"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"

[compat]
Primes = "~0.5.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Primes]]
git-tree-sha1 = "afccf037da52fa596223e5a0e331ff752e0e845c"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.0"
"""

# ╔═╡ Cell order:
# ╟─ba6ee9c0-0999-11ec-3197-6b273cb47913
# ╟─438e40ec-ac14-4541-9086-c051bcf97372
# ╟─aefb9021-5b2c-4b53-8bd6-e14cf4a887b0
# ╟─94ec5754-ef71-44fb-90e8-a76a54107a27
# ╠═4701208f-3d6b-4039-a9fc-c3de51dd1a60
# ╟─04d6ca0c-f67d-4cea-9166-20d98115f350
# ╠═d1bb66f0-18f0-4caf-b44c-7a8f27304859
# ╟─fc576d60-5ada-4348-a753-b86a81793d01
# ╠═1ba55e5f-35ad-4fe4-8b76-dee560fe49e8
# ╟─8aba03d0-b7af-4c5e-b990-f660b0384bc7
# ╠═044fe2ab-a4f5-40fd-b61e-58f3904ed4ff
# ╟─ede3a48f-71c0-4ddc-8f98-0590b817ef17
# ╠═069ee324-eceb-4f42-ae20-aac2e4478b2b
# ╟─224586f3-1fbb-41c3-bdc9-51229913a699
# ╟─9f0808b5-1130-4603-9f8b-7359560f5672
# ╠═00e8e8e8-592e-4206-80c9-7308d5d6e151
# ╠═8824f5f4-4f29-48d7-8d07-a5a767c47ac4
# ╠═2bba24d2-79ee-4923-a6b5-e0e9a4d410d9
# ╠═d63ca7af-a13e-4625-bbf5-6024c6a14247
# ╠═4c640fed-d04b-4e57-9548-98ce7bac9f34
# ╠═e5889629-d634-4814-996f-9e59222ce1fe
# ╠═dfe2820c-be99-4bda-a48b-64c250938404
# ╟─405e17a8-b601-4668-8fc0-cd5a2e99e81e
# ╠═cae46dcc-0a3b-4dab-8139-b57c7946a155
# ╠═a3dc4444-f515-4e06-8985-959d9c0f72ae
# ╠═7fd4b1d0-793e-4988-b32f-51b3f06b80b5
# ╠═e435940c-d785-4c97-aba3-d26abc42e977
# ╟─2d45ac6d-fc78-48b6-a1c1-3bf8923c857e
# ╠═9f64b774-8333-48d0-9a60-aede670db6ff
# ╠═340e3dad-8b91-471e-84ed-8e4ac555ef49
# ╠═20697309-9d88-4d3f-a153-849f229cf47a
# ╟─93c3d676-aa0f-40b3-8c57-fd28ca5acf0c
# ╠═ea228836-2583-4b0e-9f7a-c2d50f9f8230
# ╠═1ee151db-1b91-4400-8474-9d689cb73664
# ╠═a9366254-3a82-4252-8c47-9b51b9dd504d
# ╟─602ecf93-2e61-44bc-ab45-06477fdff6f6
# ╠═e2bb2ed2-de48-4e53-b566-1e9b6f6c3aa1
# ╠═7bfc28ac-b41e-4c34-88dc-e74cd363922f
# ╠═3a205677-c028-4e3d-bd22-e8fd6afcfc4c
# ╠═1b862b47-7789-44d9-9005-ce7b77bec837
# ╠═8edb760b-e4ab-4354-8b2c-b53aa15d0a7f
# ╠═dcdb3dbc-5415-4c21-8431-da7bba9553ef
# ╠═956b9ccd-6d8c-4afc-b26c-3f477e8b07fe
# ╠═6b73e23d-f041-443f-9db6-8e08804542e4
# ╟─8ecd4de0-f81f-4aee-aed9-c85312138bc1
# ╠═450f2841-faae-486c-900d-3b830da5b2bd
# ╠═ceee3d88-7d76-482e-8eb0-6bb7bbb75b7a
# ╠═773d8b55-0e59-4272-aea1-a5b5eee4966a
# ╠═06f50446-19fe-4826-be42-d9507f2d552a
# ╟─c5992151-e61d-4672-939b-931090fc4275
# ╟─054cd582-16ec-4c27-8504-192a437e254e
# ╠═19d77c84-8b9b-4c0e-95ff-33667cc461b1
# ╠═b31bd8a2-ef27-4fc8-9790-3ddbdd540667
# ╠═f493c8c9-4399-475f-9d8a-9aa2b5aa38ea
# ╟─130a22a0-bbfd-4d69-bd99-194d71906f75
# ╠═f5a765fe-e03f-4bea-9d26-e4faf548cf8a
# ╠═85e2f791-7498-413c-8216-f9ef5c2abd44
# ╟─131bbb1f-25c1-4bd2-af72-4177ebda209e
# ╠═1f7ce44a-9720-404f-847c-c36601874396
# ╠═d7a64fd1-7c9d-43af-bd89-58492a633f12
# ╠═06ee405c-1a4d-46ea-a198-7ee15184c2a8
# ╠═bb4388e8-91f0-41f6-ae17-ae50c512c6e3
# ╟─c7615112-8c03-43fb-ad3a-e979f6ae951f
# ╠═262fecaf-08ed-48bb-88b3-7891fbb188bf
# ╠═84669c73-9668-43e4-9201-0b82ec95d9d2
# ╠═1340206a-e4b9-4445-8e12-e14d0d2e81a0
# ╠═f3c7318e-eeb0-4716-b7ab-aceab779e9d6
# ╠═e91a0596-8401-4e34-b1ab-17d6eae08801
# ╠═07720d55-52a0-409a-9f56-d0525e25f129
# ╠═927365af-503e-4005-951b-28c4fbbee92e
# ╠═ee509ed5-31b9-4657-858c-1dd6e6749c96
# ╠═f495ea83-a03a-45ec-9e0a-971388120632
# ╟─56837c07-91a6-452b-8c3a-854bbe6a8423
# ╟─804a253f-28c4-4eb7-8bc9-ac00c3d80f6d
# ╠═43279a01-aded-4f22-a5d4-97057e850dda
# ╠═3d033066-0bee-48e9-a4d0-be0e0afdfe68
# ╠═d5551946-391c-479c-bb26-0f3cbd0d46aa
# ╠═ed86ac5c-b2db-4ffe-862c-72e590b6ef65
# ╠═657cb8a0-892f-4e37-83da-8785b20f848e
# ╠═46aafc6d-96ec-4574-a294-8dc3fa9475fe
# ╟─525716f9-cb91-4bf3-92ff-1a5734aeb87b
# ╠═bfaec430-7fc3-4c0f-bf45-0eb87f60dbe3
# ╠═f2a779f5-d408-467b-9713-c58fe4db6913
# ╠═b4d1e9eb-1367-4dda-935c-8d24712dcd96
# ╠═b94fb940-4cfa-4496-aff6-bdd0014a1c5d
# ╠═19fa3b90-7cae-48dc-95e4-0fa63d4e0339
# ╠═977a9138-6530-4eaa-8b5f-df45c43864db
# ╠═f3f113a7-274c-4849-b163-ce2290db14b7
# ╠═29fa3f53-4193-465d-b44f-c72510d22725
# ╠═02aa90e1-3603-4248-a84e-02cff6efbd41
# ╠═c4492c39-1576-4058-937b-74ffb4a10d4a
# ╠═b7940f89-9e29-4411-b387-cddc2ac5dc98
# ╠═a97870e3-5b41-4b2d-bb7d-42ae62957873
# ╠═51c051a4-2376-40c8-a439-dacbde2b4dc4
# ╠═d07b04f7-a9d4-4573-816e-8f1bf565ff2a
# ╠═9db4540d-9498-49c4-95f0-bbbf593bd26a
# ╠═0ace7457-0f48-4cec-ae8d-ed3407cdd1e5
# ╠═b1ceefc6-53dd-464e-9441-45576f582efb
# ╟─0d153832-c688-4a2a-b7b9-3caceffbd9e3
# ╟─4f873aed-cd34-4309-b3dd-5574d3f41e49
# ╟─bebbb626-47fc-489b-9d62-0839fe196f84
# ╠═4c7c873c-21ec-4bf9-a265-fd57e8517cbd
# ╟─90bb33dc-0e55-480a-8b05-74951991a30b
# ╠═af0c54b1-ac51-4ab0-9a36-380668deb711
# ╟─f8fff2ef-3b91-4f56-8e80-838073dd1735
# ╠═6bc3d0dc-1a83-4016-a5aa-8f5622e11a81
# ╟─4f06457e-7100-4798-b47c-aa87e6be98da
# ╠═ba557a9d-8a5a-450b-ae24-48636edd5190
# ╟─468937c2-08e9-4d2f-9e5c-0427c52cab4f
# ╠═aaf1fddb-440f-4d64-8ee2-17e4463b78a5
# ╟─bd062bda-db6f-4511-b03d-1b156eedb09a
# ╠═87996ca9-84c8-46e9-ba71-89baafc2db28
# ╠═df45e72d-c361-49a7-8be0-dff4e69f5cba
# ╠═6c87b825-e4d4-4a58-8730-033798ad4dc7
# ╠═dd5aff36-30ff-41c7-8cad-838f92a86ea8
# ╟─f3392214-43c1-4086-bf3a-2dabd678a900
# ╟─03dd4154-4bf1-4059-9511-a78e030a2d9d
# ╠═94e37ee5-3158-446d-8422-db00d92910ba
# ╠═65f4abb9-e159-4188-9e37-def73f9fb160
# ╟─da5ddbad-2fb9-419d-9a09-1f3bb8fb6331
# ╠═06047667-04c2-4ebe-922c-632521cbd084
# ╠═34843a75-2a2c-4e2d-a8c9-ca2dea293914
# ╠═fb7dd33e-4d99-4997-81bf-3eb8f36a866f
# ╟─e1aa0ec9-bf27-4268-b60c-42847affc432
# ╠═c8c19b7b-ee0e-434a-874e-cb4485b7e80b
# ╠═9f7b140d-7f04-4988-9706-cf7141b9ee9b
# ╠═1320fd17-bb69-415a-8ced-a7d300a9b179
# ╟─38362da7-c423-4060-a5ca-4822294c8a49
# ╠═b430b97f-8ba6-4a0c-a663-4ff3f28d5698
# ╠═c7a7dfb4-f052-4fa5-ab3b-efc78319f0bd
# ╠═9b5fc090-e7d5-4783-8c69-e630f203ab04
# ╟─77d8dde4-8b75-49f0-9585-14961937b9e0
# ╠═efb06abb-c8cd-4778-89e7-44c5eaaf2986
# ╟─e47d1e7d-9671-4972-a98d-35cbdbbd29c7
# ╠═dd6f57bb-fea6-4538-b29c-2cafc5e3b9e5
# ╠═499bda9e-01f3-4db4-adbd-7f7f529fbfbe
# ╠═96b34aed-7c89-48f6-96c2-229c0d2f43bd
# ╟─d5a40063-9b03-46e2-8607-3081d524b17a
# ╠═2f6353b8-663a-4ce0-b98b-3433f9932eec
# ╟─68c176c8-0892-42ed-bed1-5d8f7a02b33d
# ╠═69ad7e44-b690-44d3-8b70-0dec997e4a26
# ╠═84cdc675-988f-4e73-aeaa-c948e27df9a7
# ╠═6777ff71-2096-494b-bb3d-fd95bdd3ec8b
# ╠═d013a895-5e83-4a39-9185-20ff9b3db4e6
# ╟─a3bf178d-d1f2-4ca8-90fc-56670c5208a6
# ╠═7a6b6044-6751-4041-99e7-0a608019110f
# ╠═e6477766-999b-485a-abf8-a5dcf99c7690
# ╠═08bdfd0b-be0b-44bc-ba71-adbe8c23f742
# ╟─6b04606d-b595-4baa-9a82-f85d3ace78b1
# ╠═5e0adaac-e483-4b9f-a365-6dd843fa1bd7
# ╠═b2b81a77-78e2-43a4-ba1a-0cc182035faf
# ╠═fb2c97b5-3eec-467a-ba90-0518ef5c8ba1
# ╟─7aae8e88-8d5b-4df1-94de-ace9635f6058
# ╟─f8ef8cf1-009e-4b0e-8295-8a914900ef0b
# ╠═250bcc9f-1f6d-4265-b1ad-3a2784b7cc8a
# ╠═0828af1f-f07e-4f39-b572-dd99fa8386ce
# ╟─c1692293-64d7-4686-b05b-acaf2c783757
# ╠═1051d718-8a92-4db7-80ca-6d128b442a63
# ╠═0f951595-bca4-40eb-b43c-1f8a89ddf560
# ╠═22ef4c14-bc21-44f2-be29-c57c9bad01c3
# ╠═da2d81cd-8247-4882-8d00-7d1d07130cb3
# ╠═1089ba05-c3e1-4328-90c3-f07c83696df7
# ╠═01e8598d-b761-4904-8871-764359fd7738
# ╠═5086fdfa-df90-486b-8679-633b9da22808
# ╠═1fc937a4-60ac-4d82-8d9f-94677071d552
# ╟─b7e645ca-a545-455e-b9ef-944da3ebf0b8
# ╠═1b592487-ad22-4f14-b374-87743b8ec134
# ╠═89b98a66-0378-47e6-8eb6-77f23406b96b
# ╠═575e5f9c-7a21-4250-9b2e-bbb42bd1ed4c
# ╠═a94203ea-b828-457a-a58e-3362a0307f2e
# ╟─94efad05-8481-4cd6-a9cb-829671c29c4d
# ╠═de2196da-70b9-4c45-9732-ad5b8e7e4a1e
# ╠═15df85fb-03e5-4f71-a9eb-ea227579c288
# ╠═8dddc5b9-1837-4d90-b99e-67eb047cf834
# ╠═e27244e4-3002-47c1-ac01-6065017a5c9d
# ╟─a49378fc-331a-47c4-9caa-0a18145fe994
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
