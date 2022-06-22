### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 1544ec4f-7940-4012-86c6-684e05a6ba80
using Primes

# ╔═╡ df9ab307-a153-4826-91c3-a0ab44efb0e0
@time factor(434265829323469456233638234)

# ╔═╡ dec02492-d8b6-4513-a605-0273534c1860
h(s, H) = s + 3 - 3H

# ╔═╡ 5489dc87-f317-4404-a6cd-7f5d1a7813d6
isvertex(h, H) = 3H % 2 == h % 2	

# ╔═╡ 26a1dcb0-9db0-4a5c-ba0b-60af1f82d9e4
is_first_exit_vertex(h, H) = 
	all(H % f != 0 || !isvertex(h÷f, H÷f) for f in keys(factor(h)))

# ╔═╡ 0f1418ca-c19c-4ef3-9f11-933dca6d1383
function nways(s)
	ways = 0
	for H in (s+3)÷4 : (s+3)÷3
		h = s + 3 - 3H 
		if 0 < h < H
			ways += is_first_exit_vertex(h, H) ? 1 : 0
		end
	end
	2ways
end

# ╔═╡ add03fb4-d4b1-11ec-16b2-8bbee30b173e
@time nways(1000001)

# ╔═╡ 6a112bc5-66f2-478b-8399-0926ed77ec14
@time nways(12017639147)

# ╔═╡ 510ef2e9-8eee-4d24-bfa9-657909eb54b6
@time is_first_exit_vertex(1, 3)

# ╔═╡ 2427066b-2da8-4c95-a38a-60cda01c65d9
Rational(3) /2

# ╔═╡ fe3fcca8-f93e-48dc-9a9c-87d7575c780d
h(1000001, 333334)

# ╔═╡ 612b3b53-8f44-4feb-8d19-feaa0d333b04
let s = 1000001
	s÷4-5, s÷3+3
end

# ╔═╡ b4447b94-4d6f-45fd-a176-428f37bedb6f
let s = 1000001
	a, b = (s+3)÷4 + 1, (s+3)÷3 - (s%3 == 0 ? 1 : 0)
	b - a + 1, a, b
end

# ╔═╡ d8d5c520-b3a7-4d75-8679-7eb69126e7a4


# ╔═╡ 9bb055f9-848a-4cdc-a7f3-53b6ea13fc8e


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
# ╠═1544ec4f-7940-4012-86c6-684e05a6ba80
# ╠═df9ab307-a153-4826-91c3-a0ab44efb0e0
# ╠═0f1418ca-c19c-4ef3-9f11-933dca6d1383
# ╠═add03fb4-d4b1-11ec-16b2-8bbee30b173e
# ╠═6a112bc5-66f2-478b-8399-0926ed77ec14
# ╠═dec02492-d8b6-4513-a605-0273534c1860
# ╠═5489dc87-f317-4404-a6cd-7f5d1a7813d6
# ╠═26a1dcb0-9db0-4a5c-ba0b-60af1f82d9e4
# ╠═510ef2e9-8eee-4d24-bfa9-657909eb54b6
# ╠═2427066b-2da8-4c95-a38a-60cda01c65d9
# ╠═fe3fcca8-f93e-48dc-9a9c-87d7575c780d
# ╠═612b3b53-8f44-4feb-8d19-feaa0d333b04
# ╠═b4447b94-4d6f-45fd-a176-428f37bedb6f
# ╠═d8d5c520-b3a7-4d75-8679-7eb69126e7a4
# ╠═9bb055f9-848a-4cdc-a7f3-53b6ea13fc8e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
