### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ f135f3a0-56a9-11ed-061c-7b66fe82a635
md"
=====================================================================================
#### SICP: 2.4.3 [Data-directed Programming and Additivity（数据导向的程序设计的可加性）](https://sarabander.github.io/sicp/html/2_002e4.xhtml#g_t2_002e4_002e3)

=====================================================================================
"

# ╔═╡ c3bba84d-f891-46b9-be00-3db34c3743fa
md"$$
\begin{array}{|c|c|}
\hline
            &                                                 \\
layer       & \text{Operations or Functions}                  \\
            &                                                 \\
\hline
            &                                                 \\
top         & \text{Representation-independent operations}    \\
(domain)    & \begin{array}{c} 
            & \hline                                          \\
            & addComplex                                      \\ 
            & subComplex                                      \\
            & mulComplex                                      \\
            & divComplex                                      \\ 
            &                                                 \\
            & \text{Representation-independent selectors }    \\
            & \hline                                          \\
            & realPart                                        \\
            & imagPart                                        \\
            & magnitude                                       \\          
            & angle                                           \\
            &                                                 \\ 
            & \text{Representation-independent constructors}  \\
            & \hline                                          \\
            & makeZFromRealImag                               \\
            & makeZFromMagAng                                 \\
            & \end{array}                                     \\
            & \hline                                          \\
            & \begin{array}{c}  
            & \text{Representation-independent interface}     \\
            & \hline                                          \\
            & attachTag                                       \\
            & typeTag                                         \\
            & contents                                        \\
            & \end{array}                                     \\ 
            & \text{Representation-dependent operations}      \\
            & \begin{array}{cc} 
            & \hline                                          \\
            & addComplexRectangular & addComplexPolar         \\
            & subComplexRectangular & subComplexPolar         \\
            & mulComplexRectangular & mulComplexPolar         \\
            & divComplexRectangular & divComplexPolar         \\
            & \end{array}                                     \\
middle      & \text{Representation-dependent constructors}    \\
(interface) & \begin{array}{cc} 
            & \text{Rectangular} & \text{Polar}               \\
            & \hline                                          \\
            & installRectangularPackage & installPolarPackage \\
            & makeZRectFromRealImag & makeZPolarFromRealImag  \\ 
            & makeZRectFromMagAng   & makeZPolarFromMagAng    \\
            & \end{array}                                     \\
            & \text{Representation-dependent}                 \\
            & \text{selectors and predicates}                 \\
            & \begin{array}{cc} 
            & \text{Rectangular}    & \text{Polar}            \\
            & \hline                &                         \\
            & realPartRectangular   & realPartPolar           \\ 
            & imagPartRectangular   & imagPartPolar           \\
            & magnitudeRectangular  & magnitudePolar          \\
            & angleRectangular      & anglePolar              \\
            &                                                 \\
            & \hline                                          \\
            & isRectangular         & isPolar                 \\
            & \end{array}                                     \\
\hline
            &                                                 \\
ground      & cons                                            \\
(Scheme)    & car                                             \\
            & cdr                                             \\
            & list                                            \\
            &                                                 \\
\hline
            &                                                 \\
basement    & Dict                                            \\
(Julia)     & myPut!                                          \\
            & myGet                                           \\
            & getOpsOfType                                    \\
            &                                                 \\
\hline
\end{array}$$

**Fig. 2.4.3.1** Data *abstraction barriers* in the complex number system (cf. SICP, 1996, Fig. 2.21 or [here](https://sarabander.github.io/sicp/html/2_002e4.xhtml#g_t2_002e4_002e3))

---
"

# ╔═╡ 45672303-1883-4d3b-b0fe-3e912d3cac46
md"
---
##### 2.4.3.1 *Ground*-level *SICP-Scheme*-like functions and operators
"

# ╔═╡ 43270f51-e79f-4ee4-8705-fad9b44778d4
struct Cons
	car
	cdr
end

# ╔═╡ 61b610a5-401b-4652-a9e9-cd46263c099b
car(cell::Cons) = cell.car

# ╔═╡ 4b3dcc1b-0469-4cb4-bc0f-1f1e6a370d6d
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ d45f0975-744e-4ff4-bf6a-e5a377713bae
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ 9c1e16cc-8650-41b8-828c-c4340cb03243
md"
---
##### Representation *in*dependent interface functions
"

# ╔═╡ 9c97c826-f317-4a24-bb0b-8ae8b552af6d
function attachTag(typeTag, contents) 
	cons(typeTag, contents) 
end # attachTag

# ╔═╡ 4ac58d4a-3820-46e8-b1e7-12ead084f116
function typeTag(datum) 
	car(datum)
end # typeTag

# ╔═╡ f83ba6f2-5410-4e24-b0d9-3aeec7bdd3c1
function contents(datum) 
	cdr(datum)
end # function contents

# ╔═╡ 149bb3bb-1e5b-4010-94f6-bea49b17f714
md"
$$\begin{array}{|l|c|cc|}
\hline
                                                               \\
& \text{args of } & \;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\text{(Dispatching on) Types}                                \\
              & myGet       & (:rectangular,) & (:polar,)      \\ 
\hline                                                                        
              &             &                 &                \\
              & realPart    & realPartRect    & realPartPolar  \\
\text{Opera-} & imagPart    & imagPartRect    & imagPartPolar  \\
\text{tions}  & magnitude   & magnitudeRect   & magnitudePolar \\
              & angle       & angleRect       & anglePolar     \\
              &             &                 &                \\
\hline
                                                               \\
& \text{args of } & \;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;\text{(Dispatching on) Types}                                                              \\                
        & myGet & (:rectangular, :rectangular) & (:polar, :polar) \\ 
\hline
              &             &                       &                 \\
              & addComplex  & addComplexRect & addComplexPolar \\
\text{Opera-} & subComplex  & subComplexRect & subComplexPolar \\
\text{tions}  & mulComplex  & mulComplexRect & mulComplexPolar \\
              & divComplex  & divComplexRect & divComplexPolar \\
              &             &                       &                 \\
\hline

\end{array}$$

**Fig. 2.4.3.2** *Table* of operations for the complex-number system (cf. SICP, 1996, Fig. 2.22 or [here](https://sarabander.github.io/sicp/html/2_002e4.xhtml#g_t2_002 e4_002e3)): '...each operation takes care of its own dispatching on types...'(SICP, 1996, p186)
"

# ╔═╡ bb9f139c-d8ba-4de3-9ba0-00d1e952ae35
md"
---
##### *Procedures* for the manipulation of the *operation*$$\times$$*type* tables
"

# ╔═╡ ead06a15-8374-444f-9e48-394eedd20656
md"
###### Table *constructors*
"

# ╔═╡ 42eeefe4-0d8c-4bf2-b19a-eef3a9258e79
Dict{Tuple, Function}                 # types of dictionary

# ╔═╡ 2e0f0c63-173c-40a1-8668-42a996c5d733
# construction of empty table as a dictionary
myTableOfOpsAndTypes = Dict()

# ╔═╡ 3806c36d-95a9-498b-bcba-664b2d765088
myTableOfOpsAndTypes

# ╔═╡ 324dc393-5326-4b61-8545-086aaa465955
typeof(myTableOfOpsAndTypes)

# ╔═╡ 77085bea-8fa6-4eab-a36c-78420ba6bbc2
function myPut!(op::Symbol, opTypes::Tuple, item::Function) 
	# Dict((op::Symbol, opType::Symbol) => item::Function)
	myTableOfOpsAndTypes[op::Symbol, opTypes::Tuple] = item
end # function put

# ╔═╡ 4b0e56fd-1a03-4ed8-b691-fd106929e923
md"
---
###### Table *selectors*
"

# ╔═╡ 106dba00-6a16-4f5d-bb84-7a31509eb62c
get  # SICP's get cannot be used here, because it's already in use in other contexts

# ╔═╡ 92d64081-2d5d-419a-947e-1e1cc6b3b9fb
function myGet(op::Symbol, opType::Tuple) # instead of SICP's get
	# Dict((op::Symbol, opType::Symbol) => item::Function)
	myTableOfOpsAndTypes[op::Symbol, opType::Tuple]
end # function myGet

# ╔═╡ f2257d43-94b3-4b2c-8c11-05b88cddf386
function getOpsOfType(table, argType)
	filter(pairOpOpType -> 
		let
			(op, opType) = pairOpOpType
			opType == argType ? true : false
		end, # let
		keys(table))
end # function getOpsOfType

# ╔═╡ 3d71261a-930f-4a17-9d56-16e0ce8674bb
md"
---
##### *Generic* arithmetic procedures
"

# ╔═╡ 02ad8e0c-581d-46fe-876b-400f6daa4865
function applyGeneric(opSymbol, zs...) # SICP's '.args' is renamed to slurping 'zs'
	let
		typeTags = map(typeTag, zs)
		proc     = myGet(opSymbol, typeTags)  # splatting of typeTags
		content  = map(contents, zs)   
		proc(content...)               # application of proc to splatting of content
	end # let
end # function applyGeneric

# ╔═╡ 8982c3e8-778b-4fcb-a8a8-a7c935901961
md"
---
###### Generic arithmetic *selectors*
"

# ╔═╡ 9fdd8679-bd67-4d2e-810a-5560af87edcf
begin
	realPart(z)  = applyGeneric(:realPart, z)
	imagPart(z)  = applyGeneric(:imagPart, z)
	magnitude(z) = applyGeneric(:magnitude, z)
	angle(z)     = applyGeneric(:angle, z)
end 

# ╔═╡ efb4c70f-7dbb-4ef6-90b3-5a60cb19b23e
md"
---
###### Generic arithmetic *operators*
"

# ╔═╡ fe895b18-a1c0-4a7c-8c38-37d65f031450
begin
	addComplex(z1, z2) = applyGeneric(:addComplex, z1, z2)
	subComplex(z1, z2) = applyGeneric(:subComplex, z1, z2)
	mulComplex(z1, z2) = applyGeneric(:mulComplex, z1, z2)
	divComplex(z1, z2) = applyGeneric(:divComplex, z1, z2)
end

# ╔═╡ 5b087edd-fb98-4247-acb1-c565d3d7a630
md"
---
##### *Complex* number package based on *rectangular* coordinates
"

# ╔═╡ b5b3673e-a06f-48a8-a2be-25006e5fb4a2
function installRectangularPackage() # Ben's rectangular package
	#===============================================================#
	# internal procedures
	tag!(x) = attachTag(:rectangular, x)
	#----------------------------------------------------------------
	makeZFromRealImag(x, y) = cons(x, y)
	makeZFromMagAng(r, a)   = cons(r * cos(a), r * sin(a))
	#----------------------------------------------------------------
	realPartRect(z)  = car(z)
	imagPartRect(z)  = cdr(z)
	magnitudeRect(z) = √(realPartRect(z)^2 + imagPartRect(z)^2)
	angleRect(z)     = atan(imagPartRect(z), realPartRect(z))
	#----------------------------------------------------------------
	addComplexRect(z1, z2) = 
		tag!(makeZFromRealImag(
			realPartRect(z1) + realPartRect(z2), 
			imagPartRect(z1) + imagPartRect(z2)))
	#--------------------------------------------
	subComplexRect(z1, z2) = 
		tag!(makeZFromRealImag(
			realPartRect(z1) - realPartRect(z2), 
			imagPartRect(z1) - imagPartRect(z2)))
	#--------------------------------------------
	mulComplexRect(z1, z2) = 
		let
			x1 = realPartRect(z1)
			x2 = realPartRect(z2)
			y1 = imagPartRect(z1)
			y2 = imagPartRect(z2)
			tag!(makeZFromRealImag(
					(x1 * x2 - y1 * y2), 
					(x1 * y2 + y1 * x2)))
		end # let
	#--------------------------------------------
	divComplexRect(z1, z2) = 
		let
			x1 = realPartRect(z1)
			x2 = realPartRect(z2)
			y1 = imagPartRect(z1)
			y2 = imagPartRect(z2)
			denom = (x2^2 + y2^2)
			tag!(makeZFromRealImag(
					(x1 * x2 + y1 * y2) / denom, 
					(x2 * y1 - x1 * y2) / denom))
		end # let
	#===============================================================#
	# interface to rest of system
	myPut!(:makeZFromRealImag, (:rectangular,), 
		(x, y) -> tag!(makeZFromRealImag(x, y)))
	myPut!(:makeZFromMagAng,   (:rectangular,), 
		(r, a) -> tag!(makeZFromMagAng(r, a)))
	#----------------------------------------------------------------
	myPut!(:realPart,  (:rectangular,), realPartRect)
	myPut!(:imagPart,  (:rectangular,), imagPartRect)
	myPut!(:magnitude, (:rectangular,), magnitudeRect)
	myPut!(:angle,     (:rectangular,), angleRect)
	#----------------------------------------------------------------
	myPut!(:addComplex, (:rectangular,:rectangular), 
		(z1, z2) -> tag!(addComplexRect(z1, z2)))
	myPut!(:subComplex, (:rectangular, :rectangular), 
		(z1, z2) -> tag!(subComplexRect(z1, z2)))
	myPut!(:mulComplex, (:rectangular, :rectangular), 
		(z1, z2) -> tag!(mulComplexRect(z1, z2)))
	myPut!(:divComplex, (:rectangular, :rectangular), 
		(z1, z2) -> tag!(divComplexRect(z1, z2)))
	#----------------------------------------------------------------
	"Ben's rectangular package installed"
	#===============================================================#
end # function installRectangularPackage

# ╔═╡ ebe7b24a-beec-406b-acf8-71b414f29893
md"
---
###### Install Ben's *rectangular* package with $$installRectangularPackage()$$
"

# ╔═╡ 0873f8fa-5f2c-49ae-bab6-eabdf1d7ff2c
installRectangularPackage()

# ╔═╡ 55697ad8-f53c-4fe7-a696-8c80aa8a4164
myTableOfOpsAndTypes                          # correct content of table dictionary ?

# ╔═╡ 48aa5558-1446-40ec-8c4d-f5202577d721
keys(myTableOfOpsAndTypes)

# ╔═╡ cb95d31c-9b8c-48a5-a20e-b77fef8c83ed
getOpsOfType(myTableOfOpsAndTypes, (:rectangular,))

# ╔═╡ 55f4e841-ca98-4c32-ac78-a402567bd958
getOpsOfType(myTableOfOpsAndTypes, (:rectangular, :rectangular))

# ╔═╡ d6e79de7-b43a-4870-b932-6571e0b60b04
myTableOfOpsAndTypes[:realPart, (:rectangular,)] # retrieval of method realPartOfZ

# ╔═╡ eac6bb08-e92e-4784-a37d-6748564086a6
myGet(:realPart, (:rectangular,))

# ╔═╡ 31742b8a-ebcf-460e-871b-59b97c2759ff
# test construction of complex number
myGet(:makeZFromRealImag, (:rectangular,))(2, 1) 

# ╔═╡ 8dff3423-4621-47d2-be08-871e40f9602f
# test construction of complex number
myGet(:makeZFromMagAng, (:rectangular,))(2, 1)  

# ╔═╡ 4fc25aeb-5347-4dff-9821-ae7660849ca4
md"
---
###### *Constructor* for rectangular complex numbers (*external* to Ben's package)
"

# ╔═╡ 2161e479-a6da-4677-9f7b-021107a6d003
function makeZRectFromRealImag(x, y)                            # SICP, 1996, p.184
	myGet(:makeZFromRealImag, (:rectangular,))(x, y)
end # function makeZRectFromRealImag

# ╔═╡ 23e23f28-51c4-4169-ba0a-9a3ec2a71759
function makeZRectFromMagAng(r, a)
	myGet(:makeZFromMagAng, (:rectangular,))(r, a)
end # function makeZRectFromMagAng

# ╔═╡ 85b10bef-d897-4dbe-8648-c0e76ce5b676
md"
###### Test [*constructions*](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) with *rectangular* packagage
"

# ╔═╡ 71c6e66e-4887-4cc0-b3d7-565b9f6fe33c
z1 = makeZRectFromRealImag(2, 1)      # ==> 2.0, 1.0i

# ╔═╡ 2fca10b7-ffa3-4530-8bd3-e6e4d9cccc09
# 2.24 ∠ 0.46 = 2.24(cos 0.46 + j sin 0.46) ==> 2.01 + 0.99i
z2 = makeZRectFromMagAng(2.24, 0.46) # 2.24 ∠ 0.46 radians 

# ╔═╡ 485745d0-5224-4788-920e-fab135c45652
md"
---
##### *Test* computations of complex numbers in *rectangular* form
"

# ╔═╡ 149ab1b6-9c21-40aa-bb85-cdd834f3f8ba
z1

# ╔═╡ 1d581b15-1712-4dcb-a681-b748e08b7e4c
typeTag(z1)

# ╔═╡ b7bbc511-2034-4536-947f-f211bae04133
contents(z1)

# ╔═╡ 3afbaf52-f5bd-4b92-b486-d05be9c15743
applyGeneric(:realPart, z1) 

# ╔═╡ e4588d6a-82e5-4a4b-a86e-1d3bd3863bfa
applyGeneric(:imagPart, z1) 

# ╔═╡ 5562b3a3-875c-40a8-98b1-a4d809a38163
applyGeneric(:magnitude, z1) 

# ╔═╡ 845ed715-5547-4fba-ab4c-05ac18e595a2
applyGeneric(:angle, z1) 

# ╔═╡ 11e55d16-98fb-44ca-85e1-fd11d8cd3c6c
realPart

# ╔═╡ d505818f-da2b-4265-ba6c-049bf5d4ba9e
realPart(z1)        

# ╔═╡ 18fd40a7-60e2-4890-9f37-84709cd92a7e
imagPart(z1)   

# ╔═╡ 6b89f377-4468-4740-b9d3-01fc6de13047
makeZRectFromRealImag(realPart(z1), imagPart(z1))

# ╔═╡ afd3c274-7c96-4884-93e5-4c7a021140aa
makeZRectFromMagAng(magnitude(z1), angle(z1))

# ╔═╡ e768b7e4-46b6-4ed1-8dbb-ee5052312939
md"
---
###### *Addition* of complex numbers in *rectangular* coordinates in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates
"

# ╔═╡ 22be72ec-7090-45fe-963f-011f75c7e337
let
	z1 = makeZRectFromRealImag(2, 1)
	r1 = magnitude(z1)                  # √(2^2 + 1^2) = √5 ==> 2.236
	z2 = makeZRectFromRealImag(realPart(z1)/r1, -2*imagPart(z1)/r1)
	# (2 + 1i) + (2/2.36 - 2*1i/2.236) = (2 + 1i) + (0.894 - 0.894i) 
	#  ==> (2.894 + 0.106i)
	z3 = addComplex(z1, z2)
end # let

# ╔═╡ e8d6a66f-414a-4e70-8705-4f4445bc48c8
md"
---
###### *Subtraction* of complex numbers in *rectangular* coordinates in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates
"

# ╔═╡ 99f58556-0d5e-423b-9b04-8cbac3167876
let
	z1 = makeZRectFromRealImag(2, 1)
	r1 = magnitude(z1)
	z2 = makeZRectFromRealImag(realPart(z1)/r1, -2*imagPart(z1)/r1)
	# (2 + 1i) - (2/√5 - 2/√5i) = (2 + 1i) - (.89  -.89i) ==> (1.105 + 1.894)
	z3 = subComplex(z1, z2)
end # let

# ╔═╡ f1ad9656-1105-4c60-abfd-982c5d0802fe
md"
---
###### *Multiplication* in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates
"

# ╔═╡ 63e2c323-1cad-4bf6-8ad3-2c6681b76cb5
let
	z1 = makeZRectFromRealImag(2,  1)
	z2 = makeZRectFromRealImag(2,  1)
	# (2 + 1i)(2 + 1i) = (2^2 + 2*1i + 1i*2 + 1^2*i^2) = (4 + 4i -1) ==> (3 + 4i)
	z3 = mulComplex(z1, z2)
end # let

# ╔═╡ 9b1e91c5-ab05-4e25-80c7-c3f690fdeb50
md"
---
###### *Division* in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates
The formula can be found [here](https://www.cuemath.com/numbers/division-of-complex-numbers/).

$$\frac{z_1}{z_2} = \frac{z_1}{z_2} \times \frac{\overline{z_2}}{\overline{z_2}} = \frac{z_1 \overline{z_2}}{|z_2|^2}$$

or more explicit:
 
$$\frac{x_1 + y_1i}{x_2 + y_2i} = \frac{x_1 + y_1i}{x_2 + y_2i} \times \frac{x_2 - y_2i}{x_2 - y_2i}=\frac{(x_1 + y_1i)(x_2 - y_2i)}{(x_2 + y_2i)(x_2 - y_2i)}$$

$$=\frac{(x_1 x_2 + y_1 y_2) + (x_2 y_1 - x_1 y_2)i}{x_2^2 + y_2^2} = \frac{(x_1 x_2 + y_1 y_2)}{{x_2^2 + y_2^2}} + \frac{(x_2 y_1 - x_1 y_2)i}{{x_2^2 + y_2^2}}.$$

Example:

$$\frac{3-1i}{1+2i}=\frac{3-1i}{1+2i}\times\frac{1-2i}{1-2i}=\frac{(3-1i)(1-2i)}{(1+2i)(1-2i)}$$

$$= \frac{(3\cdot1-1\cdot2)+(1\cdot-1-3\cdot2)i}{1^2+2^2}$$
$$=\frac{1-7i}{5}=\frac{1}{5}-\frac{7}{5}i=0.2-1.4i.$$
"

# ╔═╡ 3a46c792-3b37-4cfc-a371-a5e9a0f068cb
let
	z1 = makeZRectFromRealImag(3, -1)
	z2 = makeZRectFromRealImag(1,  2)
	z3 = divComplex(z1, z2)   # (3 - 1i)/(1 + 2i) ==> (0.2 - 1.4i)
end # let

# ╔═╡ b2ef9612-c06a-436d-9e1a-4ad69e5338be
md"
---
##### *Complex* number package based on *polar* coordinates
"

# ╔═╡ d20e564f-f6e8-4b7e-b93a-43e6a4725212
function installPolarPackage() # Alyssa's polar package
	#==============================================================================#
	# internal procedures
	#-------------------------------------------------------------------------------
	tag!(x) = attachTag(:polar, x)
	#---------------------------------------------------------------------
	makeZFromMagAng(r, a)   = cons(r, a)
	makeZFromRealImag(x, y) = cons(√(x^2 + y^2), atan(y, x))
	#---------------------------------------------------------------------
	realPartPolar(z)   = magnitudePolar(z) * cos(anglePolar(z))
	imagPartPolar(z)   = magnitudePolar(z) * sin(anglePolar(z))
	magnitudePolar(z)  = car(z)
	anglePolar(z)      = cdr(z)
	#---------------------------------------------------------------------
	addComplexPolar(z1, z2) = 
		let z3 = makeZFromRealImag(
			realPartPolar(z1) + realPartPolar(z2), 
			imagPartPolar(z1) + imagPartPolar(z2))
			tag!(makeZFromMagAng(
				magnitudePolar(z3), 
				anglePolar(z3)))
		end # let
	#--------------------------------------------
	subComplexPolar(z1, z2) = 
		let z3 = makeZFromRealImag(
			realPartPolar(z1) - realPartPolar(z2), 
			imagPartPolar(z1) - imagPartPolar(z2))
			tag!(makeZFromMagAng(
				magnitudePolar(z3), 
				anglePolar(z3)))
		end # let
	#--------------------------------------------
	mulComplexPolar(z1, z2) =
		tag!(makeZFromMagAng(
			magnitudePolar(z1) * magnitudePolar(z2),
			anglePolar(z1) + anglePolar(z2)))
	#--------------------------------------------
	divComplexPolar(z1, z2) =
		tag!(makeZFromMagAng(
			magnitudePolar(z1) / magnitudePolar(z2),
			anglePolar(z1) - anglePolar(z2)))
	#==============================================================================#
	# interface to rest of system
	#-------------------------------------------------------------------------------
	myPut!(:makeZFromRealImag, (:polar,),
		(x, y) -> tag!(makeZFromRealImag(x, y)))
	myPut!(:makeZFromMagAng,   (:polar,),
		(r, a) -> tag!(makeZFromMagAng(r, a)))	
	#-------------------------------------------------------------------------------
	myPut!(:realPart,          (:polar,),     realPartPolar)
	myPut!(:imagPart,          (:polar,),     imagPartPolar)
	myPut!(:magnitude,         (:polar,),     magnitudePolar)
	myPut!(:angle,             (:polar,),     anglePolar)
	#-------------------------------------------------------------------------------
	myPut!(:addComplex, (:polar, :polar), (z1, z2) -> tag!(addComplexPolar(z1, z2)))
	myPut!(:subComplex, (:polar, :polar), (z1, z2) -> tag!(subComplexPolar(z1, z2)))
	myPut!(:mulComplex, (:polar, :polar), (z1, z2) -> tag!(mulComplexPolar(z1, z2)))
	myPut!(:divComplex, (:polar, :polar), (z1, z2) -> tag!(divComplexPolar(z1, z2)))
	#-------------------------------------------------------------------------------
	"Alyssa's polar package installed"
	#==============================================================================#
end # function installPolarPackage

# ╔═╡ 2bbdecd4-f786-480e-93cd-c5e5cac398f6
installPolarPackage()

# ╔═╡ 06365e9b-9ad4-4891-9f7a-6a23f4f7b100
# get all ops (rows) for type (column) '(:polar,)'
getOpsOfType(myTableOfOpsAndTypes, (:polar,)) 

# ╔═╡ d6d3b4f0-3ddf-4f9e-a027-5fce5df444f9


# ╔═╡ 8027339b-87a4-4d7a-a291-71d6df76f780
# get all ops (rows) for type (column) '(:polar, :polar)'
getOpsOfType(myTableOfOpsAndTypes, (:polar, :polar)) 

# ╔═╡ 4c1deedb-da8e-401f-bda5-df9b67dd1145
md"
###### *Constructor* for polar complex numbers *external* to Alyssa's package
"

# ╔═╡ 04dd57cc-fd45-4c7c-827e-2cd2012cf839
function makeZPolarFromRealImag(x, y)                            # SICP, 1996, p.184
	myGet(:makeZFromRealImag, (:polar,))(x, y)
end # function makeZPolarFromRealImag

# ╔═╡ e5dce11a-b925-4b8e-b30d-d8a59222a0d2
function makeZPolarFromMagAng(r, a)                            # SICP, 1996, p.184
	myGet(:makeZFromMagAng, (:polar,))(r, a)
end # function makeZPolarFromMagAng

# ╔═╡ b487d7d2-0f42-429f-bc9c-25d03444b1a7
md"
###### Test [*constructions*](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) with *polar* packagage
"

# ╔═╡ 0bad2a95-2bb5-4a41-8b31-b2065e2a0a62
z3 = makeZPolarFromRealImag(2, 1)           # ==>   2.24 ∠ 0.46

# ╔═╡ 9b758276-b59a-413d-8769-f0dc3d47c646
z4 = makeZPolarFromMagAng(2.24, 0.46)       # ==>   2.24 ∠ 0.46

# ╔═╡ 15715a76-6549-4012-83e2-689a69d250e3
md"
---
##### Test calculations of complex numbers in *polar* form
"

# ╔═╡ 039dd612-772f-429c-bb55-bda320c1d0a7
makeZPolarFromMagAng(3, 40) # test construction of complex number in polar coordinates

# ╔═╡ 28f5eb24-4bbd-415c-a3a8-2a8df9e303ec
md"
---
###### *Addition* of complex numbers in *polar* coordinates in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *polar* coordinates
"

# ╔═╡ 9db9b3ae-5842-4278-a1b7-dfd5cc048527
let
	z0 = makeZRectFromRealImag(2, 1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(
		realPart(z0)/magnitude(z0), -realPart(z0)/magnitude(z0))
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
 	addComplex(z1, z3)    # (2.8964 ∠ 0.0365) or (2.8945 + 0.1054i)
end # let

# ╔═╡ 63d8a731-cd1b-4915-8dfd-b06fa29a8081
md"
---
###### *Subtraction* of complex numbers in *polar* coordinates in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates
"

# ╔═╡ 6f6bbf9f-a0de-4114-9e23-1cac8f525dc8
let
	z0 = makeZRectFromRealImag(2, 1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(
		realPart(z0)/magnitude(z0), -realPart(z0)/magnitude(z0))
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
 	subComplex(z1, z3)    #  (2.1934 ∠ 1.0425)  or  (1.1056 + 1.8944i)
end # let

# ╔═╡ 926b8d68-a57d-4547-bc7f-c61932ca88e7
md"
---
###### *Multiplication* of complex numbers in *polar* coordinates in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates
"

# ╔═╡ 6a374dcf-bf22-41aa-8a19-b8e45b494eae
let
	z0 = makeZRectFromRealImag(2, -1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(2,  2)
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
	mulComplex(z1, z3)   #  (6.3246 ∠ 0.3218) or (6.0000 + 2.0000i)
end # let

# ╔═╡ 9da9126e-2daa-453a-9527-c0bb99a6f124
md"
---
###### *Division* of complex numbers in *polar* coordinates in $$\mathbb C$$
[Result](https://www.intmath.com/complex-numbers/convert-polar-rectangular-interactive.php) is a complex number in *rectangular* coordinates.
"

# ╔═╡ 67513820-6d48-44c1-93be-fd079e873d18
let
	z0 = makeZRectFromRealImag(3, -1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(1,  2)
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
	#  (1.41 ∠ 4.85) = (1.41 ∠ 4.85-2π) = (1.41 ∠ -1.43)
	divComplex(z1, z3)  # (1.41 ∠ -1.43) or (0.20 − 1.4i)
end # let

# ╔═╡ 4d16651d-f7dc-48c2-88a7-1725968dcba2
md"
---
##### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/10/28

---
##### end of ch. 2.4.3
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
# ╟─f135f3a0-56a9-11ed-061c-7b66fe82a635
# ╟─c3bba84d-f891-46b9-be00-3db34c3743fa
# ╟─45672303-1883-4d3b-b0fe-3e912d3cac46
# ╠═43270f51-e79f-4ee4-8705-fad9b44778d4
# ╠═61b610a5-401b-4652-a9e9-cd46263c099b
# ╠═4b3dcc1b-0469-4cb4-bc0f-1f1e6a370d6d
# ╠═d45f0975-744e-4ff4-bf6a-e5a377713bae
# ╟─9c1e16cc-8650-41b8-828c-c4340cb03243
# ╠═9c97c826-f317-4a24-bb0b-8ae8b552af6d
# ╠═4ac58d4a-3820-46e8-b1e7-12ead084f116
# ╠═f83ba6f2-5410-4e24-b0d9-3aeec7bdd3c1
# ╟─149bb3bb-1e5b-4010-94f6-bea49b17f714
# ╟─bb9f139c-d8ba-4de3-9ba0-00d1e952ae35
# ╟─ead06a15-8374-444f-9e48-394eedd20656
# ╠═42eeefe4-0d8c-4bf2-b19a-eef3a9258e79
# ╠═2e0f0c63-173c-40a1-8668-42a996c5d733
# ╠═3806c36d-95a9-498b-bcba-664b2d765088
# ╠═324dc393-5326-4b61-8545-086aaa465955
# ╠═77085bea-8fa6-4eab-a36c-78420ba6bbc2
# ╟─4b0e56fd-1a03-4ed8-b691-fd106929e923
# ╠═106dba00-6a16-4f5d-bb84-7a31509eb62c
# ╠═92d64081-2d5d-419a-947e-1e1cc6b3b9fb
# ╠═f2257d43-94b3-4b2c-8c11-05b88cddf386
# ╟─3d71261a-930f-4a17-9d56-16e0ce8674bb
# ╠═02ad8e0c-581d-46fe-876b-400f6daa4865
# ╟─8982c3e8-778b-4fcb-a8a8-a7c935901961
# ╠═9fdd8679-bd67-4d2e-810a-5560af87edcf
# ╟─efb4c70f-7dbb-4ef6-90b3-5a60cb19b23e
# ╠═fe895b18-a1c0-4a7c-8c38-37d65f031450
# ╟─5b087edd-fb98-4247-acb1-c565d3d7a630
# ╠═b5b3673e-a06f-48a8-a2be-25006e5fb4a2
# ╟─ebe7b24a-beec-406b-acf8-71b414f29893
# ╠═0873f8fa-5f2c-49ae-bab6-eabdf1d7ff2c
# ╠═55697ad8-f53c-4fe7-a696-8c80aa8a4164
# ╠═48aa5558-1446-40ec-8c4d-f5202577d721
# ╠═cb95d31c-9b8c-48a5-a20e-b77fef8c83ed
# ╠═55f4e841-ca98-4c32-ac78-a402567bd958
# ╠═d6e79de7-b43a-4870-b932-6571e0b60b04
# ╠═eac6bb08-e92e-4784-a37d-6748564086a6
# ╠═31742b8a-ebcf-460e-871b-59b97c2759ff
# ╠═8dff3423-4621-47d2-be08-871e40f9602f
# ╟─4fc25aeb-5347-4dff-9821-ae7660849ca4
# ╠═2161e479-a6da-4677-9f7b-021107a6d003
# ╠═23e23f28-51c4-4169-ba0a-9a3ec2a71759
# ╟─85b10bef-d897-4dbe-8648-c0e76ce5b676
# ╠═71c6e66e-4887-4cc0-b3d7-565b9f6fe33c
# ╠═2fca10b7-ffa3-4530-8bd3-e6e4d9cccc09
# ╟─485745d0-5224-4788-920e-fab135c45652
# ╠═149ab1b6-9c21-40aa-bb85-cdd834f3f8ba
# ╠═1d581b15-1712-4dcb-a681-b748e08b7e4c
# ╠═b7bbc511-2034-4536-947f-f211bae04133
# ╠═3afbaf52-f5bd-4b92-b486-d05be9c15743
# ╠═e4588d6a-82e5-4a4b-a86e-1d3bd3863bfa
# ╠═5562b3a3-875c-40a8-98b1-a4d809a38163
# ╠═845ed715-5547-4fba-ab4c-05ac18e595a2
# ╠═11e55d16-98fb-44ca-85e1-fd11d8cd3c6c
# ╠═d505818f-da2b-4265-ba6c-049bf5d4ba9e
# ╠═18fd40a7-60e2-4890-9f37-84709cd92a7e
# ╠═6b89f377-4468-4740-b9d3-01fc6de13047
# ╠═afd3c274-7c96-4884-93e5-4c7a021140aa
# ╟─e768b7e4-46b6-4ed1-8dbb-ee5052312939
# ╠═22be72ec-7090-45fe-963f-011f75c7e337
# ╟─e8d6a66f-414a-4e70-8705-4f4445bc48c8
# ╠═99f58556-0d5e-423b-9b04-8cbac3167876
# ╟─f1ad9656-1105-4c60-abfd-982c5d0802fe
# ╠═63e2c323-1cad-4bf6-8ad3-2c6681b76cb5
# ╟─9b1e91c5-ab05-4e25-80c7-c3f690fdeb50
# ╠═3a46c792-3b37-4cfc-a371-a5e9a0f068cb
# ╟─b2ef9612-c06a-436d-9e1a-4ad69e5338be
# ╠═d20e564f-f6e8-4b7e-b93a-43e6a4725212
# ╠═2bbdecd4-f786-480e-93cd-c5e5cac398f6
# ╠═06365e9b-9ad4-4891-9f7a-6a23f4f7b100
# ╠═d6d3b4f0-3ddf-4f9e-a027-5fce5df444f9
# ╠═8027339b-87a4-4d7a-a291-71d6df76f780
# ╟─4c1deedb-da8e-401f-bda5-df9b67dd1145
# ╠═04dd57cc-fd45-4c7c-827e-2cd2012cf839
# ╠═e5dce11a-b925-4b8e-b30d-d8a59222a0d2
# ╟─b487d7d2-0f42-429f-bc9c-25d03444b1a7
# ╠═0bad2a95-2bb5-4a41-8b31-b2065e2a0a62
# ╠═9b758276-b59a-413d-8769-f0dc3d47c646
# ╟─15715a76-6549-4012-83e2-689a69d250e3
# ╠═039dd612-772f-429c-bb55-bda320c1d0a7
# ╟─28f5eb24-4bbd-415c-a3a8-2a8df9e303ec
# ╠═9db9b3ae-5842-4278-a1b7-dfd5cc048527
# ╟─63d8a731-cd1b-4915-8dfd-b06fa29a8081
# ╠═6f6bbf9f-a0de-4114-9e23-1cac8f525dc8
# ╟─926b8d68-a57d-4547-bc7f-c61932ca88e7
# ╠═6a374dcf-bf22-41aa-8a19-b8e45b494eae
# ╟─9da9126e-2daa-453a-9527-c0bb99a6f124
# ╠═67513820-6d48-44c1-93be-fd079e873d18
# ╟─4d16651d-f7dc-48c2-88a7-1725968dcba2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
