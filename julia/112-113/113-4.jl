### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 155dcdb8-d4a8-11ec-1b91-7dd332743fed
firstdigit() = Dict([i => 1 for i in 1:9])

# ╔═╡ e674c94c-f492-46ed-9f60-afee10a27c30
function nextup(digits)
	newd = Dict()
	for d in keys(digits), di in d:9
		newd[di] = get!(newd, di, 0) + digits[d]
	end
	newd
end

# ╔═╡ 2a6e5eff-1ecd-498a-9882-344cbad86717
function nextdown(digits)
	newd = Dict()
	for d in keys(digits), di in 0:d
		newd[di] = get!(newd, di, 0) + digits[d]
	end
	newd
end

# ╔═╡ e3376344-7242-488e-82f0-57d728358dd7
nsol(digits) = sum(values(digits))

# ╔═╡ 4d73be17-db39-4d26-9a63-5eec037a3743
function non_bouncy_at(dn)
	up, down = firstdigit(), firstdigit()
	for _ in 1:dn-1
		up = nextup(up)
		down = nextdown(down)
	end
	nsol(up) + nsol(down) - 9
end

# ╔═╡ c32f7d83-c7fe-4b8b-a223-73eb6b31b78d
function non_bouncy(dn)
	up, down = firstdigit(), firstdigit()
	c = 9
	for _ in 1:dn-1
		up = nextup(up)
		down = nextdown(down)
		c += nsol(up) + nsol(down) - 9
	end
	c
end

# ╔═╡ 13e20789-1308-4073-ac58-f3baff5d636a
let
	non_bouncy_at.(1:3)
end

# ╔═╡ 758feb43-b360-4216-b5f4-8ca7463b5b53
@time let 
	non_bouncy.(1:6)
end

# ╔═╡ 6f114b7e-f170-4c04-83a8-bc6f3866ea29
let
	@time @show non_bouncy(10)
	@time non_bouncy(20)
	@time non_bouncy(30)
end

# ╔═╡ 811795c8-db22-497e-a058-2569553a1ed2
let
	@time non_bouncy(100)
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
# ╠═155dcdb8-d4a8-11ec-1b91-7dd332743fed
# ╠═e674c94c-f492-46ed-9f60-afee10a27c30
# ╠═2a6e5eff-1ecd-498a-9882-344cbad86717
# ╠═e3376344-7242-488e-82f0-57d728358dd7
# ╠═4d73be17-db39-4d26-9a63-5eec037a3743
# ╠═c32f7d83-c7fe-4b8b-a223-73eb6b31b78d
# ╠═13e20789-1308-4073-ac58-f3baff5d636a
# ╠═758feb43-b360-4216-b5f4-8ca7463b5b53
# ╠═6f114b7e-f170-4c04-83a8-bc6f3866ea29
# ╠═811795c8-db22-497e-a058-2569553a1ed2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
