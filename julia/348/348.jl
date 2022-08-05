### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 6284360f-698e-4ecd-800f-6a3d78ebb921
issquare(x) = isqrt(x)^2 == x

# ╔═╡ ce9e9efb-5fd6-498a-a68f-1bff8fd37000
function sc4(a, b)
	y = 1
	c = 0
	while (s = a^2 + b^3 - (b+y)^3) > 0
		if issquare(s)
			c += 1
		end
		y += 1
	end
	c == 3
end

# ╔═╡ 6ff39944-e066-11ec-1c69-2b2662612620
let a = 2285, b = 20
	y = 1
	while (s = a^2 + b^3 - (b+y)^3) > 0
		if issquare(s)
			@show b+y
		end
		y += 1
	end
end

# ╔═╡ 3e718bf0-ed93-47dc-b1e7-83d6c09d0c87
function ispalindrome(x)
	digits = Int[]
	while x > 0
		push!(digits, x % 10)
		x ÷= 10
	end
	l, r = 1, length(digits)
	while l < r
		if digits[l] != digits[r]
			return false
		end
		l += 1
		r -= 1
	end
	true
end

# ╔═╡ d3fbb9e6-c93d-4744-a28f-f0b0af04dcdf
let
	sp = 0
	for a in 0:48000, b in 0:3200
		p = a^2 + b^3
		if ispalindrome(p) && sc4(a, b)
			@show p
			sp += p
		end
	end
	sp
end

# ╔═╡ 1dfe70f5-99fe-4edf-afaa-08e6dc3e7521


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
# ╠═ce9e9efb-5fd6-498a-a68f-1bff8fd37000
# ╠═6ff39944-e066-11ec-1c69-2b2662612620
# ╠═6284360f-698e-4ecd-800f-6a3d78ebb921
# ╠═3e718bf0-ed93-47dc-b1e7-83d6c09d0c87
# ╠═d3fbb9e6-c93d-4744-a28f-f0b0af04dcdf
# ╠═1dfe70f5-99fe-4edf-afaa-08e6dc3e7521
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
