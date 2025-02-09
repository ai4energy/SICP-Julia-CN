### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ c5e8ad50-b9ee-11ef-25e8-fdd8589d0e5c
md"
====================================================================================
#### SICP: 0 序言
====================================================================================
"

# ╔═╡ ccfa36a4-28a3-4ee7-b590-794d10cb0f9d
md"
##### 1 阅读Readme
##### 2 Pluto操作
##### 3 理解报错信息
##### 4 调试
"

# ╔═╡ 1466c5fb-36b7-481a-acb5-ca494c5a92d3
begin
	function test()
	    a = Int[]
	    for i in 1:10
	        push!(a, i)
	    end
	end
	test()
end

# ╔═╡ Cell order:
# ╟─c5e8ad50-b9ee-11ef-25e8-fdd8589d0e5c
# ╟─ccfa36a4-28a3-4ee7-b590-794d10cb0f9d
# ╠═1466c5fb-36b7-481a-acb5-ca494c5a92d3
