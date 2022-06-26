### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 37916115-a1a4-488e-92ef-094adc828f53
using Combinatorics

# ╔═╡ 9057a81e-e28b-474d-b7d8-fd868abaa616
_npartitions = Dict{Int, Int}()

# ╔═╡ f1e37fc8-9732-42ef-9f60-3ecd9ff21ee3
function npartitions(n::Int)
	if n < 0
		0
	elseif n < 2
		1
	elseif n in keys(_npartitions)
		_npartitions[n]
	else
		np = 0
		sgn = 1
		for k = 1:n
			np += sgn * (npartitions(n - (k * (3k - 1)) ÷ 2) + npartitions(n - (k * (3k + 1)) ÷ 2))
			sgn = -sgn
		end
		_npartitions[n] = np % 1_000_000
	end
end

# ╔═╡ f1d2a4a1-36a3-40f1-ae13-70f67c725415
let
	for n in 1:80000
		if npartitions(n) == 0
			@show n
			break
		end
	end
end

# ╔═╡ eea24b91-a6c4-417b-b857-c0e1012df082
npartitions(55374)

# ╔═╡ 87876a0d-045c-479b-9bb8-ab9b99f8cac2
begin 
	npartitions(45000), length(keys(_npartitions))
end

# ╔═╡ 67f38b9c-ffb0-4ccb-a299-1e96fa58f7e7
let n = 405
	npartitions(n), length(partitions(n)) % 1_000_000
end

# ╔═╡ 6c139f87-eb92-4faa-9a01-401266fafd25
length(partitions(405)), length(partitions(406))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"

[compat]
Combinatorics = "~1.0.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"
"""

# ╔═╡ Cell order:
# ╠═37916115-a1a4-488e-92ef-094adc828f53
# ╠═f1e37fc8-9732-42ef-9f60-3ecd9ff21ee3
# ╠═9057a81e-e28b-474d-b7d8-fd868abaa616
# ╠═f1d2a4a1-36a3-40f1-ae13-70f67c725415
# ╠═eea24b91-a6c4-417b-b857-c0e1012df082
# ╠═87876a0d-045c-479b-9bb8-ab9b99f8cac2
# ╠═67f38b9c-ffb0-4ccb-a299-1e96fa58f7e7
# ╠═6c139f87-eb92-4faa-9a01-401266fafd25
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
