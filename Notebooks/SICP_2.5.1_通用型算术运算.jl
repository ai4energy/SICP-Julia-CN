### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 3a789ed0-6f25-11ed-3bcc-9d85e82fddbd
md"
====================================================================================
##### SICP: 2.5.1 [Generic Arithmetic Operations（通用型算术运算）](https://sarabander.github.io/sicp/html/2_002e5.xhtml#g_t2_002e5_002e1)
====================================================================================
"

# ╔═╡ b352cb37-d623-40e4-aa96-93bf93c8a36a
md"
#### 2.5.1.1 *Ground*-level *SICP-Scheme*-like functions and operators
"

# ╔═╡ b14e59e2-7b83-4c62-ae1a-3b65eeeda575
struct Cons
	car
	cdr
end

# ╔═╡ 341a48b4-5614-46c6-916d-4c0593d54659
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ 46562440-ef41-48d5-9e4b-bba582da7c4c
car(cell::Cons) = cell.car

# ╔═╡ 1a9a7132-626a-4b15-b382-62576c71a5c6
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ c65da2ce-3803-4e48-8585-7763445417dd
md"
---
##### Representation *in*dependent interface functions
"

# ╔═╡ 074de4c6-ba2f-4df9-b468-0c3c513c46c4
function attachTag(typeTag, contents) 
	cons(typeTag, contents) 
end # attachTag

# ╔═╡ 698d288d-c9ff-450f-ad58-28a7ab47a9f8
function typeTag(datum) 
	car(datum)
end # typeTag

# ╔═╡ adfdcc85-da65-4623-9d6a-2133b7ab871d
function contents(datum) 
	cdr(datum)
end # function contents

# ╔═╡ af74f59d-26db-428e-8e9b-d6605e5f427b
md"
---
##### *Procedures* for the manipulation of the *operation$$\times$$type* tables
"

# ╔═╡ f6daf9a8-e367-4ee9-8eb1-cfb13b8ac81f
md"
###### Table *constructors* 
"

# ╔═╡ 95b595b9-7a35-47ff-b6d2-d3c4331d90b8
Dict{Tuple, Function}                 # types of dictionary

# ╔═╡ 1528b18b-0469-469e-b467-71bd3571a096
# construction of empty table as a dictionary
myTableOfOpsAndTypes = Dict()

# ╔═╡ fe78d635-b2b9-4e2e-8e3f-61a4eb78f1fc
myTableOfOpsAndTypes

# ╔═╡ 0a6f350d-0a00-4087-b226-0409729a9e65
typeof(myTableOfOpsAndTypes)

# ╔═╡ 5235492c-e307-45b1-8256-8a8b4c748f3c
function myPut!(op::Symbol, opTypes::Tuple, lambdaExpression::Function) 
	# Dict((op::Symbol, opType::Symbol) <= lambdaExpression::Function)
	myTableOfOpsAndTypes[op::Symbol, opTypes::Tuple] = lambdaExpression
end # function put

# ╔═╡ 124192da-7076-43fc-962a-d0c10883cdbd
md"
---
###### Table *selectors* 
"

# ╔═╡ dd346a4c-8399-439d-8677-977dbce90b8f
get  # SICP's get cannot be used here, because it's already in use in other contexts

# ╔═╡ 61676c9a-b533-409c-afb4-9caed5d33238
function myGet(op::Symbol, opType::Tuple) # instead of SICP's get
	# Dict((op::Symbol, opType::Symbol) => item::Function)
	myTableOfOpsAndTypes[op::Symbol, opType::Tuple]
end # function myGet

# ╔═╡ 71aee367-6d51-41ff-9d65-9cf0e313e81d
function getOpsOfType(table, argType)
	filter(pairOpOpType -> 
		let
			(op, opType) = pairOpOpType
			opType == argType ? true : false
		end, # let
		keys(table))
end # function getOpsOfType

# ╔═╡ 8e888d27-0b63-471b-9130-e696b3c6a7e9
md"
$$\begin{array}{|c|}
\hline                                                                         \\
\text{Domain-specific} \textit{ generic } \text{operations}                    \\
\hline                                                                         \\
add \;\;\;\;\;\;\;\;\;\; sub                                                   \\
mul \;\;\;\;\;\;\;\;\;\; div                                                   \\
numerator                                                                      \\
denominator                                                                    \\
                                                                               \\
\hline                                                                         \\
\text{Generic} \textit{ arithmetic } \text{package}                            \\     
\begin{array}{c|c|c}
                        & \hline                          &                    \\
\text{Rational}         & \text{Complex}                  & \text{Ordinary}    \\
\text{arithmetic}       & \text{arithmetic}               & \text{arithmetic}  \\
\hline                                                                         \\
addRat \;\; subRat \;\; & addComplex \;\; subComplex \;\; & \;\; + \;\; -      \\
mulRat \;\; divRat \;\; & mulComplex \;\; divComplex \;\; & \;\; * \;\; /      \\
numerRat                & realPart                        &                    \\
denomRat                & imagPart                        &                    \\
                        &                                 &                    \\
\hline                                                                         \\
                        & \text{Rectangular}\;\;\;\;\;\text{Polar} &           \\
                        & \hline                          &                    \\
                        & addComplexRect \;\; addComplexPolar &                \\
                        & subComplexRect \;\; subComplexPolar &                \\
                        & mulComplexRect \;\; mulComplexPolar &                \\
                        & divComplexRect \;\; divComplexPolar &                \\
                        & realPartRect   \;\; realPartPolar   &                \\
                        & imagPartRect   \;\; imagPartPolar   &                \\
                        &                                     &                \\
\end{array}                                                                    \\
\hline
\end{array}$$


**Fig. 2.5.1.1** Generic arithmetic system (cf. SICP, 1996, Fig. 2.23)

---
"

# ╔═╡ 0fa115b4-f02e-4c70-bb13-2c230b807b90
md"
##### Generic *arithmetic* procedures
"

# ╔═╡ 6785099b-8f50-4b65-8dbb-0b514af96bbf
function applyGeneric(opSymbol, xs...) # SICP's '.args' is renamed to slurping 'xs'
	let
		typeTags = map(typeTag, xs)
		proc     = myGet(opSymbol, typeTags)  # splatting of typeTags
		content  = map(contents, xs)   
		proc(content...)               # application of proc to splatting of content
	end # let
end # function applyGeneric

# ╔═╡ e791fe67-9ebd-4965-bdb8-49823ca2b1f0
myPrint(x) = applyGeneric(:print,  x)  # generic print function

# ╔═╡ e25fdfac-e91c-4d47-bb43-2eadc90608c1
md"
###### Generic arithmetic *constructors* 
"

# ╔═╡ 4565c0ac-7900-406a-9d81-520e1aa9cba0
make(x)    = applyGeneric(:make,   x)  # generic constructor function

# ╔═╡ 0a35072a-f929-4791-9b58-810f0846f70e
md"
###### Generic arithmetic *selectors* 
"

# ╔═╡ a576dcd3-5992-4605-8bd4-b366130e687a
begin
	numerator(x)   = applyGeneric(:numer, x)       # generic selector numerator
	denominator(x) = applyGeneric(:denom, x)       # generic selector denominator
	realPart(z)    = applyGeneric(:realPart, z)    # generic selector realPart
	imagPart(z)    = applyGeneric(:imagPart, z)    # generic selector imagPart
	magnitude(z)   = applyGeneric(:magnitude, z)   # generic selector norm
	angle(z)       = applyGeneric(:angle, z)       # generic selector angle
end

# ╔═╡ 66ad6609-fa02-4c5d-936b-091de42c5bf2
md"
###### Generic arithmetic *operators*
"

# ╔═╡ d47fb6bd-a6b0-4c47-ad68-2a719c086003
begin
	add(x, y)  = applyGeneric(:add, x, y)  # generic addition function
	sub(x, y)  = applyGeneric(:sub, x, y)  # generic subtraction function
	mul(x, y)  = applyGeneric(:mul, x, y)  # generic multiplication function
	div(x, y)  = applyGeneric(:div, x, y)  # generic division function
end # begin

# ╔═╡ 738c8e2e-06de-4fb0-b57a-28bac1755ff4
md"
---
##### *Ordinary* (SICP-*Scheme*-like) number package
"

# ╔═╡ 2a734656-20d2-437b-abe2-5f2437b4addb
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

# ╔═╡ 6c05818e-bd48-42f4-bb9c-240aee64b8d5
md"
###### Installation of $$installSICPNumberPackage$$
"

# ╔═╡ 1923749d-ae33-4145-b2c1-868dbae2a43e
installSICPNumberPackage()

# ╔═╡ f6db0bdd-82e0-4d2e-8ee0-5f46a47d6779
getOpsOfType(myTableOfOpsAndTypes, (:sicpNumber,))

# ╔═╡ 3966cebe-8aa5-4bf0-8dc2-4ad5c5ba1874
getOpsOfType(myTableOfOpsAndTypes, (:sicpNumber, :sicpNumber))

# ╔═╡ 3ea75801-d119-4ed1-86c5-b63e27e6e492
md"
---
###### *Constructor* of ordinary (*Scheme-like*) $$:sicpNumber$$ numbers
"

# ╔═╡ 020ae148-95e3-440b-ad3e-8651c8fe436c
function makeSicpNumber(n) 
	myGet(:make, (:sicpNumber,))(n)
end # function makeSicpNumber

# ╔═╡ a6708af2-69b1-4732-86d1-793b179a8b83
md"
---
###### *Test* calculations with ordinary (*Scheme-like*) $$:sicpNumber$$ numbers
"

# ╔═╡ 01ff1f86-ca11-439f-8d09-cb66146212fd
π

# ╔═╡ 7fdc31c4-29be-4c95-ae0d-69ebb20532c5
myGet(:make, (:sicpNumber,))(π)

# ╔═╡ 0a4f7989-be08-4e2c-b33b-78f6be817f72
sicpPi = makeSicpNumber(π)

# ╔═╡ 865aeb46-914b-45de-866f-0edb49e42ffe
sicpPi

# ╔═╡ e97ce8e6-031d-4080-b246-c4b4d0e021cf
cdr(sicpPi)

# ╔═╡ 1efac5f5-1421-4381-b753-ba007040fb3b
myPrint(sicpPi)

# ╔═╡ 9a5b4cb6-0a08-4352-9db4-bc7cbdd73460
sicpTwo = makeSicpNumber(2.0)

# ╔═╡ ca032b9e-230b-49a9-b546-0e0748660040
sicpTwo

# ╔═╡ 978ffc35-ad22-455d-8bef-c588d4326130
cdr(sicpTwo)

# ╔═╡ 44eb8206-0021-4227-8cfc-0d1136b10c5d
myPrint(sicpTwo)

# ╔═╡ 61ed1538-f952-4f66-b541-60afea9a8826
add(sicpPi, sicpTwo)

# ╔═╡ cc9e3e80-14d4-4116-ab53-ef8a7f0ebbd3
myPrint(add(sicpPi, sicpTwo))

# ╔═╡ 95306fea-3c3b-4082-90b9-1e8ac54d5af5
sub(sicpPi, sicpTwo)

# ╔═╡ 4fa5614d-1eac-4a7a-8a7a-c0e51f504be4
myPrint(sub(sicpPi, sicpTwo))

# ╔═╡ 5614e552-5baf-4192-b01c-835115e22e05
mul(sicpPi, sicpTwo)

# ╔═╡ 22029aba-c648-4089-b7bf-c9aab92c212d
myPrint(mul(sicpPi, sicpTwo))

# ╔═╡ 9b21719c-2955-4e1c-97b0-8c1458ae5c5c
div(sicpPi, sicpTwo)

# ╔═╡ eded9da5-e470-405e-bf32-186dd69752b8
myPrint(div(sicpPi, sicpTwo))

# ╔═╡ 3e710fe0-a2ff-4d42-8734-41597f59fbed
md"
---
##### *Rational* number package
"

# ╔═╡ 70c0ba7d-d6b4-4e1c-8095-a909a833ad7d
function installRationalPackage()
	#====================================================================#
	# local procedures
	tag!(x) = attachTag(:rational, x)
	#---------------------------------------------------------------------
	numerRat(x) = car(x)
	denomRat(x) = cdr(x)
	#---------------------------------------------------------------------
	printRat(x) = "$(numerRat(x))//$(denomRat(x))"
	#---------------------------------------------------------------------
	makeRat(x, y) = 
		let n = round(Int, x)
			d = round(Int, y)
			g = gcd(n, d)
			cons(n / g, d / g)
		end # let
	#---------------------------------------------------------------------
	addRat(x, y) = 
		makeRat(
			numerRat(x) * denomRat(y) + numerRat(y) * denomRat(x), 
			denomRat(x) * denomRat(y))
	#---------------------------------------------------------------------
	subRat(x, y) = 
		makeRat(
			numerRat(x) * denomRat(y) - numerRat(y) * denomRat(x), 
			denomRat(x) * denomRat(y))
	#---------------------------------------------------------------------
	mulRat(x, y) =
		makeRat(
			numerRat(x) * numerRat(y), 
			denomRat(x) * denomRat(y))
	#---------------------------------------------------------------------
	divRat(x, y) =
		makeRat(
			numerRat(x) * denomRat(y), 
			denomRat(x) * numerRat(y))
	#---------------------------------------------------------------------
	equalRat(x, y) =
		numerRat(x) * denomRat(y) == denomRat(x) * numerRat(y)
	#====================================================================#
	# interface to rest of system
	myPut!(:print,(:rational,),                     printRat)
	myPut!(:numer,(:rational,),                     numerRat)
	myPut!(:denom,(:rational,),                     denomRat)
	#---------------------------------------------------------------------
	myPut!(:make, (:rational,),           (n, d) -> tag!(makeRat(n, d)))
	#---------------------------------------------------------------------
	myPut!(:add,  (:rational, :rational), (x, y) -> tag!(addRat(x, y)))
	myPut!(:sub,  (:rational, :rational), (x, y) -> tag!(subRat(x, y)))
	myPut!(:mul,  (:rational, :rational), (x, y) -> tag!(mulRat(x, y)))
	myPut!(:div,  (:rational, :rational), (x, y) -> tag!(divRat(x, y)))
	#---------------------------------------------------------------------
	"installRationalPackage done"
	#====================================================================#
end # function installRationalPackage

# ╔═╡ c986fde7-f56f-4eea-bf28-9984ace2a580
installRationalPackage()

# ╔═╡ 8927ee89-93da-49ed-83eb-645e901a36e5
getOpsOfType(myTableOfOpsAndTypes, (:rational,))

# ╔═╡ 4472a8e2-52d3-4902-b076-ce862f29f663
getOpsOfType(myTableOfOpsAndTypes, (:rational, :rational))

# ╔═╡ 6f5d7f81-c900-4340-afe8-b0046c5738c8
md"
---
###### *Constructor* of $$:rational$$ numbers
"

# ╔═╡ 712e83a5-f659-4a0b-859f-48895639aba7
function makeRational(n, d)
	myGet(:make, (:rational,))(n, d)
end # function makeRational

# ╔═╡ 5e7fc3f3-b8e7-4243-b819-e78d88d6cc96
md"
---
###### *Test* calculations with $$:rational$$ numbers
"

# ╔═╡ bffc1f11-75da-4492-80aa-7408b07e33e7
oneHalf = makeRational(2, 4)       # 2//4 ==> 1.0//2.0

# ╔═╡ 6631ff41-9a8e-4fdf-8e0a-06866f1ae4c1
myPrint(oneHalf)                   # "1.0//2.0"

# ╔═╡ 7d4b921a-ea56-44fd-a98c-097e2268e315
numerator(oneHalf)

# ╔═╡ 7b449582-33d1-4c6f-8378-46b92722be1b
denominator(oneHalf)

# ╔═╡ 7c610221-9c3a-4836-a308-d407d0fe918a
oneThird = makeRational(9, 27)     # 9//27 ==> 1.0//3.0

# ╔═╡ a2e2978f-1457-4a10-89d5-d39ad61a9ad0
add(oneHalf, oneThird)             # 1//2 + 1//3 = 3//6 + 2//6 ==> 5.0//6.0

# ╔═╡ 00c2f696-eaf7-4417-a1fd-5e1a0854a764
myPrint(add(oneHalf, oneThird))    # 1//2 + 1//3 ==> "5.0//6.0"

# ╔═╡ 7ba57322-b61a-4881-ae6d-60265feeccf6
sub(oneHalf, oneThird)             # 1//2 - 1//3 = 3//6 - 2//6 = 1.0//6.0

# ╔═╡ da9a1cf1-a538-4ade-9426-52d832c3291d
mul(oneHalf, oneThird)             # 1//2 * 1//3 = 1.0//6.0

# ╔═╡ 185f79dd-c285-461c-a91a-dbaad2d41651
div(oneHalf, oneThird)             # 1//2 / 1//3 = 1//2 * 3//1 ==> 3.0//2.0

# ╔═╡ e5f83fe6-4bc1-4a94-847b-e294e23b8c4f
myPrint(div(oneHalf, oneThird))    # 1//2 / 1//3 ==> "3.0//2.0"

# ╔═╡ 3da1f59e-5f8a-4298-a4a8-1788e211e146
md"
---
##### *Complex* number package based on *rectangular* coordinates
"

# ╔═╡ 00ddddbb-b864-4e1e-8009-cdb90287cb81
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
	#---------------------------------------------------------------------------------
	"Ben's rectangular package installed"
	#================================================================================#
end # function installRectangularPackage

# ╔═╡ c6b227b7-0fd0-403f-bb4c-af35d35bc4e4
installRectangularPackage()

# ╔═╡ d650355d-2f3d-45f0-9a88-299effe3667d
getOpsOfType(myTableOfOpsAndTypes, (:rectangular,))

# ╔═╡ 2d53e3c6-0835-45cd-9796-52d262bc0d55
getOpsOfType(myTableOfOpsAndTypes, (:rectangular, :rectangular))

# ╔═╡ abfe14e8-738a-4a1c-beb3-d3e6f0cc975f
md"
---
##### *Constructor* for *rectangular* complex numbers external to Ben's package
"

# ╔═╡ 44480674-6e5d-430e-a7be-5f297837697d
function makeZRectFromRealImag(x, y)                            # SICP, 1996, p.184
	myGet(:makeZFromRealImag, (:rectangular,))(x, y)
end # function makeZRectFromRealImag

# ╔═╡ 385ce0a2-8753-4b6e-a7c6-844107b7cbc3
function makeZRectFromMagAng(r, a)
	myGet(:makeZFromMagAng, (:rectangular,))(r, a)
end # function makeZRectFromMagAng

# ╔═╡ efdd4c60-0de1-4298-8ed7-7f02fe6aae3d
md"
---
##### *Test* constructions with *rectangular* packagage
"

# ╔═╡ bf573744-d9ec-4157-9f08-572d5289cd59
let
	z1 = makeZRectFromRealImag(2, 1)
	r1 = magnitude(z1)                  # √(2^2 + 1^2) = √5 ==> 2.236
	z2 = makeZRectFromRealImag(realPart(z1)/r1, -2*imagPart(z1)/r1)
	# (2 + 1i) + (2/2.36 - 2*1i/2.236) = (2 + 1i) + (0.894 - 0.894i) 
	#  ==> (2.894 + 0.106i)
	z3 = add(z1, z2)
end # let

# ╔═╡ ce57e202-3aa0-416b-9662-113d12f7ba52
let
	z1 = makeZRectFromRealImag(2, 1)
	r1 = magnitude(z1)
	z2 = makeZRectFromRealImag(realPart(z1)/r1, -2*imagPart(z1)/r1)
	# (2 + 1i) - (2/√5 - 2/√5i) = (2 + 1i) - (.89  -.89i) ==> (1.105 + 1.894)
	z3 = sub(z1, z2)
end # let

# ╔═╡ db647038-275c-4f3b-a48c-46105942318e
let
	z1 = makeZRectFromRealImag(2,  1)
	z2 = makeZRectFromRealImag(2,  1)
	# (2 + 1i)(2 + 1i) = (2^2 + 2*1i + 1i*2 + 1^2*i^2) = (4 + 4i -1) ==> (3 + 4i)
	z3 = mul(z1, z2)
end # let

# ╔═╡ 01e612bd-d630-4186-8e10-da6211ab9cdb
let
	z1 = makeZRectFromRealImag(2, 1)      # ==> 2.0, 1.0i
	z2 = makeZRectFromMagAng(2.24, 0.46)  # ==> 2.0, 1.0i
	mul(z1, z2)                           # ==> 3.0, 4.0i
end # let

# ╔═╡ 341f88ee-db9e-4854-8a76-9abc26bfa1d5
let
	z1 = makeZRectFromRealImag(2, -1)
	z2 = makeZRectFromRealImag(2,  2)
	# (2 - 1i)(2 + 2i) = (4 + 4i - 2i + 2) ==> (6 + 2i)
	z3 = mul(z1, z2)     
end # let

# ╔═╡ 06022d25-4a62-43f0-bcf6-9a0629f7d917
let
	z1 = makeZRectFromRealImag(3, -1)
	z2 = makeZRectFromRealImag(1,  2)
	# (3 - 1i)/(1 + 2i) = ((3 - 1i)(1 - 2i))/((1 + 2i)(1 - 2i)) 
	# = (3 -6i - 1i - 2)/(1 + 4) = (1 - 7i)/5 = 1/5 - (7/5)i ==> 0.2 - 1.4i
	z3 = div(z1, z2)  
end # let

# ╔═╡ 07fd573e-4c43-4416-8a3f-0a0f5bf746fd
md"
---
##### *Complex* number package based on *polar* coordinates
"

# ╔═╡ 4e90ff13-3841-481b-9a5f-1a9dfa18bfd8
function installPolarPackage() # Alyssa's polar package
	#========================================================================#
	# internal procedures
	#-------------------------------------------------------------------------
	tag!(x) = attachTag(:polar, x)
	#-------------------------------------------------------------------------
	makeZFromMagAng(r, a)   = cons(r, a)
	makeZFromRealImag(x, y) = cons(√(x^2 + y^2), atan(y, x))
	#-------------------------------------------------------------------------
	realPartPolar(z)   = magnitudePolar(z) * cos(anglePolar(z))
	imagPartPolar(z)   = magnitudePolar(z) * sin(anglePolar(z))
	magnitudePolar(z)  = car(z)
	anglePolar(z)      = cdr(z)
	#-------------------------------------------------------------------------
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
	#========================================================================#
	# interface to rest of system
	#-------------------------------------------------------------------------
	myPut!(:makeZFromRealImag, (:polar,),
		(x, y) -> tag!(makeZFromRealImag(x, y)))
	myPut!(:makeZFromMagAng,   (:polar,),
		(r, a) -> tag!(makeZFromMagAng(r, a)))	
	#-------------------------------------------------------------------------
	myPut!(:real,         (:polar,),           realPartPolar)
	myPut!(:imag,         (:polar,),           imagPartPolar)
	myPut!(:magnitude,    (:polar,),           magnitudePolar)
	myPut!(:angle,        (:polar,),           anglePolar)
	#-------------------------------------------------------------------------
	myPut!(:add, (:polar, :polar), (z1, z2) -> tag!(addComplexPolar(z1, z2)))
	myPut!(:sub, (:polar, :polar), (z1, z2) -> tag!(subComplexPolar(z1, z2)))
	myPut!(:mul, (:polar, :polar), (z1, z2) -> tag!(mulComplexPolar(z1, z2)))
	myPut!(:div, (:polar, :polar), (z1, z2) -> tag!(divComplexPolar(z1, z2)))
	#-------------------------------------------------------------------------
	"Alyssa's polar package installed"
	#========================================================================#
end # function installPolarPackage

# ╔═╡ ddf22741-2fbe-46bc-abc7-052be48a5a9d
installPolarPackage()

# ╔═╡ 304759c2-1322-49a0-bade-e7a2452f6774
getOpsOfType(myTableOfOpsAndTypes, (:polar,))        # get all ops (rows) for type (column) ':polar'

# ╔═╡ 8cdb4671-6f71-42bf-94e9-1d31343038e5
getOpsOfType(myTableOfOpsAndTypes, (:polar, :polar)) 

# ╔═╡ 3631639d-e62e-4669-b6c3-7730206dfbe7
md"
---
##### *Constructor* for polar complex numbers *external* to Alyssa's package
"

# ╔═╡ 0bc77445-062f-4b55-9a24-67b9588355b0
function makeZPolarFromRealImag(x, y)                          # SICP, 1996, p.184
	myGet(:makeZFromRealImag, (:polar,))(x, y)
end # function makeZPolarFromRealImag

# ╔═╡ a54939b5-aac8-4d76-b18b-f887973453a7
function makeZPolarFromMagAng(r, a)                            # SICP, 1996, p.184
	myGet(:makeZFromMagAng, (:polar,))(r, a)
end # function makeZPolarFromMagAng

# ╔═╡ 004a465e-2c46-4869-aa9e-81073ca38999
md"
##### *Test* calculations of complex numbers in *polar* form
"

# ╔═╡ 1de38341-0d9d-4b32-be47-2945dac2b7c6
let
	z0 = makeZRectFromRealImag(2, 1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(
			realPart(z0)/magnitude(z0), -realPart(z0)/magnitude(z0))
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
 	add(z1, z3)    # (2.8964 ∠ 0.0365) or (2.8945 + 0.1054i)
end # let

# ╔═╡ 9b7837b3-1b41-46c9-a10f-d872f92cf184
let
	z0 = makeZRectFromRealImag(2, 1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(
		realPart(z0)/magnitude(z0), -realPart(z0)/magnitude(z0))
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
 	sub(z1, z3)    #  (2.1934 ∠ 1.0425)  or  (1.1056 + 1.8944i)
end # let

# ╔═╡ 9ef822cc-93aa-4d10-856a-774a3318cabf
let
	z0 = makeZRectFromRealImag(2, -1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(2,  2)
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
	mul(z1, z3)   #  (6.3246 ∠ 0.3218) or (6.0000 + 2.0000i)
end # let

# ╔═╡ 45ecf3da-2375-4312-b440-055b7728d22b
let
	z0 = makeZRectFromRealImag(3, -1)
	z1 = makeZPolarFromMagAng(magnitude(z0), angle(z0))
	z2 = makeZRectFromRealImag(1,  2)
	z3 = makeZPolarFromMagAng(magnitude(z2), angle(z2))
	#  (1.41 ∠ 4.85) = (1.41 ∠ 4.85-2π) = (1.41 ∠ -1.43)
	div(z1, z3)  # (1.41 ∠ -1.43) or (0.20 − 1.4i)
end # let

# ╔═╡ e36a07c1-cf62-4e65-9797-309bb6e89f93
md"
---
#### 2.5.1.2 *Idiomatic* Julia operators
"

# ╔═╡ 3fe2583c-cc43-4f87-9ea5-923d1dd5649b
md"
###### *Ordinary* Julia numbers $$\;\mathbb N, \mathbb Z, \mathbb R$$
"

# ╔═╡ 20f53637-1681-4201-9ca3-9907f6c8ae05
md"
###### $$\pi \in \mathbb R$$
"

# ╔═╡ b158f84c-f814-4837-915d-cbf3ffd30502
π

# ╔═╡ 4562f05d-21c9-490e-ba28-a70636b00d9c
π + 2

# ╔═╡ 7304e21b-b117-4ce1-8105-d4d1017d9d12
π + 2.0

# ╔═╡ bf0667f9-1d5e-4b72-b928-2576cec79427
md"
###### *Rational* Julia numbers $$\;q \in \mathbb Q$$
"

# ╔═╡ 82ccfffd-ed23-43c5-b083-0732d5ebf4a6
md"
###### $$q \in \mathbb Q$$
"

# ╔═╡ 41d813f1-f8df-475b-b487-a7b1de5f2cc8
oneQuarter = 1//4

# ╔═╡ b1004c19-f96b-4131-808d-3c901c36bbd6
π + 2//1

# ╔═╡ 5a558a28-95ef-4d51-ac74-a67c119118c1
md"
###### *Complex* Julia numbers $$\;z \in \mathbb Z$$
"

# ╔═╡ ef1fcb75-d216-4886-89b3-d556f99b5d8a
Complex(2, 0)

# ╔═╡ 9e4dd8e7-d7ed-4b03-9de8-c6ec3e806119
md"
###### *Addition* of *rectangular* complex numbers
"

# ╔═╡ a7682770-d6dd-4ea2-ba2f-c3056851d6f6
let
	z1 = Complex(2, 1)
	r1 = abs(z1)   # abs = magnitude: √(2^2 + 1^2) = √5 ==> 2.236
	z2 = Complex(real(z1)/r1, -2*imag(z1)/r1)
	# (2 + 1i) + (2/2.36 - 2*1i/2.236) = (2 + 1i) + (0.894 - 0.894i) 
	#  ==> (2.894 + 0.106i)
	z3 = z1 + z2
end # let

# ╔═╡ 2b08a987-fd65-4790-9c98-73579826e071
md"
###### *Subtraction* of *rectangular* complex numbers
"

# ╔═╡ ad364342-a042-49b7-a767-d4d39c128fc5
let
	z1 = Complex(2, 1)
	r1 = abs(z1)
	z2 = Complex(real(z1)/r1, -2*imag(z1)/r1)
	# (2 + 1i) - (2/√5 - 2/√5i) = (2 + 1i) - (.89  -.89i) ==> (1.105 + 1.894)
	z3 = z1 - z2
end # let

# ╔═╡ 269bb77f-c77b-4c6b-a123-cda5647b12d0
md"
###### *Multiplication* of *rectangular* complex numbers
"

# ╔═╡ d2344839-95e1-44ab-9470-5c14520f1b2f
let
	z1 = Complex(2,  1)
	z2 = Complex(2,  1)
	# (2 + 1i)(2 + 1i) = (2^2 + 2*1i + 1i*2 + 1^2*i^2) = (4 + 4i -1) ==> (3 + 4i)
	z3 = z1 * z2
end # let

# ╔═╡ 8b4e408c-891d-442d-9f66-ae710fd3620c
let
	z1 = Complex(2, -1)
	z2 = Complex(2,  2)
	# (2 - 1i)(2 + 2i) = (4 + 4i - 2i + 2) ==> (6 + 2i)
	z3 = z1 * z2     
end # let

# ╔═╡ 45be7d9c-0fc5-456b-9957-8d5b135472a8
md"
###### *Division* of *rectangular* complex numbers
"

# ╔═╡ edd18f49-4451-4be2-98bd-08f819c87ca3
let
	z1 = Complex(3, -1)
	z2 = Complex(1,  2)
	# (3 - 1i)/(1 + 2i) = ((3 - 1i)(1 - 2i))/((1 + 2i)(1 - 2i)) 
	# = (3 -6i - 1i - 2)/(1 + 4) = (1 - 7i)/5 = 1/5 - (7/5)i ==> 0.2 - 1.4i
	z3 = z1 / z2  
end # let

# ╔═╡ 0b7cd85b-cf32-4ce5-981f-e801c41eecdf
md"
---
###### *Multiplication* of *polar* complex numbers (using *Euler's* formula)

[*Euler's* formula](https://en.wikipedia.org/wiki/Euler%27s_formula):

$$z = x + yi = |z|(cos \phi + i \cdot sin \phi) = r\cdot e^{i\phi}$$
" 

# ╔═╡ 2def8fc2-0b8f-43e2-9ac4-4ac0fa4bc999
let
	angle = Base.angle
	z0 = Complex(2, -1)
	# z1 = makeZPolarFromMagAng(myMagnitude(z0), myAngle(z0))
	z1 = abs(z0) * exp(angle(z0)*im)
	z2 = Complex(2,  2)
	# z3 = makeZPolarFromMagAng(myMagnitude(z2), myAngle(z2))
	z3 = abs(z2) * exp(angle(z2)*im)
	# z4 = mul(z1, z3) ==> (6.3246 ∠ 0.3218) or (6.0000 + 2.0000i)
    z4 = abs(z0) * abs(z2) * exp((angle(z0) + angle(z2))*im)
end # let

# ╔═╡ f47e8917-eaae-4377-8873-373a5fef0537
md"
---
###### *Division* of *polar* complex numbers (using *Euler's* formula)

[*Euler's* formula](https://en.wikipedia.org/wiki/Euler%27s_formula):

$$z = x + yi = |z|(cos \phi + i \cdot sin \phi) = r\cdot e^{i\phi}$$
"

# ╔═╡ d5fbb6ed-8572-4d77-aeb6-52d6a281995d
let
	angle = Base.angle
	z0 = Complex(3, -1)
	# z1 = makeZPolarFromMagAng(myMagnitude(z0), myAngle(z0))
	z1 = abs(z0) * exp(angle(z0)*im)
	# z2 = makeZRectFromRealImag(1,  2)
	z2 = Complex(1, 2)
	# z3 = makeZPolarFromMagAng(myMagnitude(z2), myAngle(z2))
	z3 = abs(z2) * exp(angle(z2)*im)
	#  (1.41 ∠ 4.85) = (1.41 ∠ 4.85-2π) = (1.41 ∠ -1.43)
	# div(z1, z3)  # (1.41 ∠ -1.43) or (0.20 − 1.4i)
	z4 = abs(z0) / abs(z2) * exp((angle(z0) - angle(z2))*im)
end # let

# ╔═╡ 120e829a-db3e-4861-8d6c-87379d0b5072
md"
---
##### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/12/08
"


# ╔═╡ 3c5134dc-82a4-4499-bb7e-d85efed47b13
md"
---
##### end of ch. 2.5.1
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
# ╟─3a789ed0-6f25-11ed-3bcc-9d85e82fddbd
# ╟─b352cb37-d623-40e4-aa96-93bf93c8a36a
# ╠═b14e59e2-7b83-4c62-ae1a-3b65eeeda575
# ╠═341a48b4-5614-46c6-916d-4c0593d54659
# ╠═46562440-ef41-48d5-9e4b-bba582da7c4c
# ╠═1a9a7132-626a-4b15-b382-62576c71a5c6
# ╟─c65da2ce-3803-4e48-8585-7763445417dd
# ╠═074de4c6-ba2f-4df9-b468-0c3c513c46c4
# ╠═698d288d-c9ff-450f-ad58-28a7ab47a9f8
# ╠═adfdcc85-da65-4623-9d6a-2133b7ab871d
# ╟─af74f59d-26db-428e-8e9b-d6605e5f427b
# ╟─f6daf9a8-e367-4ee9-8eb1-cfb13b8ac81f
# ╠═95b595b9-7a35-47ff-b6d2-d3c4331d90b8
# ╠═1528b18b-0469-469e-b467-71bd3571a096
# ╠═fe78d635-b2b9-4e2e-8e3f-61a4eb78f1fc
# ╠═0a6f350d-0a00-4087-b226-0409729a9e65
# ╠═5235492c-e307-45b1-8256-8a8b4c748f3c
# ╟─124192da-7076-43fc-962a-d0c10883cdbd
# ╠═dd346a4c-8399-439d-8677-977dbce90b8f
# ╠═61676c9a-b533-409c-afb4-9caed5d33238
# ╠═71aee367-6d51-41ff-9d65-9cf0e313e81d
# ╟─8e888d27-0b63-471b-9130-e696b3c6a7e9
# ╟─0fa115b4-f02e-4c70-bb13-2c230b807b90
# ╠═6785099b-8f50-4b65-8dbb-0b514af96bbf
# ╠═e791fe67-9ebd-4965-bdb8-49823ca2b1f0
# ╟─e25fdfac-e91c-4d47-bb43-2eadc90608c1
# ╠═4565c0ac-7900-406a-9d81-520e1aa9cba0
# ╟─0a35072a-f929-4791-9b58-810f0846f70e
# ╠═a576dcd3-5992-4605-8bd4-b366130e687a
# ╟─66ad6609-fa02-4c5d-936b-091de42c5bf2
# ╠═d47fb6bd-a6b0-4c47-ad68-2a719c086003
# ╟─738c8e2e-06de-4fb0-b57a-28bac1755ff4
# ╠═2a734656-20d2-437b-abe2-5f2437b4addb
# ╟─6c05818e-bd48-42f4-bb9c-240aee64b8d5
# ╠═1923749d-ae33-4145-b2c1-868dbae2a43e
# ╠═f6db0bdd-82e0-4d2e-8ee0-5f46a47d6779
# ╠═3966cebe-8aa5-4bf0-8dc2-4ad5c5ba1874
# ╟─3ea75801-d119-4ed1-86c5-b63e27e6e492
# ╠═020ae148-95e3-440b-ad3e-8651c8fe436c
# ╟─a6708af2-69b1-4732-86d1-793b179a8b83
# ╠═01ff1f86-ca11-439f-8d09-cb66146212fd
# ╠═7fdc31c4-29be-4c95-ae0d-69ebb20532c5
# ╠═0a4f7989-be08-4e2c-b33b-78f6be817f72
# ╠═865aeb46-914b-45de-866f-0edb49e42ffe
# ╠═e97ce8e6-031d-4080-b246-c4b4d0e021cf
# ╠═1efac5f5-1421-4381-b753-ba007040fb3b
# ╠═9a5b4cb6-0a08-4352-9db4-bc7cbdd73460
# ╠═ca032b9e-230b-49a9-b546-0e0748660040
# ╠═978ffc35-ad22-455d-8bef-c588d4326130
# ╠═44eb8206-0021-4227-8cfc-0d1136b10c5d
# ╠═61ed1538-f952-4f66-b541-60afea9a8826
# ╠═cc9e3e80-14d4-4116-ab53-ef8a7f0ebbd3
# ╠═95306fea-3c3b-4082-90b9-1e8ac54d5af5
# ╠═4fa5614d-1eac-4a7a-8a7a-c0e51f504be4
# ╠═5614e552-5baf-4192-b01c-835115e22e05
# ╠═22029aba-c648-4089-b7bf-c9aab92c212d
# ╠═9b21719c-2955-4e1c-97b0-8c1458ae5c5c
# ╠═eded9da5-e470-405e-bf32-186dd69752b8
# ╟─3e710fe0-a2ff-4d42-8734-41597f59fbed
# ╠═70c0ba7d-d6b4-4e1c-8095-a909a833ad7d
# ╠═c986fde7-f56f-4eea-bf28-9984ace2a580
# ╠═8927ee89-93da-49ed-83eb-645e901a36e5
# ╠═4472a8e2-52d3-4902-b076-ce862f29f663
# ╟─6f5d7f81-c900-4340-afe8-b0046c5738c8
# ╠═712e83a5-f659-4a0b-859f-48895639aba7
# ╟─5e7fc3f3-b8e7-4243-b819-e78d88d6cc96
# ╠═bffc1f11-75da-4492-80aa-7408b07e33e7
# ╠═6631ff41-9a8e-4fdf-8e0a-06866f1ae4c1
# ╠═7d4b921a-ea56-44fd-a98c-097e2268e315
# ╠═7b449582-33d1-4c6f-8378-46b92722be1b
# ╠═7c610221-9c3a-4836-a308-d407d0fe918a
# ╠═a2e2978f-1457-4a10-89d5-d39ad61a9ad0
# ╠═00c2f696-eaf7-4417-a1fd-5e1a0854a764
# ╠═7ba57322-b61a-4881-ae6d-60265feeccf6
# ╠═da9a1cf1-a538-4ade-9426-52d832c3291d
# ╠═185f79dd-c285-461c-a91a-dbaad2d41651
# ╠═e5f83fe6-4bc1-4a94-847b-e294e23b8c4f
# ╟─3da1f59e-5f8a-4298-a4a8-1788e211e146
# ╠═00ddddbb-b864-4e1e-8009-cdb90287cb81
# ╠═c6b227b7-0fd0-403f-bb4c-af35d35bc4e4
# ╠═d650355d-2f3d-45f0-9a88-299effe3667d
# ╠═2d53e3c6-0835-45cd-9796-52d262bc0d55
# ╟─abfe14e8-738a-4a1c-beb3-d3e6f0cc975f
# ╠═44480674-6e5d-430e-a7be-5f297837697d
# ╠═385ce0a2-8753-4b6e-a7c6-844107b7cbc3
# ╟─efdd4c60-0de1-4298-8ed7-7f02fe6aae3d
# ╠═bf573744-d9ec-4157-9f08-572d5289cd59
# ╠═ce57e202-3aa0-416b-9662-113d12f7ba52
# ╠═db647038-275c-4f3b-a48c-46105942318e
# ╠═01e612bd-d630-4186-8e10-da6211ab9cdb
# ╠═341f88ee-db9e-4854-8a76-9abc26bfa1d5
# ╠═06022d25-4a62-43f0-bcf6-9a0629f7d917
# ╟─07fd573e-4c43-4416-8a3f-0a0f5bf746fd
# ╠═4e90ff13-3841-481b-9a5f-1a9dfa18bfd8
# ╠═ddf22741-2fbe-46bc-abc7-052be48a5a9d
# ╠═304759c2-1322-49a0-bade-e7a2452f6774
# ╠═8cdb4671-6f71-42bf-94e9-1d31343038e5
# ╟─3631639d-e62e-4669-b6c3-7730206dfbe7
# ╠═0bc77445-062f-4b55-9a24-67b9588355b0
# ╠═a54939b5-aac8-4d76-b18b-f887973453a7
# ╟─004a465e-2c46-4869-aa9e-81073ca38999
# ╠═1de38341-0d9d-4b32-be47-2945dac2b7c6
# ╠═9b7837b3-1b41-46c9-a10f-d872f92cf184
# ╠═9ef822cc-93aa-4d10-856a-774a3318cabf
# ╠═45ecf3da-2375-4312-b440-055b7728d22b
# ╟─e36a07c1-cf62-4e65-9797-309bb6e89f93
# ╟─3fe2583c-cc43-4f87-9ea5-923d1dd5649b
# ╟─20f53637-1681-4201-9ca3-9907f6c8ae05
# ╠═b158f84c-f814-4837-915d-cbf3ffd30502
# ╠═4562f05d-21c9-490e-ba28-a70636b00d9c
# ╠═7304e21b-b117-4ce1-8105-d4d1017d9d12
# ╟─bf0667f9-1d5e-4b72-b928-2576cec79427
# ╟─82ccfffd-ed23-43c5-b083-0732d5ebf4a6
# ╠═41d813f1-f8df-475b-b487-a7b1de5f2cc8
# ╠═b1004c19-f96b-4131-808d-3c901c36bbd6
# ╟─5a558a28-95ef-4d51-ac74-a67c119118c1
# ╠═ef1fcb75-d216-4886-89b3-d556f99b5d8a
# ╟─9e4dd8e7-d7ed-4b03-9de8-c6ec3e806119
# ╠═a7682770-d6dd-4ea2-ba2f-c3056851d6f6
# ╟─2b08a987-fd65-4790-9c98-73579826e071
# ╠═ad364342-a042-49b7-a767-d4d39c128fc5
# ╟─269bb77f-c77b-4c6b-a123-cda5647b12d0
# ╠═d2344839-95e1-44ab-9470-5c14520f1b2f
# ╠═8b4e408c-891d-442d-9f66-ae710fd3620c
# ╟─45be7d9c-0fc5-456b-9957-8d5b135472a8
# ╠═edd18f49-4451-4be2-98bd-08f819c87ca3
# ╟─0b7cd85b-cf32-4ce5-981f-e801c41eecdf
# ╠═2def8fc2-0b8f-43e2-9ac4-4ac0fa4bc999
# ╟─f47e8917-eaae-4377-8873-373a5fef0537
# ╠═d5fbb6ed-8572-4d77-aeb6-52d6a281995d
# ╟─120e829a-db3e-4861-8d6c-87379d0b5072
# ╟─3c5134dc-82a4-4499-bb7e-d85efed47b13
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
