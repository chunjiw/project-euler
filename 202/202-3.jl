### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 36fdda6c-86ec-459e-afb6-0987c41e0397
using Primes

# ╔═╡ 9a1e279a-d549-11ec-14ef-47059c6e8a96
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

# ╔═╡ 308be3d3-3f17-49a7-b21c-a691ce958ecf
let w = 1000001
	s = (w + 3) ÷ 2
	@show xmod3 = 2(s % 3) % 3
	ps = keys(factor(s))
	index = 1:s-1
	seive = BitArray(false for x in index)
	seive[xmod3:3:s-1] .= true
	@show length(xmod3:3:s-1)
	@show (s - 1 - xmod3) ÷ 3 + 1
	for p in ps
		seive[p:p:s-1] .= false
	end
	count(seive)
end

# ╔═╡ 97794736-04e2-4cb3-9e6b-b904a511a2e2
let n = 3
	for i in 0:2^n-1
		@show [i ÷ 2^j % 2 for j in 0:n-1]
	end
end

# ╔═╡ e8631f3e-3538-4248-9262-7043f8d82b2f
@time let w = 1000001
	s = (w + 3) ÷ 2
	@show xmod3 = 2(s % 3) % 3
	@show c = (s - 1 - xmod3) ÷ 3 + 1
	@show ps = keys(factor(s))
	n = length(ps)
	for i in 0:2^n-1
		select = [i ÷ 2^j % 2 for j in 0:n-1]
		if sum(select) == 0 continue; end
		@show d = prod(ps.^select)
		c += @show (-1)^sum(select) * count((d:d:s-1) .% 3 .== xmod3)
	end
	c
end

# ╔═╡ 0e02f73b-ad83-4830-8699-e70482d60e79
function phi(n)
	ps = keys(factor(n))
	for p in ps
		n -= n ÷ p
	end
	n
end

# ╔═╡ 34203bc6-7042-4dea-9b37-6f32e292c94d
let w = 1000001 #12017639147
	s = (w + 3) ÷ 2
	r = length(factor(s))
	(phi(s) - 2^r) ÷ 3
end

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
# ╠═9a1e279a-d549-11ec-14ef-47059c6e8a96
# ╠═36fdda6c-86ec-459e-afb6-0987c41e0397
# ╠═308be3d3-3f17-49a7-b21c-a691ce958ecf
# ╠═97794736-04e2-4cb3-9e6b-b904a511a2e2
# ╠═e8631f3e-3538-4248-9262-7043f8d82b2f
# ╠═34203bc6-7042-4dea-9b37-6f32e292c94d
# ╠═0e02f73b-ad83-4830-8699-e70482d60e79
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
