### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ e03846f9-a9d4-4738-a41e-2b51273da953
using ThreadsX

# ╔═╡ 1baf279c-f230-46cf-bf08-8d00a5e3b0bc
p = 10_000_019

# ╔═╡ 43cf31fa-80da-432f-9f21-8b712cddbc6b
function ndigits(n, b=10)
	if n == 0 return 1 end
	c = 0
	while n > 0
		c += 1
		n ÷= b
	end
	c
end

# ╔═╡ deb71a5a-311e-4f42-82ce-b42965cebeb4
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

# ╔═╡ a70528c2-3be4-437d-840e-2452a7a9494c
function revint(n, td)
	@assert ndigits(n) <= td
	m = revint(n)
	m*10^(td - ndigits(m))
end

# ╔═╡ e71b7944-e2c8-11ec-0037-b57741209ebf
function revint(n)
	d = 0
	while n > 0
		d *= 10
		d += n % 10
		n ÷= 10
	end
	d
end

# ╔═╡ 564677e9-8a5b-444e-8f20-01e9e24dbf62
function counteven(n, p = p)
	dict = Dict{Int, Int}()
	# abcd, with digits ijji
	i, j = n÷2, n÷2 + n%2
	ma = (10^2j % p) * (10^i % p) % p
	mb = (10^j % p) * (10^i % p) % p
	mc = 10^i % p
	for d in 1:10^i-1
		d % 10 == 0 && continue
		a = revint(d, i)
		mm = (a * ma % p + d % p) % p
		dict[mm] = get(dict, mm, 0) + 1
	end
	cnt = 0
	for c in 0:10^j-1
		b = revint(c, j)
		mm = mod(-(b * mb % p + c * mc % p), p)
		cnt += get(dict, mm, 0)
	end
	cnt
end

# ╔═╡ 93652be8-4368-48aa-8a70-34ea3befa00e
function countodd(n, p = p)
	dict = Dict{Int, Int}()
	# abecd, with digits ij1ji
	i, j = n÷2, n÷2 + n%2
	ma = 10 * (10^2j % p) * (10^i % p) % p
	mb = 10 * (10^j % p) * (10^i % p) % p
	mc = 10^i % p
	me = (10^j % p) * (10^i % p) % p
	for d in 1:10^i-1
		d % 10 == 0 && continue
		a = revint(d, i)
		mm = (a * ma % p + d % p) % p
		dict[mm] = get(dict, mm, 0) + 1
	end
	cnt = 0
	for c in 0:10^j-1, e in 0:9
		b = revint(c, j)
		mm = mod(-(b * mb % p + e * me % p + c * mc % p), p)
		cnt += get(dict, mm, 0)
	end
	cnt
end

# ╔═╡ 5162f3e8-3969-4d52-920e-c761de1c30b5
ThreadsX.sum(counteven(n) for n in 8:16)

# ╔═╡ 3f6a3620-23c3-4cfd-bcd0-116ab6d4bf0d
co = ThreadsX.sum(countodd(n) for n in 8:15)

# ╔═╡ 03fa6a95-120a-4c64-9126-fec2ed7642eb
countodd(9)

# ╔═╡ 783e6603-8bf7-49e5-acb7-934bfc5ae569
1000000074 + co

# ╔═╡ d9ee5999-388a-48e4-92c5-b49ded4db9da
let n = 8, p = p
	dict = Dict{Int, Vector{Int}}()
	# abcd, with digits ijji
	i, j = n÷2, n÷2 + n%2
	ma = (10^2j % p) * (10^i % p) % p
	mb = (10^j % p) * (10^i % p) % p
	mc = 10^i % p
	for d in 1:10^i-1
		d % 10 == 0 && continue
		a = revint(d, i)
		mm = (a * ma % p + d % p) % p
		s = get!(dict, mm, [])
		push!(s, a)
	end
	cnt = 0
	for c in 0:10^j-1
		b = revint(c, j)
		mm = mod(-(b * mb % p + c * mc % p), p)
		for a in get(dict, mm, [])
			cnt += 1
			e = a*10^(2j+i) + b*10^(j+i) + c*10^i + revint(a)
			# @show e, e % p
			@assert ispalindrome2(e)
			@assert e % p == 0
		end
	end
	cnt
end

# ╔═╡ 8d19a3f8-13bc-447a-8b12-a0359af64f42
let n = 9, p = p
	dict = Dict{Int, Vector{Int}}()
	# abecd, with digits ij1ji
	i, j = n÷2, n÷2 + n%2
	ma = 10 * (10^2j % p) * (10^i % p) % p
	mb = 10 * (10^j % p) * (10^i % p) % p
	mc = 10^i % p
	me = (10^j % p) * (10^i % p) % p
	for d in 1:10^i-1
		d % 10 == 0 && continue
		a = revint(d, i)
		mm = (a * ma % p + d % p) % p
		s = get!(dict, mm, [])
		push!(s, a)
	end
	cnt = 0
	for c in 0:10^j-1, e in 0:9
		b = revint(c, j)
		mm = mod(-(b * mb % p + e * me % p + c * mc % p), p)
		for a in get(dict, mm, [])
			cnt += 1
			f = BigInt(a)*10^(2j+i+1) + b*10^(j+i+1) + e*10^(j+i) + c*10^i + revint(a)
			@assert f % p == 0
			@show f
			@assert ispalindrome2(f)
		end
	end
	cnt
end

# ╔═╡ 64ed9f8c-5591-41bf-ab4e-3e4d5ad4574a
8622028101822268 ÷ p

# ╔═╡ 360b7648-f365-4442-93d5-5ba540501b5b
45985850_00000000_00000000_05858954 % p

# ╔═╡ b79395d6-f593-47c1-bea6-4f6a4309e966


# ╔═╡ ed770f91-de16-43bc-b3d4-72308627b5d9


# ╔═╡ 04e7cce8-74b4-43a5-a6ca-cf62d926d98f


# ╔═╡ 87649a4f-4ae5-41f4-aaf9-c2c7513eec98


# ╔═╡ af0e7f3f-0a35-48b6-ab63-20dfc67dce8f


# ╔═╡ dbe09310-7319-4da9-a8a7-1984365b9b07


# ╔═╡ f3080fda-8dc2-4268-9cc1-918122727839


# ╔═╡ 97e35d3b-64eb-439a-a3fa-5f0a98319d0e
BigInt(10)^8 % p

# ╔═╡ 154a5d55-b82d-4a3b-ac37-abe02a310d24
(BigInt(10)^16 % p) * (BigInt(10)^8 % p) % p

# ╔═╡ d684189c-5bfa-462f-9ff0-eb95ec03242d
(10^16 % p) * (10^8 % p) % p

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ThreadsX = "ac1d9e8a-700a-412c-b207-f0111f4b6c0d"

[compat]
ThreadsX = "~0.1.10"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgCheck]]
git-tree-sha1 = "a3a402a35a2f7e0b87828ccabbd5ebfbebe356b4"
uuid = "dce04be8-c92d-5529-be00-80e4d2c0e197"
version = "2.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.BangBang]]
deps = ["Compat", "ConstructionBase", "Future", "InitialValues", "LinearAlgebra", "Requires", "Setfield", "Tables", "ZygoteRules"]
git-tree-sha1 = "b15a6bc52594f5e4a3b825858d1089618871bf9d"
uuid = "198e06fe-97b7-11e9-32a5-e1d131e6ad66"
version = "0.3.36"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Baselet]]
git-tree-sha1 = "aebf55e6d7795e02ca500a689d326ac979aaf89e"
uuid = "9718e550-a3fa-408a-8086-8db961cd8217"
version = "0.1.1"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "87e84b2293559571802f97dd9c94cfd6be52c5e5"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.44.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.CompositionsBase]]
git-tree-sha1 = "455419f7e328a1a2493cabc6428d79e951349769"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.1"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f74e9d5388b8620b4cee35d4c5a618dd4dc547f4"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.3.0"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DefineSingletons]]
git-tree-sha1 = "0fba8b706d0178b4dc7fd44a96a92382c9065c2c"
uuid = "244e2a9f-e319-4986-a169-4d1fe445cd52"
version = "0.1.2"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.InitialValues]]
git-tree-sha1 = "4da0f88e9a39111c2fa3add390ab15f3a44f3ca3"
uuid = "22cec73e-a1b8-11e9-2c92-598750a2cf9c"
version = "0.3.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.MicroCollections]]
deps = ["BangBang", "InitialValues", "Setfield"]
git-tree-sha1 = "6bb7786e4f24d44b4e29df03c69add1b63d88f01"
uuid = "128add7d-3638-4c79-886c-908ea0c25c34"
version = "0.1.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Referenceables]]
deps = ["Adapt"]
git-tree-sha1 = "e681d3bfa49cd46c3c161505caddf20f0e62aaa9"
uuid = "42d2dcc6-99eb-4e98-b66c-637b7d73030e"
version = "0.1.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "Requires"]
git-tree-sha1 = "38d88503f695eb0301479bc9b0d4320b378bafe5"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "0.8.2"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SplittablesBase]]
deps = ["Setfield", "Test"]
git-tree-sha1 = "39c9f91521de844bad65049efd4f9223e7ed43f9"
uuid = "171d559e-b47b-412a-8079-5efa626c420e"
version = "0.1.14"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.ThreadsX]]
deps = ["ArgCheck", "BangBang", "ConstructionBase", "InitialValues", "MicroCollections", "Referenceables", "Setfield", "SplittablesBase", "Transducers"]
git-tree-sha1 = "d223de97c948636a4f34d1f84d92fd7602dc555b"
uuid = "ac1d9e8a-700a-412c-b207-f0111f4b6c0d"
version = "0.1.10"

[[deps.Transducers]]
deps = ["Adapt", "ArgCheck", "BangBang", "Baselet", "CompositionsBase", "DefineSingletons", "Distributed", "InitialValues", "Logging", "Markdown", "MicroCollections", "Requires", "Setfield", "SplittablesBase", "Tables"]
git-tree-sha1 = "c76399a3bbe6f5a88faa33c8f8a65aa631d95013"
uuid = "28d57a85-8fef-5791-bfe6-a80928e7c999"
version = "0.4.73"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.ZygoteRules]]
deps = ["MacroTools"]
git-tree-sha1 = "8c1a8e4dfacb1fd631745552c8db35d0deb09ea0"
uuid = "700de1a5-db45-46bc-99cf-38207098b444"
version = "0.2.2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═e03846f9-a9d4-4738-a41e-2b51273da953
# ╠═1baf279c-f230-46cf-bf08-8d00a5e3b0bc
# ╠═deb71a5a-311e-4f42-82ce-b42965cebeb4
# ╠═43cf31fa-80da-432f-9f21-8b712cddbc6b
# ╠═a70528c2-3be4-437d-840e-2452a7a9494c
# ╠═e71b7944-e2c8-11ec-0037-b57741209ebf
# ╠═564677e9-8a5b-444e-8f20-01e9e24dbf62
# ╠═93652be8-4368-48aa-8a70-34ea3befa00e
# ╠═5162f3e8-3969-4d52-920e-c761de1c30b5
# ╠═3f6a3620-23c3-4cfd-bcd0-116ab6d4bf0d
# ╠═03fa6a95-120a-4c64-9126-fec2ed7642eb
# ╠═783e6603-8bf7-49e5-acb7-934bfc5ae569
# ╠═d9ee5999-388a-48e4-92c5-b49ded4db9da
# ╠═8d19a3f8-13bc-447a-8b12-a0359af64f42
# ╠═64ed9f8c-5591-41bf-ab4e-3e4d5ad4574a
# ╠═360b7648-f365-4442-93d5-5ba540501b5b
# ╠═b79395d6-f593-47c1-bea6-4f6a4309e966
# ╠═ed770f91-de16-43bc-b3d4-72308627b5d9
# ╠═04e7cce8-74b4-43a5-a6ca-cf62d926d98f
# ╠═87649a4f-4ae5-41f4-aaf9-c2c7513eec98
# ╠═af0e7f3f-0a35-48b6-ab63-20dfc67dce8f
# ╠═dbe09310-7319-4da9-a8a7-1984365b9b07
# ╠═f3080fda-8dc2-4268-9cc1-918122727839
# ╠═97e35d3b-64eb-439a-a3fa-5f0a98319d0e
# ╠═154a5d55-b82d-4a3b-ac37-abe02a310d24
# ╠═d684189c-5bfa-462f-9ff0-eb95ec03242d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
