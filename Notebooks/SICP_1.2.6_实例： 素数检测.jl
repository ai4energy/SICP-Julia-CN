### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ fcaf83d0-f611-11eb-1bc9-31384cf290cb
md"
==================================================================================
### SICP: [1.2.6 Example Testing for Primality（实例： 素数检测）](https://sarabander.github.io/sicp/html/1_002e2.xhtml#g_t1_002e2_002e6)
==================================================================================
"

# ╔═╡ 35a00708-a1ff-4b0c-a4eb-50452e394e06
md"
#### 1.2.6.1 SICP-Scheme-like *functional* Julia
"

# ╔═╡ 1b2fd7c4-5ad0-408d-94f4-79c36a1aa920
md"
###### Searching for Divisors
"

# ╔═╡ 66a32388-59bf-4cda-946d-a299487c8760
^(3, 3)              # prefix exponential operator '^'

# ╔═╡ da94c3aa-381d-4604-bdd8-298f74ccd998
square(x) = ^(x, 2)  # prefix exponential operator '^'

# ╔═╡ 9c285b06-df28-411b-9222-f6089ac42729
square(3)

# ╔═╡ 6dce0f0d-290f-429b-8c4d-d9a3e9ea5357
square(11)

# ╔═╡ 22f5327d-b4ea-4eae-badb-cf8a139b4bd3
square(3.)

# ╔═╡ 038c0c86-ec82-4f7d-a271-a06490995528
%(3, 9)      

# ╔═╡ 3107665f-2e0e-493e-aec8-e536ccea0492
%(9, 3)  

# ╔═╡ fc40132c-b9b4-4c04-a67a-88f382482189
%(13, 9)

# ╔═╡ c14293eb-0a71-4e59-8a85-d65354ca1db0
%(9, 13)

# ╔═╡ 9b30ad81-9829-48f6-b125-9a61ee3bcc05
%(13.0, 9.0)

# ╔═╡ 4c9de0d0-dd9d-4371-9a1b-9523d641ad32
%(9.0, 13.0)

# ╔═╡ 659319aa-92f4-4480-9689-465c3e04afa4
# idiomatic Julia-code '%'
remainder = %

# ╔═╡ 452f1c9a-d2b5-46bf-adcc-af9f80b62d68
divides(a, b) = ==(remainder(b, a), 0)

# ╔═╡ 19cf97ec-4c9a-4069-9dce-fa265bb904e5
divides(3, 9)

# ╔═╡ d56f43ca-11dc-491f-b6ad-f332a2e2731c
divides(3, 10)

# ╔═╡ e78e17f2-c9fa-4f5b-aefc-8c3e580f117f
function find_divisor(n, test_divisor)
	if >(square(test_divisor), n)
		n
	elseif divides(test_divisor, n)
		test_divisor
	else 
		find_divisor(n, +(test_divisor, 1))
	end # if
end # function find_divisor

# ╔═╡ afcd5e13-b61a-491a-bf4f-47ea59fe112d
smallest_divisor(n) = find_divisor(n, 2)

# ╔═╡ db02e8a1-4131-4c0f-9975-6223dafd1631
md"
###### 1st *untyped* (default) method of function 'isprime'
"

# ╔═╡ 768cc486-5e6e-4ce1-bf2c-a35151a4793f
isprime(n) = ==(n, smallest_divisor(n)) 

# ╔═╡ dac9cfc1-6b2d-4458-82a6-cf9e2c79fcc1
isprime(1) # if isprime(1) == true, then this is correct

# ╔═╡ b5b5a466-e78e-49c0-8ee9-765644596e27
isprime(2) # if isprime(2) == true, then this is correct

# ╔═╡ 56beed19-5ee7-458b-bd50-3afb9e38e342
isprime(3) # if isprime(3) == true, then this is correct

# ╔═╡ a344aaaa-af28-4345-8e96-a6b735fb6023
isprime(4) # if isprime(4) == false, then this is correct

# ╔═╡ eb89783e-e948-42d8-b7d5-857a719da9b4
isprime(5) # if isprime(5) == true, then this is correct

# ╔═╡ 2754573a-24ea-4a7b-85c3-303004aec2e2
isprime(6) # if isprime(6) == false, then this is correct

# ╔═╡ 6bd55608-02f5-4b95-8ad9-597abdf106b6
md"
###### The [First 100,008 Primes](https://primes.utm.edu/lists/small/100000.txt)
"

# ╔═╡ 4d06eb30-b117-4b02-b04c-6c459a73bcd8
isprime(99989)  # if isprime(99989) == true, then this is correct

# ╔═╡ 33fb902c-bece-4876-a731-3eaf7ffe2ff4
isprime(99991)  # if isprime(99991) == true, then this is correct

# ╔═╡ 9bc0eb42-79b0-4d7b-b472-07abae671439
isprime(99993)  # if isprime(99993) == false, then this is correct

# ╔═╡ 57187f78-2aeb-4284-90da-b529a298eb91
isprime(100003) # if isprime(100003) == true, then this is correct

# ╔═╡ 8d69e081-99d6-404a-805a-5d12821c5f5a
md"
###### [Carmichael numbers](https://en.wikipedia.org/wiki/Carmichael_number) (= [Fermat *pseudo*primes](https://en.wikipedia.org/wiki/Fermat_pseudoprime))
A Carmichael number will pass a Fermat primality test to every base b relatively prime to the number, even though it is not actually prime.
"

# ╔═╡ 6a7a2391-9cbc-44ef-83f8-5252c1454ac2
md"
###### 1st Carmichael number
"

# ╔═╡ fa620300-3307-4bda-97de-1c49fbf58d61
isprime(561)   # 1st Carmichael number: if isprime(561) == false, then this is correct

# ╔═╡ b5278a66-dbca-44d0-96ad-bd8e24e90ee3
md"
###### 2nd Carmichael number
"

# ╔═╡ 81147945-ae09-4fa3-a9ef-288a8c42744e
isprime(1105)  # 2nd Carmichael number: if prime1(1105) == false, then this is correct

# ╔═╡ e555ade7-e8f8-4158-8b68-0af132d8861a
md"
###### 3rd Carmichael number
"

# ╔═╡ a37e9857-fc51-4fdc-b8a5-50f6607f52bf
isprime(1729)  # 3rd Carmichael number: if prime1(1729) == false, then this is correct

# ╔═╡ d641ab56-f97a-4cab-820d-2d1ce7b3c546
md"
###### 4th Carmichael number
"

# ╔═╡ 04a9798b-fc72-455e-be71-62842167b292
isprime(2465)  # 4th Carmichael number: if prime1(2465) == false, then this is correct

# ╔═╡ 1c6fbf70-c098-44cc-ac84-28acc220da7d
md"
###### 5th Carmichael number
"

# ╔═╡ af7c8d34-5bf3-4e5a-851e-4b7d13b5f6b4
isprime(2821)   # if prime1(2821) == false, then this is correct

# ╔═╡ 8cec6bc7-37fd-43b0-81de-863d6a93e153
md"
###### 6th Carmichael number
"

# ╔═╡ 28eca35a-ff7a-4f07-84dd-08d8329f8fd2
isprime(6601)   # if prime1(6601) == false, then this is correct

# ╔═╡ 9979c1e4-349b-4e0a-87a0-39de45ecdf4c
function isprime2(n) 
	#-------------------------------------------
	remainder = %          # idiomatic Julia '%'
	#-------------------------------------------
	square(x) = ^(x, 2)    # infix operator '^'
	#-------------------------------------------
	divides(a, b) = ==(remainder(b, a), 0)
	#-------------------------------------------
	smallest_divisor() = find_divisor(2)
	#-----------------------------------------------------------------------------
	function find_divisor(test_divisor)  
		>(square(test_divisor), n) ? 
			n : 
			divides(test_divisor, n) ? 
				test_divisor : 
				find_divisor(+(test_divisor, 1))
	end # function find_divisor
	#-----------------------------------------------------------------------------
	n == smallest_divisor() 
end # function isprime2

# ╔═╡ e6ac837a-adc0-4114-9b09-edb43ab4d5bb
isprime2(1)

# ╔═╡ c5ed48aa-74b8-4a68-958f-10aca604ea5b
isprime2(2)

# ╔═╡ dca62763-1e1d-48c8-97dc-bc47bca6f2d3
isprime2(3)

# ╔═╡ 692e04a0-ea2c-4ce4-bee2-2d3d4736259b
isprime2(4)

# ╔═╡ df838016-92fc-4255-be0a-85fb0990bce7
isprime2(5)

# ╔═╡ cb61b117-245b-4845-808c-70deb40f7061
isprime2(6)

# ╔═╡ 218cc9d7-3c37-44a6-82b8-fecdf8e6fc02
isprime2(99989)  # if isprime2(99989) == true, then this is correct

# ╔═╡ d803272a-0090-495d-93a2-d56d2d9b6858
isprime2(99991)  # if isprime2(99991) == true, then this is correct

# ╔═╡ 23cdee96-73a6-4bdc-ba7d-627f84821ea5
isprime2(99993)  # if isprime2(99993) == false, then this is correct

# ╔═╡ 01ba9d22-919c-4887-919e-88dcfbc7a03c
isprime2(100003) # if isprime2(100003) == true, then this is correct

# ╔═╡ ee9d4319-5a11-49be-95e1-c96afcf55cd3
isprime2(561)  # 1st Carmichael number: if isprime2(561) == false, then it's correc

# ╔═╡ fb5e356e-8432-4457-acb4-ac8259084bbf
isprime2(1105) # 2nd Carmichael number: if isprime2(1105) == false, then it's correct

# ╔═╡ f73daf95-cc3f-4e98-92b2-447a53c9c36b
isprime2(1729) # 3rd Carmichael number: if isprime2(1729) == false, then it's correct

# ╔═╡ 736c7740-17e4-47ac-953c-055729365ca3
isprime2(2465) # 4th Carmichael number: if isprime2(2465) == false, then it's correct

# ╔═╡ d503f9c8-c168-4f90-9a73-af09fedf3cb1
isprime2(2821) # 5th Carmichael number: if prime2(2821) == false, then it's correct

# ╔═╡ 2c0ad9d5-fde0-495f-9c2e-953312ea2902
isprime2(6601) # 6th Carmichael number: if prime2(6601) == false, then this is correct

# ╔═╡ 295d258d-3633-4c3f-acf4-f277679e4d2a
md"
---
#### 1.2.6.2 Julia风格
"

# ╔═╡ 36ccf5f4-2106-4055-a255-457fe6e88185
# 'n' in local functions suppressed (but not in divides)
function isprime3(n::Signed)::Bool
	#-----------------------------------------------------------
	divides(a, b) = %(b, a) == 0 
	#-----------------------------------------------------------
	smallest_divisor()::Signed = find_divisor(2)::Signed
	#-----------------------------------------------------------
	function find_divisor(test_divisor::Signed)::Signed  
	  while !((test_divisor^2 > n) || divides(test_divisor, n))
			test_divisor += 1
	  end # while
	  (test_divisor^2 > n) ? 
	  		n : 
	  		test_divisor
	end # function find_divisor
	#-----------------------------------------------------------
	n == smallest_divisor()::Signed
end # function isprime3

# ╔═╡ dcb6c753-3b16-4283-b445-86d1d8b97597
isprime3(1)

# ╔═╡ 982407df-7197-4999-a674-fdfb17cacd4a
isprime3(2)

# ╔═╡ 5a5c83a9-6916-4aeb-901a-42485cde0798
isprime3(3)

# ╔═╡ 03af5d66-77d1-4a7c-bba6-6982ddef3595
isprime3(4)

# ╔═╡ 74025279-68a4-4370-81f2-d68cf8002505
isprime3(5)

# ╔═╡ d226bb12-6728-471b-8281-4e6d22e2c75a
isprime3(6)

# ╔═╡ e4bfcf03-0fed-489e-b582-d63eb339651e
isprime3(99989)  # if isprime3(99989) == true, then this is correct

# ╔═╡ 85683cc3-a96a-40e5-9136-7e954bca0be7
isprime3(99991)  # if isprime3(99991) == true, then this is correct

# ╔═╡ bbc0425b-076b-4a5a-8fce-853845c5a26e
isprime3(99993)  # if isprime3(99993) == false, then this is correct

# ╔═╡ e7e74706-cdf4-46d0-945d-807e0d13312c
isprime3(100003) # if isprime3(100003) == true, then this is correct

# ╔═╡ db83f1d3-97e3-45a1-96a3-1a4b9b6405ce
isprime3(561)   # 1st Carmichael number: if isprime3(.) == false then this is correct

# ╔═╡ b8ab2995-8100-484d-b0d1-1bf82d19578d
isprime3(1105)  # 2nd Carmichael number: if isprime3(.) == false then this is correct

# ╔═╡ eabaf84f-c090-4886-9d5c-3c782d15dc2b
isprime3(1729)  # 3rd Carmichael number: if isprime3(.) == false then this is correct

# ╔═╡ 1b6d281e-4aa5-4090-80ee-4e63a019a00e
isprime3(2465)  # 4th Carmichael number: if isprime3(.) == false then this is correct

# ╔═╡ 353f4f01-149f-49c9-9711-98eaf538c7e8
isprime3(2821)  # 5th Carmichael number: if isprime3(.) == false then this is correct

# ╔═╡ f083a864-54d4-4b0e-8e15-b07a4b29b612
isprime3(6601)  # 6th Carmichael number: if isprime3(.) == false then this is correct

# ╔═╡ 33d30399-c21b-4946-9a5e-4cebf1937082
md"
###### ..with types Signed, Bool, '%', 'let', 'for', '^2', and 'break'
"

# ╔═╡ c665c4fe-4061-4da1-a324-a43c126db248
√110

# ╔═╡ 7ca56b5e-2662-44fd-9451-d13dd5b69164
Int

# ╔═╡ 99ce7b3d-0f79-4495-a786-b42fa173e992
round(Int, √2)

# ╔═╡ 45301594-f549-4897-bb87-8b78e7778746
round(Int, √3)

# ╔═╡ aa546fa7-be8b-4768-9198-0e16bde99e46
round(Int, √4)

# ╔═╡ 00b9a040-f24a-4c9a-b0ae-3896b994343d
round(Int, √110)

# ╔═╡ 4eb6cc09-f864-4a80-9d8d-a03a08e0f97e
let count = 0
	for i = 1:100
		count = i
		i > 5 && break # if ... then ...
	end # for
	count
end # let

# ╔═╡ 4041a808-def2-4ce7-9f35-ff9b10abe2f7
md"
###### 2nd *typed* (specialized) method of function 'isprime'
"

# ╔═╡ 2beafb91-5227-45eb-bb09-138128713268
# 'n' in local functions suppressed (but not in divides)
function isprime4(n::Signed)::Bool
	#------------------------------------------------------
	divides(a::Signed, b::Signed)::Bool = %(b, a) == 0 
	#------------------------------------------------------
	function smallest_divisor()::Signed
		test_divisor = 2
		for i = 2:round(Int,√n)
			test_divisor = i
			divides(test_divisor, n) && break
		end # for
		divides(test_divisor, n) ? test_divisor : n
	end # function smallest_divisor
	#------------------------------------------------------
	n == smallest_divisor() 
end # function isprime4

# ╔═╡ 661fdf22-22f5-4b7f-aec4-04422ec3c50d
isprime4(1)

# ╔═╡ 00a795d7-fe31-4568-b53a-7511052e6e06
isprime4(2)

# ╔═╡ 83a17a23-8486-476b-9b2d-fd6203c03ff9
isprime4(3)

# ╔═╡ 2885dc3c-e984-4008-a153-e4a438e398d8
isprime4(4)

# ╔═╡ af776524-b603-408b-966e-6d7b2d462f73
isprime4(5)

# ╔═╡ 3048bc35-c1ed-44fd-b761-7a0f7b65ac67
isprime4(6)

# ╔═╡ b7aa0853-2b58-4689-b0a2-bc601cff7174
isprime4(99989)  # if isprime4(99989) == true, then this is correct

# ╔═╡ ef11bdd6-ac98-4f26-afa7-142dae6a214a
isprime4(99991)  # if isprime4(99991) == true, then this is correct

# ╔═╡ 64f76aea-c240-45d2-b146-42007a18ae89
isprime4(99993)  # if isprime4(99993) == false, then this is correct

# ╔═╡ 03a54358-3228-48f2-a4d6-5598704b5df6
isprime4(100003) # if isprime4(100003) == true, then this is correct

# ╔═╡ 5889eede-0150-476a-a0d1-7298b616172f
md"
---
##### References
- **Abelson, H., Sussman, G.J. & Sussman, J.**, Structure and Interpretation of Computer Programs, Cambridge, Mass.: MIT Press, (2/e), 1996, [https://sarabander.github.io/sicp/](https://sarabander.github.io/sicp/), last visit 2022/08/24

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
# ╟─fcaf83d0-f611-11eb-1bc9-31384cf290cb
# ╟─35a00708-a1ff-4b0c-a4eb-50452e394e06
# ╟─1b2fd7c4-5ad0-408d-94f4-79c36a1aa920
# ╠═66a32388-59bf-4cda-946d-a299487c8760
# ╠═da94c3aa-381d-4604-bdd8-298f74ccd998
# ╠═9c285b06-df28-411b-9222-f6089ac42729
# ╠═6dce0f0d-290f-429b-8c4d-d9a3e9ea5357
# ╠═22f5327d-b4ea-4eae-badb-cf8a139b4bd3
# ╠═038c0c86-ec82-4f7d-a271-a06490995528
# ╠═3107665f-2e0e-493e-aec8-e536ccea0492
# ╠═fc40132c-b9b4-4c04-a67a-88f382482189
# ╠═c14293eb-0a71-4e59-8a85-d65354ca1db0
# ╠═9b30ad81-9829-48f6-b125-9a61ee3bcc05
# ╠═4c9de0d0-dd9d-4371-9a1b-9523d641ad32
# ╠═452f1c9a-d2b5-46bf-adcc-af9f80b62d68
# ╠═659319aa-92f4-4480-9689-465c3e04afa4
# ╠═19cf97ec-4c9a-4069-9dce-fa265bb904e5
# ╠═d56f43ca-11dc-491f-b6ad-f332a2e2731c
# ╠═afcd5e13-b61a-491a-bf4f-47ea59fe112d
# ╠═e78e17f2-c9fa-4f5b-aefc-8c3e580f117f
# ╟─db02e8a1-4131-4c0f-9975-6223dafd1631
# ╠═768cc486-5e6e-4ce1-bf2c-a35151a4793f
# ╠═dac9cfc1-6b2d-4458-82a6-cf9e2c79fcc1
# ╠═b5b5a466-e78e-49c0-8ee9-765644596e27
# ╠═56beed19-5ee7-458b-bd50-3afb9e38e342
# ╠═a344aaaa-af28-4345-8e96-a6b735fb6023
# ╠═eb89783e-e948-42d8-b7d5-857a719da9b4
# ╠═2754573a-24ea-4a7b-85c3-303004aec2e2
# ╟─6bd55608-02f5-4b95-8ad9-597abdf106b6
# ╠═4d06eb30-b117-4b02-b04c-6c459a73bcd8
# ╠═33fb902c-bece-4876-a731-3eaf7ffe2ff4
# ╠═9bc0eb42-79b0-4d7b-b472-07abae671439
# ╠═57187f78-2aeb-4284-90da-b529a298eb91
# ╟─8d69e081-99d6-404a-805a-5d12821c5f5a
# ╟─6a7a2391-9cbc-44ef-83f8-5252c1454ac2
# ╠═fa620300-3307-4bda-97de-1c49fbf58d61
# ╟─b5278a66-dbca-44d0-96ad-bd8e24e90ee3
# ╠═81147945-ae09-4fa3-a9ef-288a8c42744e
# ╟─e555ade7-e8f8-4158-8b68-0af132d8861a
# ╠═a37e9857-fc51-4fdc-b8a5-50f6607f52bf
# ╟─d641ab56-f97a-4cab-820d-2d1ce7b3c546
# ╠═04a9798b-fc72-455e-be71-62842167b292
# ╟─1c6fbf70-c098-44cc-ac84-28acc220da7d
# ╠═af7c8d34-5bf3-4e5a-851e-4b7d13b5f6b4
# ╟─8cec6bc7-37fd-43b0-81de-863d6a93e153
# ╠═28eca35a-ff7a-4f07-84dd-08d8329f8fd2
# ╠═9979c1e4-349b-4e0a-87a0-39de45ecdf4c
# ╠═e6ac837a-adc0-4114-9b09-edb43ab4d5bb
# ╠═c5ed48aa-74b8-4a68-958f-10aca604ea5b
# ╠═dca62763-1e1d-48c8-97dc-bc47bca6f2d3
# ╠═692e04a0-ea2c-4ce4-bee2-2d3d4736259b
# ╠═df838016-92fc-4255-be0a-85fb0990bce7
# ╠═cb61b117-245b-4845-808c-70deb40f7061
# ╠═218cc9d7-3c37-44a6-82b8-fecdf8e6fc02
# ╠═d803272a-0090-495d-93a2-d56d2d9b6858
# ╠═23cdee96-73a6-4bdc-ba7d-627f84821ea5
# ╠═01ba9d22-919c-4887-919e-88dcfbc7a03c
# ╠═ee9d4319-5a11-49be-95e1-c96afcf55cd3
# ╠═fb5e356e-8432-4457-acb4-ac8259084bbf
# ╠═f73daf95-cc3f-4e98-92b2-447a53c9c36b
# ╠═736c7740-17e4-47ac-953c-055729365ca3
# ╠═d503f9c8-c168-4f90-9a73-af09fedf3cb1
# ╠═2c0ad9d5-fde0-495f-9c2e-953312ea2902
# ╟─295d258d-3633-4c3f-acf4-f277679e4d2a
# ╠═36ccf5f4-2106-4055-a255-457fe6e88185
# ╠═dcb6c753-3b16-4283-b445-86d1d8b97597
# ╠═982407df-7197-4999-a674-fdfb17cacd4a
# ╠═5a5c83a9-6916-4aeb-901a-42485cde0798
# ╠═03af5d66-77d1-4a7c-bba6-6982ddef3595
# ╠═74025279-68a4-4370-81f2-d68cf8002505
# ╠═d226bb12-6728-471b-8281-4e6d22e2c75a
# ╠═e4bfcf03-0fed-489e-b582-d63eb339651e
# ╠═85683cc3-a96a-40e5-9136-7e954bca0be7
# ╠═bbc0425b-076b-4a5a-8fce-853845c5a26e
# ╠═e7e74706-cdf4-46d0-945d-807e0d13312c
# ╠═db83f1d3-97e3-45a1-96a3-1a4b9b6405ce
# ╠═b8ab2995-8100-484d-b0d1-1bf82d19578d
# ╠═eabaf84f-c090-4886-9d5c-3c782d15dc2b
# ╠═1b6d281e-4aa5-4090-80ee-4e63a019a00e
# ╠═353f4f01-149f-49c9-9711-98eaf538c7e8
# ╠═f083a864-54d4-4b0e-8e15-b07a4b29b612
# ╟─33d30399-c21b-4946-9a5e-4cebf1937082
# ╠═c665c4fe-4061-4da1-a324-a43c126db248
# ╠═7ca56b5e-2662-44fd-9451-d13dd5b69164
# ╠═99ce7b3d-0f79-4495-a786-b42fa173e992
# ╠═45301594-f549-4897-bb87-8b78e7778746
# ╠═aa546fa7-be8b-4768-9198-0e16bde99e46
# ╠═00b9a040-f24a-4c9a-b0ae-3896b994343d
# ╠═4eb6cc09-f864-4a80-9d8d-a03a08e0f97e
# ╟─4041a808-def2-4ce7-9f35-ff9b10abe2f7
# ╠═2beafb91-5227-45eb-bb09-138128713268
# ╠═661fdf22-22f5-4b7f-aec4-04422ec3c50d
# ╠═00a795d7-fe31-4568-b53a-7511052e6e06
# ╠═83a17a23-8486-476b-9b2d-fd6203c03ff9
# ╠═2885dc3c-e984-4008-a153-e4a438e398d8
# ╠═af776524-b603-408b-966e-6d7b2d462f73
# ╠═3048bc35-c1ed-44fd-b761-7a0f7b65ac67
# ╠═b7aa0853-2b58-4689-b0a2-bc601cff7174
# ╠═ef11bdd6-ac98-4f26-afa7-142dae6a214a
# ╠═64f76aea-c240-45d2-b146-42007a18ae89
# ╠═03a54358-3228-48f2-a4d6-5598704b5df6
# ╟─5889eede-0150-476a-a0d1-7298b616172f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
