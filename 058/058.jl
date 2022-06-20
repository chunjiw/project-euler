### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 007b4c82-e064-11ec-3953-498520fa0393
using Primes

# ╔═╡ 6b1e9119-00c8-486d-b376-2fc830b3ef5f
let n = 3
	pc = 0
	for m in 1:n
		l = 2m - 1
		pc += count(isprime.(l^2 .+ [2m, 4m, 6m, 8m]))
	end
	pc , (4n+1)
end

# ╔═╡ 239b8119-f9bf-488c-b690-4e7cf4a66d47
function ratio(n)
	pc = 0
	for m in 1:n
		l = 2m - 1
		pc += count(isprime.(l^2 .+ [2m, 4m, 6m, 8m]))
	end
	pc / (4n+1)
end

# ╔═╡ 556ab631-5b07-4a6d-be22-dd96f9e1edd0
let
	l, r = 10000, 20000
	global m = 0
	while l < r
		m = (l + r) ÷ 2	
		if ratio(m) > 0.1
			l = m + 1
		else
			r = m - 1
		end
	end
	m, ratio(m-2), ratio(m-1)
end

# ╔═╡ 433a9ee0-96c1-43de-9f6a-ca83a17966f1
(m-1) * 2 + 1

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
# ╠═007b4c82-e064-11ec-3953-498520fa0393
# ╠═6b1e9119-00c8-486d-b376-2fc830b3ef5f
# ╠═239b8119-f9bf-488c-b690-4e7cf4a66d47
# ╠═556ab631-5b07-4a6d-be22-dd96f9e1edd0
# ╠═433a9ee0-96c1-43de-9f6a-ca83a17966f1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
