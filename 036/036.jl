### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 8fe22796-e0ba-11ec-11b7-c9c01f90032d
struct Palindromes
	limit::Int
end

# ╔═╡ 1dfef8f8-c2cd-4575-8a4b-3a0a1b97b650
function isbinpalin(n)
	ds = Int[]
	while n > 0
		push!(ds, n%2)
		n ÷= 2
	end
	l, r = 1, length(ds)
	while l < r
		if ds[l] != ds[r]
			return false
		end
		l += 1
		r -= 1
	end
	true
end

# ╔═╡ 1739da0e-eefa-4272-8c63-6e64123bc226
let n = 1_000_000
	sump = 0
	for p in Palindromes(n)
		if isbinpalin(p)
			sump += p
		end
	end
	sump
end

# ╔═╡ 731e06b1-4979-4a7d-a6a6-3188d05cf443
function revint(n)
	d = 0
	while n > 0
		d *= 10
		d += n % 10
		n ÷= 10
	end
	d
end

# ╔═╡ c8b66bfa-79aa-4858-a853-69a7eab8f458
function ndigits(n)
	c = 0
	while n > 0
		c += 1
		n ÷= 10
	end
	c
end

# ╔═╡ a16c7358-9f80-480c-b9bf-0b23b69b2441
function nextpalindrome(n)
	if n == 0 return 1 end
	l = ndigits(n)
	m = n ÷ 10^(l÷2)    # ndigits(m) = l÷2 + l%2
	m += 1
	if ndigits(m) == l÷2 + l%2    # m keeps length
		mm = m ÷ (l%2 == 1 ? 10 : 1)
		return m * 10^(l÷2) + revint(mm)
	else
		return n + 2     # from 99999 to 100001
	end
end

# ╔═╡ c803f3bd-a68e-412c-9a11-98f4ba35f561
function Base.iterate(P::Palindromes, state=0)
	state > P.limit ? nothing : (state, nextpalindrome(state))
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
# ╠═8fe22796-e0ba-11ec-11b7-c9c01f90032d
# ╠═1739da0e-eefa-4272-8c63-6e64123bc226
# ╠═1dfef8f8-c2cd-4575-8a4b-3a0a1b97b650
# ╠═c803f3bd-a68e-412c-9a11-98f4ba35f561
# ╠═a16c7358-9f80-480c-b9bf-0b23b69b2441
# ╠═731e06b1-4979-4a7d-a6a6-3188d05cf443
# ╠═c8b66bfa-79aa-4858-a853-69a7eab8f458
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
