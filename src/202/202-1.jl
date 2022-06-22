### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 2f29b9e2-ff51-427e-9e69-3d57fed87719
using Primes

# ╔═╡ 0013bc66-d4e8-11ec-0c26-63aef74ab456
# let n = 1000001
let n = 12017639147
	s = (n+3) ÷ 2
	c = 0
	for x in 1:s
		y = s - x
		if x > y break; end
		if (y-x) % 3 == 0
			c += gcd(x, y) == 1 ? 1 : 0
		end
	end
	2c
end

# ╔═╡ ef192262-dce2-4581-8ce9-7491471dd917
s = (12017639147 + 3) ÷ 2

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
# ╠═0013bc66-d4e8-11ec-0c26-63aef74ab456
# ╠═ef192262-dce2-4581-8ce9-7491471dd917
# ╠═2f29b9e2-ff51-427e-9e69-3d57fed87719
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
