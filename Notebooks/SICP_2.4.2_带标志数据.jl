### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ ddedeb70-3b21-11ed-1278-37ba3d55e512
md"
=====================================================================================
#### [SICP\_2.4.2\_TaggedData.jl(带标志数据)](https://sarabander.github.io/sicp/html/2_002e4.xhtml#g_t2_002e4_002e2)
=====================================================================================
"

# ╔═╡ 9142ce4d-01f9-4ea9-a94c-9d857ebdabe0
md"
##### 2.4.2.1 Definition of [complex numbers](https://en.wikipedia.org/wiki/Complex_number) $$z \in \mathbb C$$ :
$$z:=x+y\,i = r\cdot cos\,\phi + r\cdot i\, sin\,\phi = r(cos\,\phi + i\, sin\,\phi) = re^{i \phi}$$

where :

$$x = Re(z) = r\cdot cos \,\phi$$
$$y = Im(z) = r\cdot sin \,\phi$$
$$\phi = arctan(Im(z)/Re(z))$$
$$|z| = r = (Re(z)^2+Im(z)^2)^{1/2}$$
$$z = r e^{i \phi}$$

The last expression uses Euler's formula for complex analysis.
"

# ╔═╡ e895bc63-c837-4512-baac-a9a48cae50cb
md"
###### [Euler's formula](https://en.wikipedia.org/wiki/Euler%27s_formula) for complex analysis is:

$$e^{i \phi} = cos\,\phi + i \,sin\,\phi,$$

Several different [proofs](https://en.wikipedia.org/wiki/Euler%27s_formula#Proofs) are known. One of the first was using the *power series expansion* of all terms in the formula.

"

# ╔═╡ 2713a735-3542-45d6-9ed3-a3aa1863902c
md"
---
##### 2.4.2.2 *Scheme-like* Julia
"

# ╔═╡ cede8129-9358-4dc4-a32e-6390af700376
md"$$
\begin{array}{|c|c|}
\hline
          &                                                \\
layer     & \text{Operations or Functions}                 \\
          &                                                \\
\hline
          &                                                \\
top       & \text{Representation-independent}              \\
(domain)  & \begin{array}{c} 
          & \hline                                         \\
          & addComplex                                     \\ 
          & subComplex                                     \\
          & mulComplex                                     \\
          & divComplex                                     \\ 
          &                                                \\
          & \hline                                         \\
          & realPartOfZ                                    \\
          & imagPartOfZ                                    \\
          & magnitudeOfZ                                   \\          
          & angleOfZ                                       \\
          &                                                \\      
          & \hline                                         \\
          & makeZFromRealImag                              \\
          & makeZFromMagAng                                \\
          & \end{array}                                    \\
          & \hline                                         \\
          & \begin{array}{c}  
          & \text{Representation-independent}              \\
          & \text{interface functions}                     \\
          &                                                \\
          & \hline                                         \\
          & attachTag                                      \\
          & typeTag                                        \\
          & contents                                       \\
          &                                                \\
          & \hline                                         \\
          & \end{array}                                    \\ 
middle    & \text{Representation-dependent}                \\
          & \text{constructors}                            \\
          &                                                \\
interface & \begin{array}{cc} 
          & \text{Rectangular} & \text{Polar}              \\
          & \hline                                         \\
          & makeZRectFromRealImag & makeZPolarFromRealImag \\ 
          & makeZRectFromMagAng   & makeZPolarFromMagAng   \\
          &                                                \\
          & \hline                                         \\
          & \end{array}                                    \\
          & \text{Representation-dependent}                \\
          & \text{predicates and selectors}                \\
          &                                                \\
          & \begin{array}{cc} 
          & \text{Rectangular}    & \text{Polar}           \\
          & \hline                                         \\
          & isRectangular         & isPolar                \\
          &                       &                        \\
          & realPartOfZRect       & realPartOfZPolar       \\ 
          & imagPartOfZRect       & imagPartOfZPolar       \\
          & magnitudeOfZRect      & magnitudeOfZPolar      \\
          & angleOfZRect          & angleOfZPolar          \\
          &                                                \\
          & \hline                                         \\
          & \end{array}                                    \\
\hline
          &                                                \\
ground    & cons                                           \\
(Scheme)  & car                                            \\
          & cdr                                            \\
          &                                                \\
\hline
basement  & \\
(Julia)   & \\
\hline
\end{array}$$
"

# ╔═╡ 9824b754-bfe4-48f4-874b-a2d0ed76172f
md"
Fig. 2.4.2.1 Data *abstraction barriers* in the complex number system

---
"

# ╔═╡ 1c736e19-1dde-496c-9d8f-991384d8d803
md"
###### Methods of Scheme-like *constructor* $$cons$$
"

# ╔═╡ 92e2404e-5606-41d9-a46c-61b76f6737b3
struct Cons
	car
	cdr
end

# ╔═╡ ee3fa2b7-ecaa-47cf-a2a4-53538dc8f2be


# ╔═╡ 7d42ab0f-b4e4-4cf3-81d7-652990d049b0
cons(car::Any, cdr::Any)::Cons = Cons(car, cdr)::Cons  

# ╔═╡ bdfa88e0-e190-4e4f-bf0e-1ba1f2f895ea
function cons(car::Any, list2::Vector)::Vector
	conslist = list2
	pushfirst!(conslist, car)
	conslist
end

# ╔═╡ f29a5d9e-66af-4f3d-b9f6-ad91f0ea735a
function cons(list1::Vector, list2::Vector)::Vector
	conslist = push!([], list1)
	for xi in list2
		push!(conslist, xi)
	end
	conslist
end

# ╔═╡ b6f35feb-67b9-42be-b172-e1a41682fd6f
md"
###### Methods of Scheme-like *selectors* $$car, cdr$$
"

# ╔═╡ 655656e1-82b9-49b3-b7d4-b12fdd7a63bf
car(cell::Cons) = cell.car

# ╔═╡ a0724486-e498-4fe6-a383-88c100e9bdbd
car(x::Vector) = x[1]

# ╔═╡ 39e8ccf2-ec2d-4b78-a272-808f0e35c20b
cdr(cell::Cons)::Any = cell.cdr

# ╔═╡ 880c3d95-67df-4ac0-a9b0-0339d2d2d461
cdr(x::Vector) = x[2:end]

# ╔═╡ 441e7db6-be23-4911-a5b7-c131c04fa0ad
md"
---
##### Representation *in*dependent interface functions
"

# ╔═╡ 97772419-99eb-4b55-b286-30e0a8141f85
md"
###### type *constructor* $$attachTag$$
"

# ╔═╡ 64b7bbd9-bdfd-40af-a37a-b5c5d9269f68
function attachTag(typeTag, contents) 
	cons(typeTag, contents) 
end # attachTag

# ╔═╡ 5f2da2ad-7b9c-4596-8a4f-42f02b29f613
md"
###### type *selectors* $$typeTag, contents$$
"

# ╔═╡ b38d31b7-070c-4248-8eb4-c03735c6f683
function typeTag(datum) 
	car(datum)
end # typeTag

# ╔═╡ 3a59f924-cbad-4238-b840-13632ecf294b
function contents(datum) 
	cdr(datum)
end # function contents

# ╔═╡ c4d952f6-f92c-4662-ba8c-6b32ab5ff54b
md"
###### predicates $$is\_rectangular, is\_polar$$
"

# ╔═╡ ada8b1db-7e7b-42f3-92bb-c1825c37cece
isRectangular(z) = typeTag(z) == :rectangular

# ╔═╡ 8d8e2bfe-16d6-4431-ac4a-cd5beefa2ad3
isPolar(z) = typeTag(z) == :polar

# ╔═╡ 1796f8d3-9faa-426d-8d22-f79269e9077f
md"
---
##### *Rectangular*-dependent functions 
(Ben's revised rectangular representation from SICP 2.4.1)

###### Selectors
$$realPartOfZRect, imagPartOfZRect,$$
$$magnitudeOfZRect, angleOfZRect$$

###### Constructors
$$makeZRectFromRealImag, makeZRectFromMagAng$$
  
"

# ╔═╡ f44475f7-c036-46fc-8c21-94b383ee90cb
md"
---
###### Selector $$realPartOfZRect$$ of complex numbers in *rectangular* form
$$realPartOfZRect: \mathbb C_{rectangular} \rightarrow \mathbb R$$

$$z_{rectangular} \mapsto Re(z)$$

"

# ╔═╡ 919cbd2a-4e66-43bb-9ff3-70e4b9694011
function realPartOfZRect(z)
	car(z)
end # function realPartOfZRect

# ╔═╡ a676d3d6-8b01-4938-a72e-770e040e2d47
md"
---
###### Selector $$imagPartOfZRect$$ of complex numbers in *rectangular* form
$$imagPartOfZRect: \mathbb C_{rectangular} \rightarrow \mathbb R$$

$$z_{rectangular} \mapsto Im(z)$$

"

# ╔═╡ a2993ced-5bd1-42c8-8642-3cd9bb32ed2c
function imagPartOfZRect(z)
	cdr(z)
end # function imagPartOfZRect

# ╔═╡ 5c72a1ab-8c0b-474e-8046-cce9041ac5dd
md"
---
###### Selector $$magnitudeOfZRect$$ of complex numbers in *rectangular* form
$$magnitudeOfZRect: \mathbb C_{rectangular} \rightarrow \mathbb R$$

$$z_{rectangular} \mapsto \rho(z)$$

"

# ╔═╡ 686de811-e42c-4c16-b609-11863c5747bb
function magnitudeOfZRect(z) 
	√(realPartOfZRect(z)^2 + imagPartOfZRect(z)^2)
end # function magnitudeOfZRect

# ╔═╡ 20d54d11-dacd-49a5-a99d-634a813efaf5
md"
---
###### Selector $$angleOfZRect$$ of complex numbers in *rectangular* form
$$angleOfZRect: \mathbb C_{rectangular} \rightarrow \mathbb R$$

$$z_{rectangular} \mapsto \theta(z)$$

"

# ╔═╡ 542f980c-9e82-4066-9dfc-a6827da9bc1b
function angleOfZRect(z) 
	atan(imagPartOfZRect(z), realPartOfZRect(z))
end # function angleOfZRect

# ╔═╡ 14e71a34-fd8b-4a5f-a0b6-0fb8a91b5bb3
md"
###### Constructor $$makeZRectFromRealImag$$ of complex numbers in *rectangular* form

$$makeZRectFromRealImag : \mathbb R \times \mathbb R \rightarrow \{:rectangular\} \times \mathbb C_{rectangular}$$

$$(Re(z), Im(z)) \mapsto (:rectangular, (Re(z), Im(z))) = (:rectangular, z_{rectangular})$$
"

# ╔═╡ b2a335da-c022-456b-815e-378b4057a4f7
function makeZRectFromRealImag(x, y)
	attachTag(:rectangular, cons(x, y))
end # function makeZRectFromRealImag

# ╔═╡ 6607d299-8d5a-4318-9aa0-d219f37d630a
md"
###### Constructor $$makeZRectFromMagAng$$ of complex numbers in *rectangular* form

$$makeZRectFromMagAng : \mathbb R \times \mathbb R \rightarrow \mathbb C_{rectangular}$$

$$(\rho(z), \theta(z)) \mapsto (:rectangular, (Re(z), Im(z)) = (:rectangular, z_{rectangular})$$
"

# ╔═╡ 898e3dda-e58e-4e8a-9d90-63b28550e62b
function makeZRectFromMagAng(r, a) 
	attachTag(:rectangular, cons(r * cos(a), r * sin(a)))
end # function makeZRectFromMagAng

# ╔═╡ 461311fe-13ac-48a2-b3e5-96dd2e0de5fe
md"
---
##### *Polar*-dependent functions 
(Alyssa's revised *polar* representation from SICP 2.4.1)

###### Selectors
$$realPartOfZPolar, imagOfZPolar,$$
$$magnitudeOfZPolar, angleOfZPolar$$

###### Constructors
$$makeZPolarFromRealImag, makeZPolarFromMagAngPolar$$
"

# ╔═╡ 8647d682-d829-4058-b068-76a6a43df6cc
md"
---
###### Selector $$realPartOfZPolar$$ of complex numbers in *polar* form
$$realPartOfZPolar: \mathbb C_{polar} \rightarrow \mathbb R$$

$$z_{polar} \mapsto Re(z)$$

"

# ╔═╡ 3d162bbe-1181-4584-bca5-0712ddb24af5
md"
---
###### Selector $$imagPartOfZPolar$$ of complex numbers in *polar* form
$$imagPartOfZPolar: \mathbb C_{polar} \rightarrow \mathbb R$$

$$z_{polar} \mapsto Im(z)$$

"

# ╔═╡ 3fae51ff-bdc1-4450-9e31-10f6ccb12a44
md"
---
###### Selector $$magnitudeOfZPolar$$ of complex numbers in *polar* form
$$magnitudeOfZPolar: \mathbb C_{polar} \rightarrow \mathbb R$$

$$z_{polar} \mapsto \rho(z)$$

"

# ╔═╡ db989f84-cc75-475a-81de-ce65e10f7816
magnitudeOfZPolar = car

# ╔═╡ 6f24b778-7aee-411c-8eb0-656e96f1750a
md"
---
###### Selector $$angleOfZPolar$$ of complex numbers in *polar* form
$$angleOfZPolar: \mathbb C_{polar} \rightarrow \mathbb R$$

$$z_{polar} \mapsto \theta(z)$$

"

# ╔═╡ cf404921-549a-4790-ab1a-a7fde59a8b13
angleOfZPolar = cdr

# ╔═╡ 3cfc17b0-631a-4926-9932-d491ba6aa8fd
function realPartOfZPolar(z) 
	magnitudeOfZPolar(z) * cos(angleOfZPolar(z))
end # function realPartOfZPolar

# ╔═╡ 8ed80416-83ac-4bf5-935e-6c066c01b2d1
function imagPartOfZPolar(z) 
	magnitudeOfZPolar(z) * sin(angleOfZPolar(z))
end # function imagPartOfZPolar

# ╔═╡ d3ca8879-6f95-4e87-a51e-e0dbcd749442
md"
---
###### Constructor $$makeZPolarFromRealImag$$ of complex number in *polar* form
$$makeZPolarFromRealImag: (\mathbb R \times \mathbb R ) \rightarrow \{:polar\} \times \mathbb C_{polar}$$

$$(Re(z), Im(z))) \mapsto (:polar, (\rho(z), \theta(z))) = (:polar, z_{polar})$$

"

# ╔═╡ ba048fdf-6ee9-4749-8110-30926ad7657f
function makeZPolarFromRealImag(x, y) 
	attachTag(:polar, cons(√(x^2 + y^2)), atan(y, x))
end # function makeZPolarFromRealImag

# ╔═╡ e9e74b2a-0e30-41d6-93c1-a7de8e6bba64
md"
---
###### Constructor $$makeZPolarFromMagAng$$ of complex number in *polar* form
$$makeZPolarFromMagAng: (\mathbb R \times \mathbb R ) \rightarrow \{:polar\} \times \mathbb C_{polar}$$

$$(\rho(z), \phi(z)) \mapsto (:polar, (\rho(z), \phi(z))) = (:polar, z_{polar})$$

" 

# ╔═╡ 268a42ba-ed7a-4103-9254-efcf8c90f854
function makeZPolarFromMagAng(r, a) 
	attachTag(:polar, cons(r, a))
end # function makeZPolarFromMagAng

# ╔═╡ a48f278f-0fd8-4d1c-8482-454a515ac212
md"
---
##### Domain (representation *in*dependent) *selectors* and *constructors* 

###### selectors  
$$realPartOfZ, imagPartOfZ, magnitudeOfZ, angleOfZ$$

###### constructors
$$makeZFromRealImag, makeZFromMagAng$$
"

# ╔═╡ 6d70c01d-fac1-497a-837f-f3d45f60b274
# 1st *untyped* method of function realPartOfZ
function realPartOfZ(z)                     
	if isRectangular(z)
		realPartOfZRect(contents(z))
	elseif isPolar(z)
		realPartOfZPolar(contents(z))
	else
		"error *untyped* realPartOfZ(z), because unknown $z"
	end
end

# ╔═╡ 2b706d93-6e07-42df-9c9b-fb2dfb89a3b1
# 1st *untyped* method of function imagPartOfZ
function imagPartOfZ(z)
	if isRectangular(z)
		imagPartOfZRect(contents(z))
	elseif isPolar(z)
		imagPartOfZPolar(contents(z))
	else
		"error *untyped* imagPartOfZ(z), because unknown $z"
	end
end

# ╔═╡ d43b2cb7-e355-42be-a13a-ce27ea385557
# 1st *untyped* method of function magnitudeOfZ
function magnitudeOfZ(z)
	if isRectangular(z)
		magnitudeOfZRect(contents(z))
	elseif isPolar(z)
		magnitudeOfZPolar(contents(z))
	else
		"error *untyped* magnitudeOfZ(z), because unknown $z"
	end
end

# ╔═╡ 69b04bd2-0640-4b3c-9d4e-8075c4298956
# 1st *untyped* method of function angleOfZ
function angleOfZ(z)
	if isRectangular(z)
		angleOfZRect(contents(z))
	elseif isPolar(z)
		angleOfZPolar(contents(z))
	else
		"error *untyped* angleOfZ(z), because unknown $z"
	end
end

# ╔═╡ 5c08fef4-c2be-459a-85bf-b1ec617c3e0f
function makeZFromRealImag(x, y)
	makeZRectFromRealImag(x, y)
end # function makeZFromRealImag

# ╔═╡ 910c5cce-4343-4763-b83d-2cddd82847cc
function makeZFromMagAng(r, a)
	makeZPolarFromMagAng(r, a)
end # function makeZFromMagAng

# ╔═╡ 556d8fb0-da21-48c6-99aa-6932995a3ff6
md"
---
##### Domain (representation *in*dependent) operations (cf. SICP 2.4.1) 
$$addComplex, subComplex, mulComplex, divComplex$$
"

# ╔═╡ f594966f-2e7c-42ab-81d0-b5360f19bf6f
md"
---
###### Addition $$addComplex$$
"

# ╔═╡ 879967a3-bc78-417a-8cc0-aaf53343d3e2
md"
---
###### Subtraction $$SubComplex$$
"

# ╔═╡ e05f131b-5c68-4974-b0cb-ec6d46871fd5
md"
---
###### Multiplication $$MulComplex$$
"

# ╔═╡ ce2e5a5b-38fc-4be6-bf5f-435ac2d90ec4
md"
---
###### Division $$divComplex$$
"

# ╔═╡ 94dbc794-5913-4cca-b4f8-796e7287ad45
md"
---
##### Test calculations of complex numbers in *rectangular* form
"

# ╔═╡ 794915a9-2d08-4e36-8e0f-f44682d2d1dc
md"
###### [*Addition*](https://www.hackmath.net/en/calculator/complex-number) based on *rectangular* coordinates
$$addComplex: ((:rectangular, z_1),(:rectangular,z_2))$$
$$= ((:rectangular, (2 + 1i)) + (:rectangular,(0.894 − 0.894i))) \mapsto  2.894 + 0.106i$$
"

# ╔═╡ 8c2cf831-4b01-4ec8-a06c-7f050cb917df
md"
###### [*Subtraction*](https://www.hackmath.net/en/calculator/complex-number) based on *rectangular* coordinates
$$subComplex: ((:rectangular, z_1),(:rectangular, z_2))$$
$$= ((:rectangular, (2 + 1i)) - (:rectangular, (0.894 − 0.894i))$$ 
$$\mapsto (2.0 - 0.894) + (1 + 0.894)i = 1.106 + 1.894i$$
"

# ╔═╡ a3c6ffd7-7bcf-4681-812c-cd2d5dbb0fed
md"
###### [*Multiplication*](https://www.hackmath.net/en/calculator/complex-number) based on *rectangular* coordinates
$$mulComplex: ((:rectangular, z_1), (:rectangular,z_2)) \mapsto (x_1+y_1i)\cdot(x_2+y_2i) =$$
$$=x_1x_2+x_1y_2i+y_1ix_2+y_1iy_2i = x_1x_2+x_1y_2i+y_1ix_2-y_1y_2 =$$
$$=(x_1x_2-y_1y_2)+(x_1y_2+y_1x_2)i$$

$$mulComplex: ((:rectangular, z_1), (:rectangular, z_2))$$
$$= ((:rectangular, (2 -1i)), (:rectangular, (2 + 2i)))$$
$$\mapsto (4 + 2) + (4 - 2)i = 6 + 2i$$
"

# ╔═╡ 5e28243b-3813-471b-83ee-924d289f7000
md"
---
##### Test calculations of complex numbers in *polar* form
"

# ╔═╡ ad49c660-bb08-44f8-a174-ca4bf1c14fe8
md"
###### [*Addition*](https://www.hackmath.net/en/calculator/complex-number) based on *polar* coordinates
$$addComplex: ((:rectangular, z_1), (:rectangular, z_2))$$
$$= (:rectangular, 2 - 1i) + (:rectangular, 2 + 2i)$$
$$= ((:polar, (2.236, -0.464i)), (:polar, (2.828, 0.785i)))  \mapsto 4 + 1i$$
"

# ╔═╡ 6a01a97b-b53b-4a90-8df4-ad1e70fe871c
md"
###### [*Subtraction*](https://www.hackmath.net/en/calculator/complex-number) based on *polar* coordinates
$$addComplex: (:rectangular, (z_1,z_2)) = (:rectangular, (2 - 1i) - (2 + 2i))$$
$$= (:polar, ((2.236, -0.464i), (2.828, 0.785i)))  \mapsto 0 - 3i$$
"

# ╔═╡ 51e0e15a-ebf8-4c13-9957-fa6fdb2271cd
md"
###### [Multiplication](https://www.hackmath.net/en/calculator/complex-number) based on *polar* coordinates

$$mulComplex : ((:polar,z_1), (:polar,z_2))$$
$$= ((:polar, (\rho(z_1),ϕ(z_1))),(:polar,(\rho(z_2), \phi(z_2))i))$$
$$\mapsto (\rho(z_1)\cdot \rho(z_2), (\phi(z_1)+\phi(z_2))i)$$
$$mulComplex : ((:polar,z_1), (:polar,z_2))$$
$$=((:polar, (2.236, -0.464)), (:polar, (2.828, 0.785)i))$$
$$\mapsto (:polar, (6.325, 0.322i)) = (4 + 2) + (4 - 2)i = 6 + 2i$$
"

# ╔═╡ 2be9faee-f977-4278-9b10-4321abf6cb26
md"
###### [*Division*](https://www.hackmath.net/en/calculator/complex-number?input=10L60) based on *polar* coordinates
$$divComplex: ((:polar, z_1), (:polar, z_2))$$
$$\mapsto (:polar,(\rho(z_1)/ \rho(z_2)),(:polar, (\theta(z_1)-\theta(z_2)))i)$$
$$divComplex: ((:rectangular, (3 - 1i)),(:rectangular,(1 + 2i)))$$
$$=((:polar, (3.163, -0.322i)), (:polar, (2.236, 1.107i)))$$ 
$$\mapsto (ρ:1.414, θ:-1.429) = 0.2 - 1.4i$$
"

# ╔═╡ 1d7edfae-9400-4911-b364-372da3b2ad25
md"
---
##### 2.4.1.2 *idiographic* Julia
"

# ╔═╡ d2344a32-eb70-4b67-b245-2d699531c5ad
struct MakeZ
	tag
	car
	cdr
end

# ╔═╡ 8e2c62ed-cfc8-40c2-9d00-ce805d193f7a
function realPartOfZ(z::MakeZ) 
	z.tag == :rect ? z.car : nothing
end # realPartOfZTag

# ╔═╡ 57de2fa2-a2a1-4251-8fa3-a7a7e1e7f1c0
function imagPartOfZ(z::MakeZ)
	z.tag == :rect ? z.cdr : nothing
end # realPartOfZ

# ╔═╡ 0f5eae24-727c-4ef9-8e38-18ee64d97229
function addComplex(z1, z2) 
	makeZFromRealImag(
		realPartOfZ(z1) + realPartOfZ(z2), 
		imagPartOfZ(z1) + imagPartOfZ(z2))
end # function addComplex

# ╔═╡ 8f80e51f-b813-4846-967c-1e101511aaef
function subComplex(z1, z2)
	makeZFromRealImag(
		realPartOfZ(z1) - realPartOfZ(z2), 
		imagPartOfZ(z1) - imagPartOfZ(z2))
end # function subComplex

# ╔═╡ a6a3e561-09f6-46d3-881b-cae773471ddc
function magnitudeFromRectZ(z::MakeZ) 
	√(realPartOfZ(z)^2 + imagPartOfZ(z)^2)
end # function magnitudeFromRectZ

# ╔═╡ 575e199c-3f3a-4b8e-97e9-9663966e935f
function angleFromRectZ(z::MakeZ) 
	atan(imagPartOfZ(z), realPartOfZ(z))
end # function angleFromRectZ

# ╔═╡ c4161ef8-6560-4cae-95a7-e95141f5ce88
z1 = MakeZ(:rect, 2, 1)

# ╔═╡ 7fbb4a0b-85c3-49f4-9290-8ced8655311d
realPartOfZ(z1)

# ╔═╡ d4830325-c22b-4fb9-8728-06b808d94366
imagPartOfZ(z1)

# ╔═╡ 5c88f889-03d5-4c16-8451-7b6903e3e8e1
function magnitudeOfZ(z::MakeZ)
	if z.tag == :rect
		magnitudeFromRectZ(z)
	elseif z.tag == :polar
		z.car
	else
		"error magnitudeOfZ(z), because unknown $z"
	end
end

# ╔═╡ d94f4d43-9aee-4f9d-8fa7-ad307783913c
let
	z1 = makeZFromRealImag(2, 1)
	z2 = makeZFromRealImag(
		realPartOfZ(z1)/magnitudeOfZ(z1), 
		-2*imagPartOfZ(z1)/magnitudeOfZ(z1))
	z3 = addComplex(z1, z2)
end # let

# ╔═╡ 1ae2d086-2170-4c33-a3f3-38fd5d330dd6
let
	z1 = makeZFromRealImag(2, 1)
	z2 = makeZFromRealImag(
		realPartOfZ(z1)/magnitudeOfZ(z1), 
		-2*imagPartOfZ(z1)/magnitudeOfZ(z1))
	z3 = subComplex(z1, z2)
end # let

# ╔═╡ 686f53b5-5f31-4240-a340-d1c3dd110c69
function angleOfZ(z::MakeZ)
	if z.tag == :rect
		angleFromRectZ(z)
	elseif z.tag == :polar
		z.cdr
	else
		"error angleOfZ(z), because unknown $z"
	end
end

# ╔═╡ b9dc12c1-6e1b-4d1a-8629-f937e9174e61
function mulComplex(z1, z2)
	makeZFromMagAng(
		magnitudeOfZ(z1) * magnitudeOfZ(z2), 
		angleOfZ(z1) + angleOfZ(z2))
end # function mulComplex

# ╔═╡ d4d1ae65-9b38-4600-a33c-a3668f822c77
function divComplex(z1, z2)
	makeZFromMagAng(
		magnitudeOfZ(z1) / magnitudeOfZ(z2), 
		angleOfZ(z1) - angleOfZ(z2))
end # function divComplex

# ╔═╡ b937d6de-4b48-450e-9258-d95e14a66210
let
	z1 = makeZFromRealImag(2, -1)
	z2 = makeZFromRealImag(2,  2)
	z3 = mulComplex(z1, z2)
	z4 = makeZRectFromMagAng(magnitudeOfZ(z3), angleOfZ(z3))
end # let

# ╔═╡ 45a3a57c-45da-481f-ba63-362e13e4cd62
let
	z1Rect  = makeZFromRealImag(2, -1)
	z1Polar = makeZFromMagAng(magnitudeOfZ(z1Rect), angleOfZ(z1Rect)) 
	z2Rect  = makeZFromRealImag(2,  2)
	z2Polar = makeZFromMagAng(magnitudeOfZ(z2Rect), angleOfZ(z2Rect))
	z3Rect  = addComplex(z1Polar, z2Polar)
end # let

# ╔═╡ d0558288-c847-4805-b505-b79bdd5abefe
let
	z1Rect  = makeZFromRealImag(2, -1)
	z1Polar = makeZFromMagAng(magnitudeOfZ(z1Rect), angleOfZ(z1Rect)) 
	z2Rect  = makeZFromRealImag(2,  2)
	z2Polar = makeZFromMagAng(magnitudeOfZ(z2Rect), angleOfZ(z2Rect))
	z3Rect  = subComplex(z1Polar, z2Polar)
end # let

# ╔═╡ 2139e116-17cf-446c-a946-e76a2e8b8ecc
let
	z1Rect  = makeZFromRealImag(2, -1)
	z1Polar = makeZFromMagAng(magnitudeOfZ(z1Rect), angleOfZ(z1Rect)) 
	z2Rect  = makeZFromRealImag(2,  2)
	z2Polar = makeZFromMagAng(magnitudeOfZ(z2Rect), angleOfZ(z2Rect))
	z3Polar = mulComplex(z1Polar, z2Polar)
	makeZRectFromMagAng(magnitudeOfZ(z3Polar), angleOfZ(z3Polar))
end # let

# ╔═╡ 6663aed0-84e1-49a9-a84c-b89e5775a36b
let
	z1Rect  = makeZFromRealImag(3, -1)
	z1Polar = makeZFromMagAng(magnitudeOfZ(z1Rect), angleOfZ(z1Rect)) 
	z2Rect  = makeZFromRealImag(1,  2)
	z2Polar = makeZFromMagAng(magnitudeOfZ(z2Rect), angleOfZ(z2Rect))
	z3Polar = divComplex(z1Polar, z2Polar)
	makeZRectFromMagAng(magnitudeOfZ(z3Polar), angleOfZ(z3Polar))
end # let

# ╔═╡ 443ade8f-a0ad-41b5-ad7d-2d5569c3978e
md"
---
###### Addition based on *rectangular* coordinates
"

# ╔═╡ eb6dfeab-eb5e-42e5-80f7-f9b25d5baf57
let
	z1 = MakeZ(:rect, 2, 1)
	z2 = MakeZ(
		:rect,
		realPartOfZ(z1)/magnitudeOfZ(z1), 
		-2*imagPartOfZ(z1)/magnitudeOfZ(z1))
	z3 = addComplex(z1, z2)
end # let

# ╔═╡ 3ad451a6-c59f-4972-aa42-92517f3b5e2e
md"
---
###### Subtraction based on *rectangular* coordinates
"

# ╔═╡ 3bf2e567-b826-4511-b059-fcdf8d746533
let
	z1 = MakeZ(:rect, 2, 1)
	z2 = MakeZ(
		:rect,
		realPartOfZ(z1)/magnitudeOfZ(z1), 
		-2*imagPartOfZ(z1)/magnitudeOfZ(z1))
	z3 = subComplex(z1, z2)
end # let

# ╔═╡ 1b3e19e4-a044-4279-9a38-1434127404f6
md"
###### Multiplication based on *rectangular* coordinates
"

# ╔═╡ 988cffd5-9563-40d7-9fc5-8110591b991f
let
	z1 = MakeZ(:rect, 2, -1)
	z2 = MakeZ(:rect, 2,  2)
	z3 = mulComplex(z1, z2)
	z4 = makeZRectFromMagAng(magnitudeOfZ(z3), angleOfZ(z3))
end # let

# ╔═╡ 396c5568-c44d-4603-9809-7c556b9040e1
md"
###### Division based on *rectangular* coordinates
"

# ╔═╡ 600cd106-06fc-46db-b788-d1841d95c928
let
	z1 = MakeZ(:rect, 3, -1)
	z2 = MakeZ(:rect, 1,  2)
	z3 = divComplex(z1, z2)
	z4 = makeZRectFromMagAng(magnitudeOfZ(z3), angleOfZ(z3))
end # let

# ╔═╡ 3e6a4672-edf0-421e-a2c7-14eb99a85097
md"
---
##### References

- **Abelson, H., Sussman, G.J. & Sussman, J.**; Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/09/23
- **Feynman, R.P.**; The Feynman Lectures on Physics. Vol. I. Addison-Wesley, 1977.
- **Wikipedia**, Euler's formula, [https://en.wikipedia.org/wiki/Euler%27s_formula](https://en.wikipedia.org/wiki/Euler%27s_formula), last visit 2022/10/09
- **Wikipedia**, Euler's identity, [https://en.wikipedia.org/wiki/Euler%27s_identity](https://en.wikipedia.org/wiki/Euler%27s_identity), last visit 2022/10/06
"

# ╔═╡ 3b0945de-e1bb-4435-a07e-c647619e6c2f
md"
---
###### end of ch 2.3.4

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
# ╟─ddedeb70-3b21-11ed-1278-37ba3d55e512
# ╟─9142ce4d-01f9-4ea9-a94c-9d857ebdabe0
# ╟─e895bc63-c837-4512-baac-a9a48cae50cb
# ╟─2713a735-3542-45d6-9ed3-a3aa1863902c
# ╟─cede8129-9358-4dc4-a32e-6390af700376
# ╟─9824b754-bfe4-48f4-874b-a2d0ed76172f
# ╟─1c736e19-1dde-496c-9d8f-991384d8d803
# ╠═92e2404e-5606-41d9-a46c-61b76f6737b3
# ╠═ee3fa2b7-ecaa-47cf-a2a4-53538dc8f2be
# ╠═7d42ab0f-b4e4-4cf3-81d7-652990d049b0
# ╠═bdfa88e0-e190-4e4f-bf0e-1ba1f2f895ea
# ╠═f29a5d9e-66af-4f3d-b9f6-ad91f0ea735a
# ╟─b6f35feb-67b9-42be-b172-e1a41682fd6f
# ╠═655656e1-82b9-49b3-b7d4-b12fdd7a63bf
# ╠═a0724486-e498-4fe6-a383-88c100e9bdbd
# ╠═39e8ccf2-ec2d-4b78-a272-808f0e35c20b
# ╠═880c3d95-67df-4ac0-a9b0-0339d2d2d461
# ╟─441e7db6-be23-4911-a5b7-c131c04fa0ad
# ╟─97772419-99eb-4b55-b286-30e0a8141f85
# ╠═64b7bbd9-bdfd-40af-a37a-b5c5d9269f68
# ╟─5f2da2ad-7b9c-4596-8a4f-42f02b29f613
# ╠═b38d31b7-070c-4248-8eb4-c03735c6f683
# ╠═3a59f924-cbad-4238-b840-13632ecf294b
# ╟─c4d952f6-f92c-4662-ba8c-6b32ab5ff54b
# ╠═ada8b1db-7e7b-42f3-92bb-c1825c37cece
# ╠═8d8e2bfe-16d6-4431-ac4a-cd5beefa2ad3
# ╟─1796f8d3-9faa-426d-8d22-f79269e9077f
# ╟─f44475f7-c036-46fc-8c21-94b383ee90cb
# ╠═919cbd2a-4e66-43bb-9ff3-70e4b9694011
# ╟─a676d3d6-8b01-4938-a72e-770e040e2d47
# ╠═a2993ced-5bd1-42c8-8642-3cd9bb32ed2c
# ╟─5c72a1ab-8c0b-474e-8046-cce9041ac5dd
# ╠═686de811-e42c-4c16-b609-11863c5747bb
# ╟─20d54d11-dacd-49a5-a99d-634a813efaf5
# ╠═542f980c-9e82-4066-9dfc-a6827da9bc1b
# ╟─14e71a34-fd8b-4a5f-a0b6-0fb8a91b5bb3
# ╠═b2a335da-c022-456b-815e-378b4057a4f7
# ╟─6607d299-8d5a-4318-9aa0-d219f37d630a
# ╠═898e3dda-e58e-4e8a-9d90-63b28550e62b
# ╟─461311fe-13ac-48a2-b3e5-96dd2e0de5fe
# ╟─8647d682-d829-4058-b068-76a6a43df6cc
# ╠═3cfc17b0-631a-4926-9932-d491ba6aa8fd
# ╟─3d162bbe-1181-4584-bca5-0712ddb24af5
# ╠═8ed80416-83ac-4bf5-935e-6c066c01b2d1
# ╟─3fae51ff-bdc1-4450-9e31-10f6ccb12a44
# ╠═db989f84-cc75-475a-81de-ce65e10f7816
# ╟─6f24b778-7aee-411c-8eb0-656e96f1750a
# ╠═cf404921-549a-4790-ab1a-a7fde59a8b13
# ╟─d3ca8879-6f95-4e87-a51e-e0dbcd749442
# ╠═ba048fdf-6ee9-4749-8110-30926ad7657f
# ╟─e9e74b2a-0e30-41d6-93c1-a7de8e6bba64
# ╠═268a42ba-ed7a-4103-9254-efcf8c90f854
# ╟─a48f278f-0fd8-4d1c-8482-454a515ac212
# ╠═6d70c01d-fac1-497a-837f-f3d45f60b274
# ╠═2b706d93-6e07-42df-9c9b-fb2dfb89a3b1
# ╠═d43b2cb7-e355-42be-a13a-ce27ea385557
# ╠═69b04bd2-0640-4b3c-9d4e-8075c4298956
# ╠═5c08fef4-c2be-459a-85bf-b1ec617c3e0f
# ╠═910c5cce-4343-4763-b83d-2cddd82847cc
# ╟─556d8fb0-da21-48c6-99aa-6932995a3ff6
# ╟─f594966f-2e7c-42ab-81d0-b5360f19bf6f
# ╠═0f5eae24-727c-4ef9-8e38-18ee64d97229
# ╟─879967a3-bc78-417a-8cc0-aaf53343d3e2
# ╠═8f80e51f-b813-4846-967c-1e101511aaef
# ╟─e05f131b-5c68-4974-b0cb-ec6d46871fd5
# ╠═b9dc12c1-6e1b-4d1a-8629-f937e9174e61
# ╟─ce2e5a5b-38fc-4be6-bf5f-435ac2d90ec4
# ╠═d4d1ae65-9b38-4600-a33c-a3668f822c77
# ╟─94dbc794-5913-4cca-b4f8-796e7287ad45
# ╟─794915a9-2d08-4e36-8e0f-f44682d2d1dc
# ╠═d94f4d43-9aee-4f9d-8fa7-ad307783913c
# ╟─8c2cf831-4b01-4ec8-a06c-7f050cb917df
# ╠═1ae2d086-2170-4c33-a3f3-38fd5d330dd6
# ╟─a3c6ffd7-7bcf-4681-812c-cd2d5dbb0fed
# ╠═b937d6de-4b48-450e-9258-d95e14a66210
# ╟─5e28243b-3813-471b-83ee-924d289f7000
# ╟─ad49c660-bb08-44f8-a174-ca4bf1c14fe8
# ╠═45a3a57c-45da-481f-ba63-362e13e4cd62
# ╟─6a01a97b-b53b-4a90-8df4-ad1e70fe871c
# ╠═d0558288-c847-4805-b505-b79bdd5abefe
# ╟─51e0e15a-ebf8-4c13-9957-fa6fdb2271cd
# ╠═2139e116-17cf-446c-a946-e76a2e8b8ecc
# ╟─2be9faee-f977-4278-9b10-4321abf6cb26
# ╠═6663aed0-84e1-49a9-a84c-b89e5775a36b
# ╟─1d7edfae-9400-4911-b364-372da3b2ad25
# ╠═d2344a32-eb70-4b67-b245-2d699531c5ad
# ╠═8e2c62ed-cfc8-40c2-9d00-ce805d193f7a
# ╠═57de2fa2-a2a1-4251-8fa3-a7a7e1e7f1c0
# ╠═a6a3e561-09f6-46d3-881b-cae773471ddc
# ╠═575e199c-3f3a-4b8e-97e9-9663966e935f
# ╠═c4161ef8-6560-4cae-95a7-e95141f5ce88
# ╠═7fbb4a0b-85c3-49f4-9290-8ced8655311d
# ╠═d4830325-c22b-4fb9-8728-06b808d94366
# ╠═5c88f889-03d5-4c16-8451-7b6903e3e8e1
# ╠═686f53b5-5f31-4240-a340-d1c3dd110c69
# ╟─443ade8f-a0ad-41b5-ad7d-2d5569c3978e
# ╠═eb6dfeab-eb5e-42e5-80f7-f9b25d5baf57
# ╟─3ad451a6-c59f-4972-aa42-92517f3b5e2e
# ╠═3bf2e567-b826-4511-b059-fcdf8d746533
# ╟─1b3e19e4-a044-4279-9a38-1434127404f6
# ╠═988cffd5-9563-40d7-9fc5-8110591b991f
# ╟─396c5568-c44d-4603-9809-7c556b9040e1
# ╠═600cd106-06fc-46db-b788-d1841d95c928
# ╟─3e6a4672-edf0-421e-a2c7-14eb99a85097
# ╟─3b0945de-e1bb-4435-a07e-c647619e6c2f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
