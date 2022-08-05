### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 1b022b58-261e-4bc8-b35e-50c395b03dbb
using Primes

# ╔═╡ 0d031719-d285-4420-bc47-feb2cf4b7b86
using BenchmarkTools

# ╔═╡ 7e191c90-e10a-11ec-2259-176c657763d6
p = 10_000_019

# ╔═╡ 6acbfea4-901c-4bbe-a1db-76a6b4e6e0bc
isprime(p)

# ╔═╡ bfcef192-1622-4fed-8be8-fc8f6f5e0904


# ╔═╡ e67cd0b5-9c70-4eff-9dec-d890c4d2f66e
function ispalindrome(n, b=10)
	ds = Int[]
	while n > 0
		push!(ds, n % b)
		n ÷= b
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

# ╔═╡ 214f4435-9c67-449c-b2c8-1a22cb32292b
351/9

# ╔═╡ 2e9c6563-965e-449c-bd53-4dcb01671e23
15151 - 13900

# ╔═╡ 3eebaafc-e5e0-42a1-aca9-18acd7b85164
1251/9

# ╔═╡ 68319da8-b450-4b7e-bb93-176699141642
64746/109

# ╔═╡ c7c91b22-0f41-4263-bdf2-166cb4c54ebf
64746-59400

# ╔═╡ b05a245e-23c3-4cba-9a11-06cf57ce2713
function revint(n)
	d = 0
	while n > 0
		d *= 10
		d += n % 10
		n ÷= 10
	end
	d
end

# ╔═╡ 09148f05-61ba-4cbf-94e5-a84294461487
function ndigits(n, b=10)
	if n == 0 return 1 end
	c = 0
	while n > 0
		c += 1
		n ÷= b
	end
	c
end

# ╔═╡ 0652eac8-b0ee-48ba-a75e-85ecddde3a98
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

# ╔═╡ e7595c8f-3cfb-4721-850a-575c860e560a
begin
	struct Palindromes
		limit::Int
	end
	function Base.iterate(P::Palindromes, state=0)
		state > P.limit ? nothing : (state, nextpalindrome(state))
	end
end

# ╔═╡ 2e82aa14-9eff-4709-b0c4-7320a383470f
@time let limit = 10^6
	c = -1
	for p in Palindromes(limit)
		if p % 109 == 0
			c += 1
			@show p
		end
	end
	c
end

# ╔═╡ d5c60500-ecf5-4f94-a16a-df2b08107d2d
@time let limit = 10^14
	c = -1
	for p in Palindromes(limit)
		if p % 10_000_019 == 0
			c += 1
			@show p
		end
	end
	c
end

# ╔═╡ 3ced45e7-2de7-405e-b399-f08b675de77f
function ispalindrome2(n, b=10)
	l = ndigits(n)
	while l > 1
		if n ÷ b^(l-1) != n % b
			return false
		end
		n %= b^(l-1)
		n ÷= b
		l -= 2
	end
	true
end

# ╔═╡ cc00d3fb-0892-4918-b876-2dff30f50ef1
function firstdigit(n, b=10)
	while n >= 10
		n ÷= b
	end
	n
end

# ╔═╡ adfe3963-7ac1-4433-b023-7354e185ec53
@time let
	p = 10_000_019
	for n in 138_000_000p:p:139_000_000p
		if ispalindrome2(n)
			@show n÷p, n
		end
	end
end

# ╔═╡ c4a7cbb8-5403-44d8-90a4-2673c3f1455c
let n = 8    # 2n digits
	[(10^i + 10^(2n-1-i)) % p for i in 0:n-1]
	# [10^i + 10^(2n-1-i) for i in 0:n-1]
end	

# ╔═╡ c2ab05d4-9f13-4e05-b9f7-80853cf90900


# ╔═╡ d2ff8c09-4d58-4372-9362-eb478a9f915c
ndigits(1381114114111831)

# ╔═╡ 8d463f55-1cb5-48dd-b381-6a9b5c0c72ac
ndigits(typemax(UInt), 2)

# ╔═╡ d45022f9-0f48-46bb-9ac7-e7149a498341
isprime(10_000_019)

# ╔═╡ 97605d52-33d6-4244-800e-191e4fa92c93
let m = 13811
	revm = revint(m)
	revm % 19
	rem19 = 100000 .* (0:18) .% 19
	extra = findfirst(rem19 .== (19-revm%19) % 19) - 1
	@assert (100000extra + revm) % 19 == 0
	(100000extra + revm) ÷ 19
end

# ╔═╡ 29bb9840-dc42-40ab-b4f0-20a42d66eaee
function gettail(m)
	revm = revint(m)
	x = mod(-13revm, 19)   # solution to 100000x + revm ≡ 0 (mod 19)
	(100000x + revm) ÷ 19
end

# ╔═╡ a6b0f766-c691-4aba-97f8-3d1d8037094d
function countp(mid)
	d = ndigits(mid)
	c = 0
	for m in 10000:99999
		t = gettail(m)
		if ispalindrome2(10_000_019(100000m*(10^d) + 100000mid + t))
			c += 1
		end
	end
	c
end

# ╔═╡ 350baf08-215a-4d11-9841-301a4146f8d9
sum(countp(i) for i in 0:9)

# ╔═╡ 90434bdf-c2c5-4f5d-bed9-dba7ea0a238e
sum(countp(i) for i in 0:99)

# ╔═╡ 3b209be8-5654-4f0d-bc05-af0042bd5db3
countp(99)

# ╔═╡ 3e580fe4-44fd-4ee4-a068-8d1f54aecb88
countp(100)

# ╔═╡ 780b6a2a-617d-4b14-b75a-2b178fba216a
@time let
	for m in 10000:99999
		t = gettail(m)
		if m % 10 == t ÷ 10000
			if ispalindrome2(10_000_019(10000m + t%10000))
				@show 10_000_019(10000m + t%10000)
			end
		end
	end
end

# ╔═╡ ec169e4f-9dd5-45f4-bbca-6bd2dfb2b872
@time let
	for m in 10000:99999
		t = gettail(m)
		if ispalindrome2(10_000_019(100000m + t))
			@show 10_000_019(100000m + t)
		end
	end
end

# ╔═╡ 553a48a1-d645-4ac0-ab58-e70eb59c0920
tm = typemax(Int)

# ╔═╡ 075451f5-d3c1-40bd-bd82-094dc2fc4f29
ndigits(typemax(Int))

# ╔═╡ f8282398-01ad-4fdf-be36-cea9168d0f6b
ndigits(BigInt(tm) ^2)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"

[compat]
BenchmarkTools = "~1.3.1"
Primes = "~0.5.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "4c10eee4af024676200bc7752e536f858c6b8f93"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "f366daebdfb079fd1fe4e3d560f99a0c892e15bc"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "1285416549ccfcdf0c50d4997a94331e88d68413"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.1"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "747f4261ebe38a2bc6abf0850ea8c6d9027ccd07"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
"""

# ╔═╡ Cell order:
# ╠═7e191c90-e10a-11ec-2259-176c657763d6
# ╠═1b022b58-261e-4bc8-b35e-50c395b03dbb
# ╠═6acbfea4-901c-4bbe-a1db-76a6b4e6e0bc
# ╠═e7595c8f-3cfb-4721-850a-575c860e560a
# ╠═0652eac8-b0ee-48ba-a75e-85ecddde3a98
# ╠═bfcef192-1622-4fed-8be8-fc8f6f5e0904
# ╠═2e82aa14-9eff-4709-b0c4-7320a383470f
# ╠═d5c60500-ecf5-4f94-a16a-df2b08107d2d
# ╠═e67cd0b5-9c70-4eff-9dec-d890c4d2f66e
# ╠═3ced45e7-2de7-405e-b399-f08b675de77f
# ╠═214f4435-9c67-449c-b2c8-1a22cb32292b
# ╠═2e9c6563-965e-449c-bd53-4dcb01671e23
# ╠═3eebaafc-e5e0-42a1-aca9-18acd7b85164
# ╠═68319da8-b450-4b7e-bb93-176699141642
# ╠═c7c91b22-0f41-4263-bdf2-166cb4c54ebf
# ╠═0d031719-d285-4420-bc47-feb2cf4b7b86
# ╠═b05a245e-23c3-4cba-9a11-06cf57ce2713
# ╠═09148f05-61ba-4cbf-94e5-a84294461487
# ╠═cc00d3fb-0892-4918-b876-2dff30f50ef1
# ╠═adfe3963-7ac1-4433-b023-7354e185ec53
# ╠═c4a7cbb8-5403-44d8-90a4-2673c3f1455c
# ╠═c2ab05d4-9f13-4e05-b9f7-80853cf90900
# ╠═d2ff8c09-4d58-4372-9362-eb478a9f915c
# ╠═8d463f55-1cb5-48dd-b381-6a9b5c0c72ac
# ╠═d45022f9-0f48-46bb-9ac7-e7149a498341
# ╠═97605d52-33d6-4244-800e-191e4fa92c93
# ╠═29bb9840-dc42-40ab-b4f0-20a42d66eaee
# ╠═a6b0f766-c691-4aba-97f8-3d1d8037094d
# ╠═350baf08-215a-4d11-9841-301a4146f8d9
# ╠═90434bdf-c2c5-4f5d-bed9-dba7ea0a238e
# ╠═3b209be8-5654-4f0d-bc05-af0042bd5db3
# ╠═3e580fe4-44fd-4ee4-a068-8d1f54aecb88
# ╠═780b6a2a-617d-4b14-b75a-2b178fba216a
# ╠═ec169e4f-9dd5-45f4-bbca-6bd2dfb2b872
# ╠═553a48a1-d645-4ac0-ab58-e70eb59c0920
# ╠═075451f5-d3c1-40bd-bd82-094dc2fc4f29
# ╠═f8282398-01ad-4fdf-be36-cea9168d0f6b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
