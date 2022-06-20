### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ d0f75dfc-895b-401e-a2ed-d1bf2d3402b8
using Primes

# ╔═╡ e89088fb-aa14-40e0-afd0-e0f31a78a5bf
md"
- Vertices $C$ sit at $(x,y)$ where ``x-y ≡ 0 \pmod 3``
- Number of sides crossed from $(0,0)$ to $(x,y)$ is $w =2(x+y)-3$
- To make sure no $C$ vertices are on the path, $\gcd(x,y) = 1$
-  $A$ and $B$ vertices are allowed on the path

$x>0, y>0$
$(x+y)=s=\frac{w+3}{2}$
$x-y = 2x-s ≡ 0 \pmod 3$
$\gcd(x,y) = \gcd(x,s) = 1$
"

# ╔═╡ c45978aa-433a-4a38-bd5d-47394d222aa9
function nways(w = 1000001)
	s = (w + 3) ÷ 2
	xmod3 = 2(s % 3) % 3
	ps = keys(factor(s))
	index = 1:s-1
	seive = BitArray(false for x in index)
	seive[xmod3:3:s-1] .= true
	for p in ps
		seive[p:p:s-1] .= false
	end
	count(seive)
end

# ╔═╡ 7123349a-d536-11ec-268c-57828017940b
w = 12017639147

# ╔═╡ 69d359db-166c-4d81-a3ab-a7943430dc81
@time nways(w)

# ╔═╡ e78024b3-10a1-463e-8d11-6542aeed504a
s = (w + 3) ÷ 2

# ╔═╡ 6827fcf1-02cb-429d-92b3-e112db811aca
2(s % 3) % 3

# ╔═╡ d1ee3dde-cfb7-4b5a-a0e9-26eb3b3db7e9
length(2:3:s-1) - 3*2^6 + 2

# ╔═╡ 1d511173-30ad-4e14-975a-69f0bdf5c77d
3*2^6-2

# ╔═╡ 31c2b0d3-d1f8-4222-8b26-5462a212ce84
factor(s)

# ╔═╡ 83b0a097-f5c0-4b36-ad55-b6d4f514b61f
keys(factor(s))

# ╔═╡ 8d0cd01a-a66d-4fc8-8e61-63d3a50596de
s % 3

# ╔═╡ 86d115fc-b00f-4d82-b258-2b523509fcf0
is_early(x) = any(x % p == 0 for p in (5,11,17,23,29,41,47))

# ╔═╡ f1d7633e-f0a4-4b87-84db-188cac912155
let s = s
	ps = keys(factor(s))
	c = 0
	for x in 2:3:s÷2
		c += is_early(x) ? 0 : 1
	end
	c
end

# ╔═╡ d58a40c2-ff7b-43e0-ac32-824b9e45a37d
let w = 1000001
	s = (w + 3) ÷ 2
	ps = keys(factor(s))
	c = 0
	for x in 2:3:s-1
		c += is_early(x) ? 0 : 1
	end
	c
end

# ╔═╡ dc335564-97f6-4c58-99e6-be38ba37b502
604501312 * 2

# ╔═╡ d67c2247-283d-4043-9a4f-840e51b7e450
@time is_early(5)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"

[compat]
Primes = "~0.5.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "f366daebdfb079fd1fe4e3d560f99a0c892e15bc"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.0"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "747f4261ebe38a2bc6abf0850ea8c6d9027ccd07"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.2"
"""

# ╔═╡ Cell order:
# ╠═e89088fb-aa14-40e0-afd0-e0f31a78a5bf
# ╠═c45978aa-433a-4a38-bd5d-47394d222aa9
# ╠═69d359db-166c-4d81-a3ab-a7943430dc81
# ╠═7123349a-d536-11ec-268c-57828017940b
# ╠═e78024b3-10a1-463e-8d11-6542aeed504a
# ╠═6827fcf1-02cb-429d-92b3-e112db811aca
# ╠═d1ee3dde-cfb7-4b5a-a0e9-26eb3b3db7e9
# ╠═1d511173-30ad-4e14-975a-69f0bdf5c77d
# ╠═d0f75dfc-895b-401e-a2ed-d1bf2d3402b8
# ╠═31c2b0d3-d1f8-4222-8b26-5462a212ce84
# ╠═83b0a097-f5c0-4b36-ad55-b6d4f514b61f
# ╠═8d0cd01a-a66d-4fc8-8e61-63d3a50596de
# ╠═f1d7633e-f0a4-4b87-84db-188cac912155
# ╠═d58a40c2-ff7b-43e0-ac32-824b9e45a37d
# ╠═86d115fc-b00f-4d82-b258-2b523509fcf0
# ╠═dc335564-97f6-4c58-99e6-be38ba37b502
# ╠═d67c2247-283d-4043-9a4f-840e51b7e450
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
