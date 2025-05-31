### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 26fa8766-db69-4811-8b35-78502aafac58
using Polynomials

# ╔═╡ 3fb529d0-82cc-11ed-0932-cb8309929ff0
md"
====================================================================================
#### SICP: [2.5.3\_Symbolic\_Algebra（符号代数）](https://sarabander.github.io/sicp/html/2_002e5.xhtml#g_t2_002e5_002e3)
====================================================================================

"

# ╔═╡ 08c69705-9f6d-4abf-bbbb-62bedd0890a7
md"
##### 2.5.3.1 Scheme-like Julia
"

# ╔═╡ 5a5084f1-20c4-418a-ad66-0b9f53021dc3
md"
##### Ground-level SICP-*Scheme*-like functions and operators
"

# ╔═╡ 5df86668-9303-4cae-af89-f3afd6a3bfa9
md"
###### Constructors
"

# ╔═╡ 147a66b9-d63b-4cd9-8aad-48bc4e5c6b04
struct Cons
	car
	cdr
end

# ╔═╡ 50b02df2-812c-44ca-b40d-fa04434d6808
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ 11a6536e-9eb6-40ce-b11e-4ff44e85087d
function cons(car::Any, list2::Vector)::Vector
	conslist = list2
	pushfirst!(conslist, car)
	conslist
end

# ╔═╡ 4fd33d88-6d3b-47bd-b0ca-50af62d83659
function cons(list1::Vector, list2::Vector)::Vector
	conslist = push!([], list1)
	for xi in list2
		push!(conslist, xi)
	end # for
	conslist
end # function cons

# ╔═╡ 82440572-4b9d-4173-a23c-4037101d5277
list(xs...)::Vector{Any} = push!([], xs...)::Vector{Any}

# ╔═╡ 52cdf3db-3bda-4fff-9eb1-be7b50bd4ac1
list(:a, :b, :c)

# ╔═╡ 30c6c031-ff97-4f2c-8151-83842a18cbba
md"
###### Selectors
"

# ╔═╡ 4dc3c0eb-1963-4b49-b930-3c3e96cd6c6e
car(cell::Cons) = cell.car

# ╔═╡ c8ff2dbb-096a-45f1-87c3-4a3174678965
car(x::Tuple) = x[1]                                 # new 

# ╔═╡ 0ffa49f1-800e-4ef3-952c-5a6ccd072484
car(x::Vector) = x[1]                                # new 

# ╔═╡ a50dae37-c2ce-440d-964b-9e55a4399c0e
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ dc2fd68a-913c-4469-b4aa-ce9ff2606b36
cdr(x::Tuple) = x[2:end]                             # new 

# ╔═╡ 8c0c5da0-4195-4e1b-8ee9-fa948d8bb6c2
cdr(x::Vector) = x[2:end]                            # new 

# ╔═╡ 9d8161f2-bae1-448f-91d4-470592e359e2
md"
---
###### Representation *in*dependent interface functions
"

# ╔═╡ 508a0120-04c9-4563-b861-173efc1fd191
function attachTag(typeTag, contents) 
	cons(typeTag, contents) 
end # attachTag

# ╔═╡ 2975e070-0932-413b-b425-01ea1a66f229
function typeTag(datum) 
	car(datum)
end # typeTag

# ╔═╡ 405518c2-253f-49af-860b-ff6838dc96b1
function contents(datum) 
	cdr(datum)
end # function contents

# ╔═╡ b13914e3-1f73-4a41-afda-a8257f0120d3
md"
---
##### Operators on $$termList$$s
"

# ╔═╡ 2460eb0d-463f-44a9-9a91-e937523850e8
md"
###### Constructor
"

# ╔═╡ 929ad3e6-964a-431b-b7d1-8f4262c6c80c
makeEmptyTermList() = ()

# ╔═╡ c48aa10b-0d8d-4899-be13-9206c0c26d56
makeEmptyTermList()

# ╔═╡ 74331cb0-c1fa-41ab-97c0-6a2776a13bed
makeTerm(xs...) = 
	if length(xs) == 2
		let order = xs[1]
			coeff = xs[2]
			(order, coeff)
		end # let
	else nothing
	end # if

# ╔═╡ 295b761e-944c-4f2f-a089-f6bf1f1480e3
isZero(x) = x == 0 || x == nothing

# ╔═╡ 21b62ccf-f646-4b3d-a946-44e62345cf30
md"
---
###### Selectors
"

# ╔═╡ 6341fed1-d054-482e-9d0d-7438a28fe7fe
firstTerm(termList::Cons) = car(termList)

# ╔═╡ 5c69be91-132b-4e7b-9a36-acfdedad6056
firstTerm(termList::Tuple) = termList[1]         # new

# ╔═╡ e3b0ca86-b46b-457a-a106-bfad819b7452
firstTerm(termList::Vector) = termList[1]        # new

# ╔═╡ da942182-06bd-4620-a74e-8d5d8fa6ee72
restTerms(termList::Cons) = cdr(termList)

# ╔═╡ ff6a02bf-08ff-41f5-9072-00b69a965144
restTerms(termList::Tuple) = termList[2:end]     # new

# ╔═╡ ad7e01ab-3d75-441a-8a16-3a524f603198
restTerms(termList::Vector) = termList[2:end]    # new

# ╔═╡ fc01c695-74e1-4308-83b4-630961bb6912
restTerms((:a, :b))

# ╔═╡ db5da889-9569-4f20-a9f4-ace742112482
restTerms((:a,))

# ╔═╡ 26a310c2-b1bc-4312-a73b-43012713f4ce
restTerms(())

# ╔═╡ c05fa9ea-2c24-4f94-8281-1b18b3288f18
let termList = (:a, :b, :c, :d)
 	vect = [restTerms(termList[i:end]) for i in 1:length(termList)]
	len  = length(vect)
	ntuple(i -> vect[i], len)
end # let

# ╔═╡ 31680334-95cb-4afe-8a08-0816a0ef20d3
getOrder(term) = term[1]

# ╔═╡ b8f80bcb-bcf0-4347-8943-07bcabba7f65
getCoeff(term) = term[2]

# ╔═╡ 822ec725-1e11-48d1-b110-d4daa00763a1
function adjoinTerm(term, termList)
	isempty(term) ? 
		termList :
		getCoeff(term) == 0 ?
			termList :
			cons(term, termList)
end # function adjoinTerm

# ╔═╡ 293b307a-ec93-436c-91d2-9e5efea9406d
adjoinTerm((2, 3), ())

# ╔═╡ 80ad8c2f-a1bb-4e75-866c-66c459e138aa
md"
##### Arithmetic on polynomials
"

# ╔═╡ ae3336cf-3cd5-4eea-9302-1fc2b637a2f6
md"
###### Examples:

- polynomial in $$x$$: 
$$5x^2 + 3x + 7$$

- polynomial in $$x$$ whose coefficients are polynomials in $$y$$: 
$$(y^2+1)x^3 + (2y)x + 1$$
"

# ╔═╡ 896b6fc9-8d60-4c77-a92a-33bc42d65459
md"
---
##### Procedures for the manipulation of the *operation* $$\times$$ *type* tables

###### Table *constructors*
"

# ╔═╡ 8081866f-d276-4867-983a-06f60559bcf1
Dict{Tuple, Function}                 # types of dictionary

# ╔═╡ ae0beca5-6986-484b-b78a-3fdcdf820d83
# construction of empty table as a dictionary
myTableOfOpsAndTypes = Dict()

# ╔═╡ d8f8e2cb-460f-42f4-b3d1-61bf6dfd5094
function myPut!(op::Symbol, opTypes::Tuple, lambdaExpression::Function) 
	# Dict((op::Symbol, opType::Symbol) <= lambdaExpression::Function)
	myTableOfOpsAndTypes[op::Symbol, opTypes::Tuple] = lambdaExpression
end # function put

# ╔═╡ eab4fb03-dbf9-4ac5-af5e-e83a22d2943d
md"
---
###### Table *selectors*
"

# ╔═╡ 4e079041-a919-45a8-9671-b5606a6b6f8e
function myGet(op::Symbol, opType::Tuple) # instead of SICP's get
	# Dict((op::Symbol, opType::Symbol) => item::Function)
	myTableOfOpsAndTypes[op::Symbol, opType::Tuple]
end # function myGet

# ╔═╡ f0ed5713-33ab-40ca-a95a-fc37cf229165
function applyGeneric(opSymbol, xs...) # SICP's '.args' is renamed to slurping 'xs'
	let
		typeTags = map(typeTag, xs)
		proc     = myGet(opSymbol, typeTags)  # splatting of typeTags
		content  = map(contents, xs)   
		proc(content...)               # application of proc to splatting of content
	end # let
end # function applyGeneric

# ╔═╡ 367ab6ed-d31b-4aab-9437-a59bbe0562d9
md"
---
###### Generic *polynomial* operators
"

# ╔═╡ 28e4894c-9590-4f18-9571-ec2433811864
begin
	add(p, q)  = applyGeneric(:add, p, q)  # generic addition function
	mul(p, q)  = applyGeneric(:mul, p, q)  # generic multiplication function
end # begin

# ╔═╡ d86c4c19-70fb-4de8-87cc-58e72dea2f8a
md"
---
##### polynomial package
"

# ╔═╡ a5475607-61d0-4f61-bba2-127bd0835c3f
function installPolynomialPackage()
	#=============================================================================#
	# local procedures
	tag!(p)                   = attachTag(:polynomial, p)
	#------------------------------------------------------------------------------
	makePoly(var, termList)   = cons(var, termList)
	#------------------------------------------------------------------------------
	getVariable(p)            = car(p)
	isVariable(x)             = typeof(x) == Symbol
	isSameVariable(v1, v2)    = isVariable(v1) && isVariable(v1) && v1 == v2
	#------------------------------------------------------------------------------
	getTermList(p)            = cdr(p)
	isEmpty(termList)         = termList == ()
	#------------------------------------------------------------------------------
	function addTerms(termList1, termList2) 
		if isEmpty(termList1) 
			termList2 
		elseif isEmpty(termList2) 
			termList1 
		else
			let term1 = firstTerm(termList1)
				term2 = firstTerm(termList2)
				if getOrder(term1) > getOrder(term2)
					adjoinTerm(term1, addTerms(restTerms(termList1), termList2))
				elseif getOrder(term1) < getOrder(term2)
					adjoinTerm(term2, addTerms(termList1, restTerms(termList2)))
				else
					adjoinTerm(
						makeTerm(
							getOrder(term1), 
							+(getCoeff(term1), getCoeff(term2))),
						addTerms(restTerms(termList1), restTerms(termList2)))
				end # if
			end # let
		end # if
	end # function addTerms
	#-----------------------------------------------------------------------------
	function mulTerms(termList1, termList2)
		isEmpty(termList1) ?
			makeEmptyTermList() :
			addTerms(mulTermByAllTerms(firstTerm(termList1), termList2),
				mulTerms(restTerms(termList1), termList2))
	end # function mulTerms
	#------------------------------------------------------------------------------
	mulTermByAllTerms(term1, termList) = 
		isEmpty(termList) ?
			makeEmptyTermList() : 
			let term2 = firstTerm(termList)
				 adjoinTerm(
					makeTerm(
							+(getOrder(term1), getOrder(term2)),
							*(getCoeff(term1), getCoeff(term2))),
					mulTermByAllTerms(term1, restTerms(termList)))
			end # let
	#============================================================================#
	# pp flattens a Scheme-like nested cons-list to a linear vector
	function pp(consList)                             # from SICP ch 2.2.1
		#-------------------------------------------------------------
		function pp_iter(ppArray, consList)
			if consList == cons(:nil, :nil) || consList == ()
				ppArray
			elseif (car(consList) !== :nil) && (cdr(consList) == :nil)
				push!(ppArray, car(consList))
			else
				pp_iter(push!(ppArray, car(consList)), cdr(consList))
			end # if
		end # pp_iter
		#-------------------------------------------------------------
		(pp_iter([], consList))
	end # function pp
	#============================================================================#
	addPoly(p1, p2) = 
		let var1 = getVariable(p1)
			var2 = getVariable(p2)
			isSameVariable(var1, var2) ?
				let nestedAddTermsList = addTerms(getTermList(p1), getTermList(p2))
					flattenedAddTermVector = pp(nestedAddTermsList)
					nTerms = length(flattenedAddTermVector)
					makePoly(
						var1, 
						ntuple(i -> flattenedAddTermVector[i], nTerms))
				end : # let 
				error("Polys not in same var -- addPoly's var1=:$var1, var2=:$var2")
		end # let
	#------------------------------------------------------------------------------
	mulPoly(p1, p2) =
		let var1 = getVariable(p1)
			var2 = getVariable(p2)
			isSameVariable(var1, var2) ?
				let 
					nestedMulTermsList = mulTerms(getTermList(p1), getTermList(p2))
					flattenedMulTermVector = pp(nestedMulTermsList)
					nTerms = length(flattenedMulTermVector)
					makePoly(
						var1,
						ntuple(i -> flattenedMulTermVector[i], nTerms))
				end : # let
				error("Polys not in same var -- mulPoly's var1=:$var1, var2=:$var2")
		end # let
	#============================================================================#
	# interface to rest of system
	#------------------------------------------------------------------------------
	myPut!(:make, (:polynomial,), (var, termList) -> tag!(makePoly(var, termList)))
	#------------------------------------------------------------------------------
	myPut!(:add,  (:polynomial, :polynomial), (p1, p2) -> tag!(addPoly(p1, p2)))
	myPut!(:mul,  (:polynomial, :polynomial), (p1, p2) -> tag!(mulPoly(p1, p2)))
	#------------------------------------------------------------------------------
	"installPolynomialPackage done"
	#=============================================================================#
end # function installPolynomialPackage

# ╔═╡ 1eb091d6-6970-4356-8302-2a6927a6b832
installPolynomialPackage()

# ╔═╡ aa2a43c4-3ae9-49ce-a092-848ec49d1ab2
myTableOfOpsAndTypes

# ╔═╡ ed1f0f97-e0ce-4bfd-8098-1929f931f4f1
md"
---
##### Representing term lists
"

# ╔═╡ c5f018a8-afea-469c-9379-87af655260d7
md"
---
###### *Density* of polynomials
###### *dense* polynomial
$$x^5 + 2x^4 + 3x^2 - 2x -5$$
representable as:

$$(1, 2, 0, 3, -2, -5)$$

but represented here as (..., (order, coefficient),...):

$$((5, 1), (4, 2), (2, 3), (1, 2), (0, -5))$$

###### *sparse* polynomial:
$$x^{100} + 2x^2 + 1$$
represented as

$$((100, 1), (2, 2), (0, 1))$$

---

"

# ╔═╡ 3989b5d8-b308-4791-b968-e55e3a29c1d0
myGet(:make, (:polynomial,))(:x, ((2, 3), (1, 2), (0, 1)))

# ╔═╡ f1c306ea-6622-4cf5-a6af-fbaf0b11c602
myGet(:make, (:polynomial,))(:x, (cons(2, 3), cons(1, 2), cons(0, 1)))

# ╔═╡ 486a098b-b024-45e3-9bcf-bdd86a27acdb
function makePolynomial(var, termList)
	myGet(:make, (:polynomial,))(var, termList)
end # function makePolynomial

# ╔═╡ 06c02a29-1021-4b13-9a1c-abf927e08f02
md"
---
##### Polynomial calculations
"

# ╔═╡ c3a82ec4-399a-4355-91e4-6d1615320089
md"
$$poly1 = 3x^2 + 2x + 1$$
$$termList1 = ((2, 3), (1, 2), (0, 1))$$
"

# ╔═╡ b9c8fe91-68c8-409d-9ffb-a92e3abdc03a
(:x, ((2, 3), (1, 2), (0, 1)))

# ╔═╡ 859e27a6-e399-48c6-941f-f8aedb5fb412
typeof((:x, ((2, 3), (1, 2), (0, 1))))

# ╔═╡ 7338d70d-1589-4f15-83cb-2eb60fe16713
poly1 = makePolynomial(:x, ((2, 3), (1, 2), (0, 1)))

# ╔═╡ 09a3d165-c6bb-4ea9-9b53-89fc6c4fd6fc
md"
$$poly2 = 6x^2 + 4x + 2$$
$$termList2 = ((2, 6), (1, 4), (0, 2))$$
"

# ╔═╡ d83d15ad-459d-4e75-9e66-3c9a7d0ecf50
poly2 = makePolynomial(:x, ((2, 6), (1, 4), (0, 2)))

# ╔═╡ b0216bc4-ecb4-4831-9481-c5e77421e1c0
poly1

# ╔═╡ 7c4e1860-de68-483e-b9a4-1f95d858f824
poly2

# ╔═╡ 978797fe-662f-4e6e-916f-334040ac5688
cdr(poly1)

# ╔═╡ 6fcce3de-b63a-4a31-93f4-c2763973f29d
car(cdr(poly1))

# ╔═╡ 040f1f78-c5d4-4f8c-ae74-d9d75e73c81a
cdr(cdr(poly1))

# ╔═╡ 640fb6ab-ce0b-4349-9b59-6304bd1693cc
car(cdr(cdr(poly1)))

# ╔═╡ 4d7c9c29-49ec-4e26-9c39-afa740740986
car(car(cdr(cdr(poly1))))

# ╔═╡ f7fcef9d-f562-4246-9e37-5bf4433b0cff
cdr(car(cdr(cdr(poly1))))

# ╔═╡ c3b820dd-54c3-4271-a9e9-e848d477bfb0
md"
---
$$add(poly1, poly2) = ((2, 9), (1, 6), (0, 3)) = 3 + 6x + 9x^2$$
"

# ╔═╡ 668e571d-b0f7-4d74-b1aa-a85cf0ffbd64
add(poly1, poly2)

# ╔═╡ 1a5177fe-b229-471c-bb2b-d38099b3b33c
md"
---
###### *sparse* polynomials:
$$x^{100} + 2x^2 + 1$$
represented as

$$poly3 = Cons(:polynomial, Cons(:x, ((100, 1), (2, 2), (0, 1))))$$

$$termList3 = ((100, 1), (2, 2), (0, 1))$$
"

# ╔═╡ 28ece29b-a4c1-42e9-b8d1-df9da9ede5bd
poly3 = makePolynomial(:x, ((100, 1), (2, 2), (0, 1)))

# ╔═╡ 509fbca4-4a38-4289-93d6-4b8283df69eb
poly1

# ╔═╡ dce482f6-e04c-41dd-be6c-3249aef4dbc0
md"
$$add(poly1, poly3) = ((100, 1), (2, 5), (1, 2), (0, 2)) = 2 + 2x + 5x^2 + x^{100}$$
"

# ╔═╡ 3d3a1fd3-96b4-4cfe-bff9-4807874710d0
add(poly1, poly3)

# ╔═╡ febd216d-0d1d-4e96-9b0a-1dfb780e5d3d
poly2

# ╔═╡ 3913b58f-4fcb-496c-bd6c-33e0f2f32122
md"
$$add(poly2, poly3) = ((100,1),(2,8),(1,4),(0,3)) = 3 + 4x + 8x^2 + x^{100}$$
"

# ╔═╡ 1e9105cd-d244-47e4-8a7b-e08f6fce7465
add(poly2, poly3)

# ╔═╡ ca702d61-e3a4-41df-adbc-c7e0f12e43a1
md"
$$poly4 = 1 + 2y^2 + y^{100}$$
"

# ╔═╡ 13995526-8136-449c-ab60-8d88130d1c54
poly4 = makePolynomial(:y, ((100, 1), (2, 2), (0, 1)))

# ╔═╡ cd0f3689-38e5-4d0e-a892-228cd936096b
add(poly3, poly4)

# ╔═╡ 3a530306-ac42-4bb8-8702-b11589f9fea4
md"
---
$$poly5 = ((1, 2), (0, 1)) = 2x + 1$$
"

# ╔═╡ e720b845-7f3e-4b23-9e38-ec5089fac575
poly5 = makePolynomial(:x, ((1, 2), (0, 1)))

# ╔═╡ 910e1c41-5bea-4107-bf0f-ba9eac7727cf
md"
$$poly6 = ((1, 4), (0, 2)) = 4x + 2$$
"

# ╔═╡ 727f5258-e560-4b8f-ba54-11d174af83f1
poly6 = makePolynomial(:x, ((1, 4), (0, 2)))

# ╔═╡ 19a7531e-fdec-4aac-9c82-5a84d9aaf1f1
md"
$$mul(poly5, poly6) = (1,2)*poly6 + (0, 1)*poly6$$ 
$$= ((2,8),(1,4)) + ((1,4),(0,2))$$
$$= ((2,8), (1,8),(0,2))= 2 + 8x +8x^2$$
"

# ╔═╡ 426dc65a-3ca1-41c3-b1bb-391644da3616
mul(poly5, poly6)

# ╔═╡ 433a6f15-4181-42c7-b868-78f8b698bf15
poly1

# ╔═╡ f16a01e3-d94e-4163-a38c-f66246d3238e
poly2

# ╔═╡ 5f23f7f1-acec-42da-bff5-4130f7dc2fee
md"
---
$$mul(poly1, poly2) = (2,3)*poly2 + (1,2)*poly2 + (0,1)*poly2$$
$$=((4, 18),(3,12),(2,6))+((3,12),(2,8),(1,4))+((2,6),(1,4),(0,2))$$
$$=((4,18),(3,24)),(2,20),(1,8),(0,2))$$
$$=2 +8x + 20x^2 + 24x^3 + 18x^4$$
"

# ╔═╡ 07bf91ba-f1e0-4881-9d00-692f0d56269e
mul(poly1, poly2)

# ╔═╡ b55fbdd4-2e1c-416a-9862-9ede871e1d4c
md"
---
##### 2.5.3.2 Idiomatic Julia using [Polynomials.jl](https://juliamath.github.io/Polynomials.jl/stable/)
"

# ╔═╡ afd79221-36f1-456a-81de-efdf26315d07
poly1R = Polynomial([1, 2, 3])                         # poly1 in reverse order

# ╔═╡ 5c88adb9-512b-4d39-b954-ddb33c52b5e6
poly2R = Polynomial([2, 4, 6])                         # poly2 in reverse order

# ╔═╡ 85d58eef-628b-4b02-b316-2beed007c665
ninetySevenZeros = [0 for i in 1:97]

# ╔═╡ 9bc6eb52-c9d1-4327-a88e-e5a3539382f5
# poly3 in :x in reverse order
poly3R = Polynomial([1, 0, 2, ninetySevenZeros..., 1])    

# ╔═╡ 07d7e3c6-adc4-4e21-bdfa-cb70fbeadfc1
# poly4 in :y in reverse order
poly4R = Polynomial([1, 0, 2, ninetySevenZeros..., 1], :y) 

# ╔═╡ 87ccaaf8-e1d7-43be-882d-65fd85cac002
poly5R = Polynomial([1, 2])                            # poly5 in reverse order

# ╔═╡ 2f0d9a6e-6b1b-47e2-bfa2-9a4896f0fd87
poly6R = Polynomial([2, 4])                            # poly6 in reverse order

# ╔═╡ 7911df10-28bd-43f7-9814-32d458a29115
md"
$$poly2R2nd = 2 + 4x + 6x^2$$
$$poly3R2nd = 1 + 2x^2 + x^{100}$$
"

# ╔═╡ 0793a2c3-2e67-4ad2-9811-03f434d50fcb
SP = SparsePolynomial

# ╔═╡ b097c862-b3ae-4004-adfd-a1417c052c93
poly2R2nd = 2 + 4*Polynomials.basis(SP, 1) + 6*Polynomials.basis(SP, 2)

# ╔═╡ aaca51c9-3178-4d7a-8de8-d51e1dd924c2
poly3R2nd = 1 + 2*Polynomials.basis(SP, 2) + Polynomials.basis(SP, 100)

# ╔═╡ 977edc3e-4ecb-4fe0-92c9-6dddcfc0c098
md"
---
###### Addition
"

# ╔═╡ bde86ebe-f115-4d90-a78c-68cb32db992a
poly1R + poly2R

# ╔═╡ 2a838b3f-f2b3-42a6-be69-4094526e6fca
poly1R + poly3R

# ╔═╡ ee57922d-dfe0-43aa-9e81-f803852c407d
poly2R + poly3R

# ╔═╡ 68fa2c1a-0c43-439a-9646-403f6b896ac2
poly3R + poly4R            # poly3R is in :x; poly4R is in :y

# ╔═╡ b5870398-75e7-4cec-860b-60b365778ad5
poly2R2nd + poly3R2nd

# ╔═╡ 9877d577-a0a8-4f61-8700-129e3bdd216c
md"
---
###### Multiplication
"

# ╔═╡ ba052304-82bd-4430-b485-635aed726749
poly5R * poly6R

# ╔═╡ 2a6bd43c-45d4-47d2-9851-ab2115c76750
poly1R * poly2R

# ╔═╡ a78d07f9-83c8-4892-a595-22d1d09b1de1
poly1R * poly3R

# ╔═╡ 84b14f41-6310-4cfe-8d02-eb0bd9916446
poly2R * poly3R

# ╔═╡ 14dac475-d492-47ca-a290-d5832df04106
poly2R2nd * poly3R2nd

# ╔═╡ a1ec9800-2b42-473f-ab58-0b73bfe5527b
md"
---
##### References
- Polynomials.jl, [https://juliamath.github.io/Polynomials.jl/stable/](https://juliamath.github.io/Polynomials.jl/stable/); visited 2023/01/08
- SparsePolynomial, [https://juliamath.github.io/Polynomials.jl/stable/polynomials/polynomial/#Polynomials.SparsePolynomial](https://juliamath.github.io/Polynomials.jl/stable/polynomials/polynomial/#Polynomials.SparsePolynomial); visited 2023/01/08
---
"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Polynomials = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"

[compat]
Polynomials = "~3.2.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "3d23504a314ffb4bc636dd4e149d92ca9e4759aa"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "6ea39b2399c92b83036ef26d8bab9cd017b9a8c4"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.1"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "18c35ed630d7229c5584b945641a73ca83fb5213"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.2"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─3fb529d0-82cc-11ed-0932-cb8309929ff0
# ╟─08c69705-9f6d-4abf-bbbb-62bedd0890a7
# ╟─5a5084f1-20c4-418a-ad66-0b9f53021dc3
# ╟─5df86668-9303-4cae-af89-f3afd6a3bfa9
# ╠═147a66b9-d63b-4cd9-8aad-48bc4e5c6b04
# ╠═50b02df2-812c-44ca-b40d-fa04434d6808
# ╠═11a6536e-9eb6-40ce-b11e-4ff44e85087d
# ╠═4fd33d88-6d3b-47bd-b0ca-50af62d83659
# ╠═82440572-4b9d-4173-a23c-4037101d5277
# ╠═52cdf3db-3bda-4fff-9eb1-be7b50bd4ac1
# ╟─30c6c031-ff97-4f2c-8151-83842a18cbba
# ╠═4dc3c0eb-1963-4b49-b930-3c3e96cd6c6e
# ╠═c8ff2dbb-096a-45f1-87c3-4a3174678965
# ╠═0ffa49f1-800e-4ef3-952c-5a6ccd072484
# ╠═a50dae37-c2ce-440d-964b-9e55a4399c0e
# ╠═dc2fd68a-913c-4469-b4aa-ce9ff2606b36
# ╠═8c0c5da0-4195-4e1b-8ee9-fa948d8bb6c2
# ╟─9d8161f2-bae1-448f-91d4-470592e359e2
# ╠═508a0120-04c9-4563-b861-173efc1fd191
# ╠═2975e070-0932-413b-b425-01ea1a66f229
# ╠═405518c2-253f-49af-860b-ff6838dc96b1
# ╟─b13914e3-1f73-4a41-afda-a8257f0120d3
# ╟─2460eb0d-463f-44a9-9a91-e937523850e8
# ╠═929ad3e6-964a-431b-b7d1-8f4262c6c80c
# ╠═c48aa10b-0d8d-4899-be13-9206c0c26d56
# ╠═74331cb0-c1fa-41ab-97c0-6a2776a13bed
# ╠═295b761e-944c-4f2f-a089-f6bf1f1480e3
# ╠═822ec725-1e11-48d1-b110-d4daa00763a1
# ╠═293b307a-ec93-436c-91d2-9e5efea9406d
# ╟─21b62ccf-f646-4b3d-a946-44e62345cf30
# ╠═6341fed1-d054-482e-9d0d-7438a28fe7fe
# ╠═5c69be91-132b-4e7b-9a36-acfdedad6056
# ╠═e3b0ca86-b46b-457a-a106-bfad819b7452
# ╠═da942182-06bd-4620-a74e-8d5d8fa6ee72
# ╠═ff6a02bf-08ff-41f5-9072-00b69a965144
# ╠═ad7e01ab-3d75-441a-8a16-3a524f603198
# ╠═fc01c695-74e1-4308-83b4-630961bb6912
# ╠═db5da889-9569-4f20-a9f4-ace742112482
# ╠═26a310c2-b1bc-4312-a73b-43012713f4ce
# ╠═c05fa9ea-2c24-4f94-8281-1b18b3288f18
# ╠═31680334-95cb-4afe-8a08-0816a0ef20d3
# ╠═b8f80bcb-bcf0-4347-8943-07bcabba7f65
# ╟─80ad8c2f-a1bb-4e75-866c-66c459e138aa
# ╟─ae3336cf-3cd5-4eea-9302-1fc2b637a2f6
# ╟─896b6fc9-8d60-4c77-a92a-33bc42d65459
# ╠═8081866f-d276-4867-983a-06f60559bcf1
# ╠═ae0beca5-6986-484b-b78a-3fdcdf820d83
# ╠═d8f8e2cb-460f-42f4-b3d1-61bf6dfd5094
# ╟─eab4fb03-dbf9-4ac5-af5e-e83a22d2943d
# ╠═4e079041-a919-45a8-9671-b5606a6b6f8e
# ╠═f0ed5713-33ab-40ca-a95a-fc37cf229165
# ╟─367ab6ed-d31b-4aab-9437-a59bbe0562d9
# ╠═28e4894c-9590-4f18-9571-ec2433811864
# ╟─d86c4c19-70fb-4de8-87cc-58e72dea2f8a
# ╠═a5475607-61d0-4f61-bba2-127bd0835c3f
# ╠═1eb091d6-6970-4356-8302-2a6927a6b832
# ╠═aa2a43c4-3ae9-49ce-a092-848ec49d1ab2
# ╟─ed1f0f97-e0ce-4bfd-8098-1929f931f4f1
# ╟─c5f018a8-afea-469c-9379-87af655260d7
# ╠═3989b5d8-b308-4791-b968-e55e3a29c1d0
# ╠═f1c306ea-6622-4cf5-a6af-fbaf0b11c602
# ╠═486a098b-b024-45e3-9bcf-bdd86a27acdb
# ╟─06c02a29-1021-4b13-9a1c-abf927e08f02
# ╟─c3a82ec4-399a-4355-91e4-6d1615320089
# ╠═b9c8fe91-68c8-409d-9ffb-a92e3abdc03a
# ╠═859e27a6-e399-48c6-941f-f8aedb5fb412
# ╠═7338d70d-1589-4f15-83cb-2eb60fe16713
# ╟─09a3d165-c6bb-4ea9-9b53-89fc6c4fd6fc
# ╠═d83d15ad-459d-4e75-9e66-3c9a7d0ecf50
# ╠═b0216bc4-ecb4-4831-9481-c5e77421e1c0
# ╠═7c4e1860-de68-483e-b9a4-1f95d858f824
# ╠═978797fe-662f-4e6e-916f-334040ac5688
# ╠═6fcce3de-b63a-4a31-93f4-c2763973f29d
# ╠═040f1f78-c5d4-4f8c-ae74-d9d75e73c81a
# ╠═640fb6ab-ce0b-4349-9b59-6304bd1693cc
# ╠═4d7c9c29-49ec-4e26-9c39-afa740740986
# ╠═f7fcef9d-f562-4246-9e37-5bf4433b0cff
# ╟─c3b820dd-54c3-4271-a9e9-e848d477bfb0
# ╠═668e571d-b0f7-4d74-b1aa-a85cf0ffbd64
# ╟─1a5177fe-b229-471c-bb2b-d38099b3b33c
# ╠═28ece29b-a4c1-42e9-b8d1-df9da9ede5bd
# ╠═509fbca4-4a38-4289-93d6-4b8283df69eb
# ╟─dce482f6-e04c-41dd-be6c-3249aef4dbc0
# ╠═3d3a1fd3-96b4-4cfe-bff9-4807874710d0
# ╠═febd216d-0d1d-4e96-9b0a-1dfb780e5d3d
# ╟─3913b58f-4fcb-496c-bd6c-33e0f2f32122
# ╠═1e9105cd-d244-47e4-8a7b-e08f6fce7465
# ╟─ca702d61-e3a4-41df-adbc-c7e0f12e43a1
# ╠═13995526-8136-449c-ab60-8d88130d1c54
# ╠═cd0f3689-38e5-4d0e-a892-228cd936096b
# ╟─3a530306-ac42-4bb8-8702-b11589f9fea4
# ╠═e720b845-7f3e-4b23-9e38-ec5089fac575
# ╟─910e1c41-5bea-4107-bf0f-ba9eac7727cf
# ╠═727f5258-e560-4b8f-ba54-11d174af83f1
# ╟─19a7531e-fdec-4aac-9c82-5a84d9aaf1f1
# ╠═426dc65a-3ca1-41c3-b1bb-391644da3616
# ╠═433a6f15-4181-42c7-b868-78f8b698bf15
# ╠═f16a01e3-d94e-4163-a38c-f66246d3238e
# ╟─5f23f7f1-acec-42da-bff5-4130f7dc2fee
# ╠═07bf91ba-f1e0-4881-9d00-692f0d56269e
# ╟─b55fbdd4-2e1c-416a-9862-9ede871e1d4c
# ╠═26fa8766-db69-4811-8b35-78502aafac58
# ╠═afd79221-36f1-456a-81de-efdf26315d07
# ╠═5c88adb9-512b-4d39-b954-ddb33c52b5e6
# ╠═85d58eef-628b-4b02-b316-2beed007c665
# ╠═9bc6eb52-c9d1-4327-a88e-e5a3539382f5
# ╠═07d7e3c6-adc4-4e21-bdfa-cb70fbeadfc1
# ╠═87ccaaf8-e1d7-43be-882d-65fd85cac002
# ╠═2f0d9a6e-6b1b-47e2-bfa2-9a4896f0fd87
# ╟─7911df10-28bd-43f7-9814-32d458a29115
# ╠═0793a2c3-2e67-4ad2-9811-03f434d50fcb
# ╠═b097c862-b3ae-4004-adfd-a1417c052c93
# ╠═aaca51c9-3178-4d7a-8de8-d51e1dd924c2
# ╟─977edc3e-4ecb-4fe0-92c9-6dddcfc0c098
# ╠═bde86ebe-f115-4d90-a78c-68cb32db992a
# ╠═2a838b3f-f2b3-42a6-be69-4094526e6fca
# ╠═ee57922d-dfe0-43aa-9e81-f803852c407d
# ╠═68fa2c1a-0c43-439a-9646-403f6b896ac2
# ╠═b5870398-75e7-4cec-860b-60b365778ad5
# ╟─9877d577-a0a8-4f61-8700-129e3bdd216c
# ╠═ba052304-82bd-4430-b485-635aed726749
# ╠═2a6bd43c-45d4-47d2-9851-ab2115c76750
# ╠═a78d07f9-83c8-4892-a595-22d1d09b1de1
# ╠═84b14f41-6310-4cfe-8d02-eb0bd9916446
# ╠═14dac475-d492-47ca-a290-d5832df04106
# ╟─a1ec9800-2b42-473f-ab58-0b73bfe5527b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
