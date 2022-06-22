### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 522bf814-d63b-11ec-3b86-fbb4db6fc1d6
function Φ(n)
	ϕ = Vector{Int}(undef, n)
	ϕ[1], ϕ[2], ϕ[3] = 1, 2, 4
	for i = 4:n
		ϕ[i] = i*(i+1)÷2 - sum(ϕ[i÷g] for g in 2:isqrt(i))
		for z in isqrt(i) : -1 : 1
			ϕ[i] -= z != i÷z ? ϕ[z] * (i÷z - i÷(z+1)) : 0
		end
	end
	ϕ[n]
end

# ╔═╡ 112c101b-8f66-49c2-8c0e-44c03354ecc3
let n = 1000
	3n*(n+1) - 6Φ(n)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═522bf814-d63b-11ec-3b86-fbb4db6fc1d6
# ╠═112c101b-8f66-49c2-8c0e-44c03354ecc3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
