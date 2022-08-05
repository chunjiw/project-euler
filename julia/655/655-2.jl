### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 040c058c-9459-4e72-bb72-f6467f982efa
using BenchmarkTools

# ╔═╡ 05c0bf17-701f-434b-92cf-adf77c40f98d
function revint(n)
	d = 0
	while n > 0
		d *= 10
		d += n % 10
		n ÷= 10
	end
	d
end

# ╔═╡ 0b674e37-0667-4a0d-a53b-9ac65f181974
function gettail(m)
	revm = revint(m)
	x = mod(-13revm, 19)   # solution to 100000x + revm ≡ 0 (mod 19)
	(100000x + revm) ÷ 19
end

# ╔═╡ 77cbdc03-e698-447c-be3b-be97937a5f95
@btime gettail(12345)

# ╔═╡ 5a9356ca-8130-4a18-b6e1-cf4a2327fc39
function ndigits(n, b=10)
	if n == 0 return 1 end
	c = 0
	while n > 0
		c += 1
		n ÷= b
	end
	c
end

# ╔═╡ 79a00d57-dbef-4c9b-b03d-f9fdfcfa6534
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

# ╔═╡ 930e9bbe-e2bf-11ec-01d4-759d26e2ff4a
p::Int = 10_000_019

# ╔═╡ b4cf4ab8-a32f-42f7-a7f0-4f4bb4276da6
function countp(mid)
	d = ndigits(mid)
	c = 0
	for m in 10000:99999
		t = gettail(m)
		if ispalindrome2(mid*p + 10^2*t + 19m*(10^d) + 19t÷10^5)
			c += 1
		end
	end
	c
end

# ╔═╡ 91246095-6363-4ae4-9a0a-91850cb90ce7
function showp(mid)
	d = ndigits(mid)
	for m in 99999:-1:10000
		t = gettail(m)
		if ispalindrome2(mid*p + 10^2*t + 19m*(10^d) + 19t÷10^5)
			@show m, mid, t
			@show m, mid*p + 10^2*t + 19m*(10^d) + 19t÷10^5, 19t%10^5
			return
		end
	end
end

# ╔═╡ e20155c0-4f8f-4239-b820-73f07f8a0ff3
[countp(i) for i in 0:3]

# ╔═╡ 37d8ae61-7ad1-4c4e-8786-c88bb5561591
showp(9)

# ╔═╡ d3b1c368-be4e-44ae-9c05-4deeba825c50
62048957054p

# ╔═╡ 34da09be-ce54-4e20-b09d-4c7e2587e233
1000099p

# ╔═╡ cafe00b1-0349-416a-8523-d5968ebd0cbf
99181006221*p

# ╔═╡ 12e6c638-397b-4ad6-a837-36786822ac81
999991068421* BigInt(p)

# ╔═╡ 293e6ec3-8b62-4174-87b8-d7a286714c04
@time let
	c = 0
	for m in 10000:99999
		t = gettail(m)
		if m % 10 == t ÷ 10000
			a = 10000m + t%10000
			if ispalindrome2(p*a)
				@show a, p*a
				c += 1
			end
		end
	end
	c
end

# ╔═╡ 659f7e5f-5494-45ff-87d7-8a04eabd21cf
@time let
	c = 0
	for m in 10000:99999
		t = gettail(m)
		a = 100000m + t
		if ispalindrome2(p*a)
			@assert m == p*a÷(10^(ndigits(p*a) - 5))
			c += 1
		end
	end
	c
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"

[compat]
BenchmarkTools = "~1.3.1"
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
# ╠═040c058c-9459-4e72-bb72-f6467f982efa
# ╠═77cbdc03-e698-447c-be3b-be97937a5f95
# ╠═0b674e37-0667-4a0d-a53b-9ac65f181974
# ╠═b4cf4ab8-a32f-42f7-a7f0-4f4bb4276da6
# ╠═91246095-6363-4ae4-9a0a-91850cb90ce7
# ╠═05c0bf17-701f-434b-92cf-adf77c40f98d
# ╠═5a9356ca-8130-4a18-b6e1-cf4a2327fc39
# ╠═79a00d57-dbef-4c9b-b03d-f9fdfcfa6534
# ╠═930e9bbe-e2bf-11ec-01d4-759d26e2ff4a
# ╠═e20155c0-4f8f-4239-b820-73f07f8a0ff3
# ╠═37d8ae61-7ad1-4c4e-8786-c88bb5561591
# ╠═d3b1c368-be4e-44ae-9c05-4deeba825c50
# ╠═34da09be-ce54-4e20-b09d-4c7e2587e233
# ╠═cafe00b1-0349-416a-8523-d5968ebd0cbf
# ╠═12e6c638-397b-4ad6-a837-36786822ac81
# ╠═293e6ec3-8b62-4174-87b8-d7a286714c04
# ╠═659f7e5f-5494-45ff-87d7-8a04eabd21cf
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
