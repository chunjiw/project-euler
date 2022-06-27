### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# ╔═╡ 3d8400b8-e5d9-11ec-29e9-7fe046f4e1fd
using Primes

# ╔═╡ 9e8f8f5b-7a46-4b3a-8215-1ae1576a0641
function fromdigits(ds; base=10)
	n = 0
	m = 1
	for d in ds
		n += m * d
		m *= base
	end
	n
end

# ╔═╡ adacf084-bbba-44ff-b2a2-42c5dcbebd38
let d = 6
	cnt = 0
	for i in 1:2^d - 2    # rule out the cases of replacing no or all digits
		patten = digits(i, base=2, pad=d)
		nfixed = sum(patten)
		n = fill(0, d)
		for f in 0:10^nfixed-1
			n[patten .== 1] .= digits(f, pad=nfixed)
			cr = 0
			for r in 0:9
				n[patten .== 0] .= r
				if last(n) != 0 && isprime(fromdigits(n))
					cr += 1
				end
			end
			if cr == 8
				@show n, patten
			end
		end
	end
end

# ╔═╡ e40cfc55-234a-4f83-ae7e-8715503cc42d
isprime(121313)

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
# ╠═3d8400b8-e5d9-11ec-29e9-7fe046f4e1fd
# ╠═9e8f8f5b-7a46-4b3a-8215-1ae1576a0641
# ╠═adacf084-bbba-44ff-b2a2-42c5dcbebd38
# ╠═e40cfc55-234a-4f83-ae7e-8715503cc42d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
