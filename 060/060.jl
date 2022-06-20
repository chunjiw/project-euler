### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# ╔═╡ 0af01ae0-e5e0-11ec-2535-0711da9d432b
using Primes

# ╔═╡ fe28109f-84e6-495f-8196-b7a0eb7c293e
ncat(m, n) = m * 10^ndigits(n) + n

# ╔═╡ b67d1661-e2ed-4043-8b38-d412545346b9
isprimepair(m, n) = isprime(ncat(m,n)) && isprime(ncat(n,m))

# ╔═╡ 7e050b72-120b-4b3d-b82f-cc963ce242c1
let
	p = nextprime(674)
	pps = (3,7,109,673)
	cl = 100_000
	c = 1
	while any(.!(isprimepair.(pps, p))) && c < cl
		p = nextprime(p+1)
		c += 1
	end
	@show p, c
end

# ╔═╡ bb691761-b5f8-4204-853c-bfef91dc3807
function findprimepair(s, ngoal=100, ntry=1000)
	n = 1
	p = isempty(s) ? 3 : nextprime(last(s)+1)
	res = Int[]
	while n < ntry
		if all(isprimepair.(s, p))
			push!(res, p)
			if length(res) >= ngoal
				break
			end
		end
		p = nextprime(p+1)
		n += 1
	end
	res
end

# ╔═╡ e1eb3103-e12c-4e71-99a0-58f97efe065a
function grow!(s)
	if length(s) >= 5 @show s, sum(s) return end
	for np in findprimepair(s)
		push!(s, np)
		grow!(s)
		pop!(s)
	end
end

# ╔═╡ 9e64939b-c1de-412a-9d55-b9ab12b5032f
let
	s = Int[]
	grow!(s)
end

# ╔═╡ e8b01b71-b05a-4caf-9f4b-4890ecfccd62
let
	for p in primes(30)
		s = [p]
		for np in findprimepair(s)
			push!(s, np)
			pop!(s)
		end
	end
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

julia_version = "1.7.3"
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
# ╠═0af01ae0-e5e0-11ec-2535-0711da9d432b
# ╠═fe28109f-84e6-495f-8196-b7a0eb7c293e
# ╠═b67d1661-e2ed-4043-8b38-d412545346b9
# ╠═7e050b72-120b-4b3d-b82f-cc963ce242c1
# ╠═e1eb3103-e12c-4e71-99a0-58f97efe065a
# ╠═9e64939b-c1de-412a-9d55-b9ab12b5032f
# ╠═e8b01b71-b05a-4caf-9f4b-4890ecfccd62
# ╠═bb691761-b5f8-4204-853c-bfef91dc3807
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
