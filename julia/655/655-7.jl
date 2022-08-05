### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 89df74c0-c4ab-4497-8b17-cb6c59aa57d3
@time let m = 10^7 + 19
	v = fill(0, m)
	w = copy(v)
	for _ in 1:100
		i = mod(rand(Int), m)
		@views v[1:i] .+= w[end-i+1:end]
		@views v[i+1:end] .+= w[1:end-i]
	end
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═89df74c0-c4ab-4497-8b17-cb6c59aa57d3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
