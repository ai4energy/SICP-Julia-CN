### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 7f7e11f0-78ac-11ed-1ded-d9cdbbfa0be4
md"
====================================================================================
#### SICP: 2.5.2.1 [*Cross-type* operations（不同类型数据的组合）](https://sarabander.github.io/sicp/html/2_002e5.xhtml#g_t2_002e5_002e2) 
====================================================================================
"

# ╔═╡ 3dfa205d-5fe6-45ae-a9c6-86503e124f4e
md"
#### 2.5.2.1.1 SICP-*Scheme*-like functions and operators
"

# ╔═╡ 484a99cf-172c-42c4-988e-5f74f6ab04fe
md"
---
#####  *Ground*-level SICP-*Scheme*-like functions and operators
"

# ╔═╡ d454be34-a245-495f-95f6-0d51976e95f0
struct Cons
	car
	cdr
end

# ╔═╡ f745c49d-bfaf-4297-9e73-18c41883ed24
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ 56b12f1e-fd45-4397-b165-270c3685954d
car(cell::Cons) = cell.car

# ╔═╡ 7c9121b6-4a9f-4c21-8358-53a64767fbdf
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ 617203be-67b3-416f-aa1b-2a9a80580c93
md"
---
##### Representation *in*dependent interface functions
"

# ╔═╡ 38da7d6f-3f10-4753-a1b1-7c4fe60bea8c
function attachTag(typeTag, contents) 
	cons(typeTag, contents) 
end # attachTag

# ╔═╡ bce9004d-2baa-4212-9b3e-48f38506478f
function typeTag(datum) 
	car(datum)
end # typeTag

# ╔═╡ 15070797-a05f-49ef-8d24-673b058af5f2
function contents(datum) 
	cdr(datum)
end # function contents

# ╔═╡ be9542a3-2e29-4ac9-987e-9a5b00f6aded
md"
---
##### Procedures for the manipulation of the operation $$\times$$ type tables

###### Table *constructors*
"


# ╔═╡ 91532479-9aa2-43f0-ad66-c51f27954bd9
Dict{Tuple, Function}                 # types of dictionary

# ╔═╡ 7340c4c1-c809-480e-b9c5-aa15c31a2fe0
# construction of empty table as a dictionary
myTableOfOpsAndTypes = Dict()

# ╔═╡ a5d9fd26-1ac1-4a36-98ae-abd146f415e5
function myPut!(op::Symbol, opTypes::Tuple, lambdaExpression::Function) 
	# Dict((op::Symbol, opType::Symbol) <= lambdaExpression::Function)
	myTableOfOpsAndTypes[op::Symbol, opTypes::Tuple] = lambdaExpression
end # function put

# ╔═╡ 87443477-dbcd-4b59-8412-5ed581b6026a
md"
---
###### Table *selectors*
"

# ╔═╡ 03edc31f-cff6-41be-bf4b-71cf3d26d997
function myGet(op::Symbol, opType::Tuple) # instead of SICP's get
	# Dict((op::Symbol, opType::Symbol) => item::Function)
	myTableOfOpsAndTypes[op::Symbol, opType::Tuple]
end # function myGet

# ╔═╡ a026c282-4a44-4bc3-a29c-09141221a54a
function getOpsOfType(table, argType)
	filter(pairOpOpType -> 
		let
			(op, opType) = pairOpOpType
			opType == argType ? true : false
		end, # let
		keys(table))
end # function getOpsOfType

# ╔═╡ 48c39822-85ea-4267-bd2a-915b7432dcfe
md"
---
##### Generic *arithmetic* procedures
"

# ╔═╡ f5cd8a99-ac8e-4162-b303-28de7e741acf
function applyGeneric(opSymbol, xs...) # SICP's '.args' is renamed to slurping 'xs'
	let
		typeTags = map(typeTag, xs)
		proc     = myGet(opSymbol, typeTags)  # splatting of typeTags
		content  = map(contents, xs)   
		proc(content...)               # application of proc to splatting of content
	end # let
end # function applyGeneric

# ╔═╡ cf01169a-b001-4e2c-801e-af17f67915ef
md"
---
##### Generic *arithmetic* selectors
"

# ╔═╡ e4e75eb5-1c64-4358-97ec-a933f633415e
begin
	numerator(x)   = applyGeneric(:numer, x)       # generic selector numerator
	denominator(x) = applyGeneric(:denom, x)       # generic selector denominator
	realPart(z)    = applyGeneric(:realPart, z)    # generic selector realPart
	imagPart(z)    = applyGeneric(:imagPart, z)    # generic selector imagPart
	magnitude(z)   = applyGeneric(:magnitude, z)   # generic selector norm
	angle(z)       = applyGeneric(:angle, z)       # generic selector angle
end

# ╔═╡ 06a083de-8dcf-43d5-8f80-b1da69ac8073
md"
---
##### Generic *arithmetic* operators
"

# ╔═╡ 40e72dd3-4a94-4ea4-8385-95591d852373
begin
	add(x, y)  = applyGeneric(:add, x, y)  # generic addition function
	sub(x, y)  = applyGeneric(:sub, x, y)  # generic subtraction function
	mul(x, y)  = applyGeneric(:mul, x, y)  # generic multiplication function
	div(x, y)  = applyGeneric(:div, x, y)  # generic division function
end # begin

# ╔═╡ aff35eb0-7b0e-4a7a-b20f-b5394896748a
md"
---
##### *Ordinary* (SICP-*Scheme*-like) number package
"

# ╔═╡ 47681241-1451-46f2-919b-8665a860b4b4
function installSICPNumberPackage()
	#======================================================================#
	# local procedures
	tag!(x) = attachTag(:sicpNumber, x)
	#----------------------------------------
	printSicpNumber(sicpNumber) = sicpNumber
	#======================================================================#
	# interface to rest of system
	myPut!(:print,(:sicpNumber,),                       printSicpNumber)
	#-----------------------------------------------------------------------
	myPut!(:make, (:sicpNumber,),                  x -> tag!(x))
	#-----------------------------------------------------------------------
	myPut!(:add,  (:sicpNumber, :sicpNumber), (x, y) -> tag!(x + y))
	myPut!(:sub,  (:sicpNumber, :sicpNumber), (x, y) -> tag!(x - y))
	myPut!(:mul,  (:sicpNumber, :sicpNumber), (x, y) -> tag!(x * y))
	myPut!(:div,  (:sicpNumber, :sicpNumber), (x, y) -> tag!(x / y))
	#-----------------------------------------------------------------------
	"package sicpNumber done" 
	#======================================================================#
end # function installJuliaNumberPackage

# ╔═╡ 780c1b8c-7006-4f58-86f6-6cf344e782da
installSICPNumberPackage()

# ╔═╡ abf37201-e26f-4cd3-bca9-ec8ac3474a4a
getOpsOfType(myTableOfOpsAndTypes, (:sicpNumber,))

# ╔═╡ 465967d5-75f4-4ac8-a7f1-86ece3aa8830
getOpsOfType(myTableOfOpsAndTypes, (:sicpNumber, :sicpNumber))

# ╔═╡ 61580cf8-331b-4129-a981-5732022a4c9b
md"
---
###### Constructor of ordinary (*Scheme*-like) numbers
"

# ╔═╡ 107c7b7d-9feb-40ae-bfd5-06dd48c30360
function makeSicpNumber(n) 
	myGet(:make, (:sicpNumber,))(n)
end # function makeSicpNumber

# ╔═╡ 14b9a7da-02db-4ef4-a9be-039fb75eced0
md"
---
##### *Complex* number package based on *rectangular* coordinates
"

# ╔═╡ efd90c9d-4bc9-49ca-92a6-500788c1c61b
function installRectangularPackage() # Ben's rectangular package
	#================================================================================#
	# internal procedures
	tag!(x) = attachTag(:rectangular, x)
	#----------------------------------------------------------
	makeZFromRealImag(x, y) = cons(x, y)
	makeZFromMagAng(r, a)   = cons(r * cos(a), r * sin(a))
	#----------------------------------------------------------
	realPartRect(z)  = car(z)
	imagPartRect(z)  = cdr(z)
	magnitudeRect(z) = √(realPartRect(z)^2 + imagPartRect(z)^2)
	angleRect(z)     = atan(imagPartRect(z), realPartRect(z))
	#----------------------------------------------------------
	addComplexRect(z1, z2) = 
		makeZFromRealImag(
			realPartRect(z1) + realPartRect(z2), 
			imagPartRect(z1) + imagPartRect(z2))
	#--------------------------------------------
	subComplexRect(z1, z2) = 
		makeZFromRealImag(
			realPartRect(z1) - realPartRect(z2), 
			imagPartRect(z1) - imagPartRect(z2))
	#--------------------------------------------
	mulComplexRect(z1, z2) = 
		let
			x1 = realPartRect(z1)
			x2 = realPartRect(z2)
			y1 = imagPartRect(z1)
			y2 = imagPartRect(z2)
			makeZFromRealImag(
				(x1 * x2 - y1 * y2), 
				(x1 * y2 + y1 * x2))
		end # let
	#--------------------------------------------
	divComplexRect(z1, z2) = 
		let
			x1 = realPartRect(z1)
			x2 = realPartRect(z2)
			y1 = imagPartRect(z1)
			y2 = imagPartRect(z2)
			denominator = (x2^2 + y2^2)
			makeZFromRealImag(
				(x1 * x2 + y1 * y2) / denominator, 
				(x2 * y1 - x1 * y2) / denominator)
		end # let
	#---------------------------------------------------------------------------------# NEW: cross-type operation	
	addComplexToSicpNumber(z, x) = 
		makeZFromRealImag(realPartRect(z) + x, imagPartRect(z) + 0)
	#================================================================================#
	# interface to rest of system
	myPut!(:makeZFromRealImag, (:rectangular,), 
		(x,y) -> tag!(makeZFromRealImag(x, y)))
	myPut!(:makeZFromMagAng,   (:rectangular,), 
		(r,a) -> tag!(makeZFromMagAng(r, a)))
	#---------------------------------------------------------------------------------
	myPut!(:realPart,  (:rectangular,),                  realPartRect)
	myPut!(:imagPart,  (:rectangular,),                  imagPartRect)
	myPut!(:magnitude, (:rectangular,),                  magnitudeRect)
	myPut!(:angle,     (:rectangular,),                  angleRect)
	#---------------------------------------------------------------------------------
	myPut!(:add, (:rectangular, :rectangular), (z1, z2)->tag!(addComplexRect(z1, z2)))
	myPut!(:sub, (:rectangular, :rectangular), (z1, z2)->tag!(subComplexRect(z1, z2)))
	myPut!(:mul, (:rectangular, :rectangular), (z1, z2)->tag!(mulComplexRect(z1, z2)))
	myPut!(:div, (:rectangular, :rectangular), (z1, z2)->tag!(divComplexRect(z1, z2)))
	#---------------------------------------------------------------------------------# NEW: cross-type operation	
	myPut!(:add, (:rectangular, :sicpNumber),  
		(z, x)->tag!(addComplexToSicpNumber(z, x)))
	#---------------------------------------------------------------------------------
	"Ben's rectangular package installed"
	#================================================================================#
end # function installRectangularPackage

# ╔═╡ f9d19043-b50a-49be-8afa-fbc6bf51045a
installRectangularPackage()

# ╔═╡ 1364620d-69f7-4953-8409-07c7a22ca9a0
getOpsOfType(myTableOfOpsAndTypes, (:rectangular,))

# ╔═╡ aed7bad9-42c6-4a12-86b6-1eedfb80f71e
getOpsOfType(myTableOfOpsAndTypes, (:rectangular, :rectangular))

# ╔═╡ e8cac3db-7deb-40e6-a540-865b03fc1d33
# NEW: cross-type operation	
getOpsOfType(myTableOfOpsAndTypes, (:rectangular, :sicpNumber))  

# ╔═╡ bc973e5b-405b-4677-8880-053109466c61
md"
---
##### *Constructor* for *rectangular* complex numbers *external* to Ben's package
"

# ╔═╡ 0c0748de-ef11-4537-91d3-a7216b751812
function makeZRectFromRealImag(x, y)                            # SICP, 1996, p.184
	myGet(:makeZFromRealImag, (:rectangular,))(x, y)
end # function makeZRectFromRealImag

# ╔═╡ 0ab451c8-fa20-471c-9042-ac2f28d98a5a
md"
---
##### *Test* constructions with *rectangular* packagage
"

# ╔═╡ 0cb813cb-89ff-41c7-b76a-b75ac16d3fc6
let
	z = makeZRectFromRealImag(2, 1)
    x = makeSicpNumber(3)
	add(z, x)         # NRW: cross-type operation
end # let

# ╔═╡ 79f8e0c3-6237-4e0a-8eea-7fb24ae77148
md"
---
#### 2.5.2.1.2 *idiographic* Julia functions and operators
"

# ╔═╡ 82c5475a-88ba-44ac-88de-1847922cea3f
let
	z = Complex(2, 1)
	x = 3
	z + x             # NEW: cross-type operation
end # let

# ╔═╡ 42d19c5a-69b4-41f1-9eba-b04cb2a2f78f
let
	z = Complex(2, 1)
	x = 3.0
	z + x             # NEW: cross-type operation
end # let

# ╔═╡ b3f14dc2-c6fc-4587-b4ba-b469e47e03ee
md"
---
##### end of ch. 2.5.2.1
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
# ╟─7f7e11f0-78ac-11ed-1ded-d9cdbbfa0be4
# ╟─3dfa205d-5fe6-45ae-a9c6-86503e124f4e
# ╟─484a99cf-172c-42c4-988e-5f74f6ab04fe
# ╠═d454be34-a245-495f-95f6-0d51976e95f0
# ╠═f745c49d-bfaf-4297-9e73-18c41883ed24
# ╠═56b12f1e-fd45-4397-b165-270c3685954d
# ╠═7c9121b6-4a9f-4c21-8358-53a64767fbdf
# ╟─617203be-67b3-416f-aa1b-2a9a80580c93
# ╠═38da7d6f-3f10-4753-a1b1-7c4fe60bea8c
# ╠═bce9004d-2baa-4212-9b3e-48f38506478f
# ╠═15070797-a05f-49ef-8d24-673b058af5f2
# ╟─be9542a3-2e29-4ac9-987e-9a5b00f6aded
# ╠═91532479-9aa2-43f0-ad66-c51f27954bd9
# ╠═7340c4c1-c809-480e-b9c5-aa15c31a2fe0
# ╠═a5d9fd26-1ac1-4a36-98ae-abd146f415e5
# ╟─87443477-dbcd-4b59-8412-5ed581b6026a
# ╠═03edc31f-cff6-41be-bf4b-71cf3d26d997
# ╠═a026c282-4a44-4bc3-a29c-09141221a54a
# ╟─48c39822-85ea-4267-bd2a-915b7432dcfe
# ╠═f5cd8a99-ac8e-4162-b303-28de7e741acf
# ╟─cf01169a-b001-4e2c-801e-af17f67915ef
# ╠═e4e75eb5-1c64-4358-97ec-a933f633415e
# ╟─06a083de-8dcf-43d5-8f80-b1da69ac8073
# ╠═40e72dd3-4a94-4ea4-8385-95591d852373
# ╟─aff35eb0-7b0e-4a7a-b20f-b5394896748a
# ╠═47681241-1451-46f2-919b-8665a860b4b4
# ╠═780c1b8c-7006-4f58-86f6-6cf344e782da
# ╠═abf37201-e26f-4cd3-bca9-ec8ac3474a4a
# ╠═465967d5-75f4-4ac8-a7f1-86ece3aa8830
# ╟─61580cf8-331b-4129-a981-5732022a4c9b
# ╠═107c7b7d-9feb-40ae-bfd5-06dd48c30360
# ╟─14b9a7da-02db-4ef4-a9be-039fb75eced0
# ╠═efd90c9d-4bc9-49ca-92a6-500788c1c61b
# ╠═f9d19043-b50a-49be-8afa-fbc6bf51045a
# ╠═1364620d-69f7-4953-8409-07c7a22ca9a0
# ╠═aed7bad9-42c6-4a12-86b6-1eedfb80f71e
# ╠═e8cac3db-7deb-40e6-a540-865b03fc1d33
# ╟─bc973e5b-405b-4677-8880-053109466c61
# ╠═0c0748de-ef11-4537-91d3-a7216b751812
# ╟─0ab451c8-fa20-471c-9042-ac2f28d98a5a
# ╠═0cb813cb-89ff-41c7-b76a-b75ac16d3fc6
# ╟─79f8e0c3-6237-4e0a-8eea-7fb24ae77148
# ╠═82c5475a-88ba-44ac-88de-1847922cea3f
# ╠═42d19c5a-69b4-41f1-9eba-b04cb2a2f78f
# ╟─b3f14dc2-c6fc-4587-b4ba-b469e47e03ee
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
