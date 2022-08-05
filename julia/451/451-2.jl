### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 20356332-6a58-4d5c-a0f9-dea2cf04f0b3
using ThreadsX

# ╔═╡ f030e424-0e88-4c0b-8b1d-5a7e00f49d0e
using Primes

# ╔═╡ 0c14f4d5-cce7-4ecc-96c5-a7384c9b75c4
md"### Self inverses in $\mathbb{U}_{ab}, a\perp b$
If $x^2 \equiv 1 \pmod {ab}$ then

$x^2 \equiv 1 \pmod {a}$
$x^2 \equiv 1 \pmod {b}$
Then if we know $x$ in $\mathbb{U}_a$ and $\mathbb{U}_b$, we can get $x$ in $\mathbb{U}_{ab}$. 
This offers a reduction method to look for $x$.
"

# ╔═╡ 41623696-d76f-4e0f-be72-b71da54c9435
begin
	selfinv = Dict{Int64, Vector}()
end

# ╔═╡ bd4f4089-06b4-4c2e-8ad1-b4ed9ed3ad59
Dict(1=>2) |> typeof

# ╔═╡ e97ba6ea-d118-47fc-a061-90ed0abf49c9
8*3*5^4*13*19

# ╔═╡ 9b6348ae-b0d2-4433-ab2a-a291354fbdc2
function root(a, b, ra=1, rb=-1)
	d, u, v = gcdx(a, b)
	@assert d == 1
	mod(rb*u*a + ra*v*b, a*b)
end

# ╔═╡ aaa5663b-bded-49d0-8b66-308b471f5e56
function rootm(a, b, ra::AbstractVector=[], rb::AbstractVector=[])
	res = Int64[]
	for ai in ra, bi in rb
		r = root(a, b, ai, bi)
		push!(res, r, a*b-r)
	end
	unique(res)
end

# ╔═╡ 62621a2a-dd62-11ec-0464-1fae769ad41d
function I0(n)
	for i in n-2:-1:1
		if gcd(i, n) == 1 && i*i%n == 1
			return i
		end
	end
	1
end		

# ╔═╡ f9760fde-98fe-4d76-91e8-2067a19c7650
factors(f::Primes.Factorization) = [p.first^p.second for p in f]

# ╔═╡ 7ea13e6f-2821-4127-ae7a-059c1b2f6faa
function I2(n)
	fs = factors(factor(n))
	if length(fs) == 1
		if iseven(first(fs))
			n < 8 ? 1 : n÷2+1
		else
			1
		end
	else
		a = first(fs)
		ra = iseven(a) && a > 4 ? [1, a÷2-1, a÷2+1, a-1] : [1, -1]
		for b in fs[2:end]
			ra = rootm(a, b, ra, [1, -1])
			a = a*b
		end
		sort!(ra)
		ra[end-1]
	end
end

# ╔═╡ 6a586b4a-4e6a-406b-8311-8965df3c5e8f
@time sum(I2.(3:20_000_000))

# ╔═╡ 006dbf85-52a0-4f10-a4b7-b2f4157c45ed
@time ThreadsX.sum(I2(i) for i in 3:20_000_000)

# ╔═╡ ae730463-1b73-46c0-a1ab-6a09eabe063a
function I1(n, selfinv=selfinv)
	fs = factors(factor(n))
	if length(fs) == 1
		if iseven(first(fs))
			n < 8 ? 1 : n÷2+1
		else
			1
		end
	else
		a = first(fs)
		ra = iseven(a) && a > 4 ? [1, a÷2-1, a÷2+1, a-1] : [1, -1]
		res = Int64[]
		for b in fs[2:end]
			res = get!(selfinv, a*b, rootm(a, b, ra, [1, -1]))
			a = a*b
			ra = res
		end
		sort!(res)
		res[end-1]
	end
end

# ╔═╡ 7bdb9250-d7d0-492b-ba2b-f438e32aa388
any(I0.(3:1000) .!= I1.(3:1000))

# ╔═╡ f4609f0c-09bc-43e1-ba0c-3910cab3c6db
cI(n) = (I0(n), I1(n))

# ╔═╡ 4f3e8ba0-22be-4df0-9f87-6fa9d066a690
@time cI(8*3*5^4*13*19)

# ╔═╡ 171f6346-8c5d-44ef-9f94-dc6749b92177
@time sum(I1.(3:20_000_000))

# ╔═╡ 797f2234-dc3f-4b9f-bf84-1c552fa87b68
@time I1(20_000_001)

# ╔═╡ 3b3a6bc8-de07-4643-a7c1-a50424ec0ce9
let n = 8*3*5
	fs = factors(factor(n))
	if length(fs) == 1
		if iseven(first(fs))
			n < 8 ? 1 : n÷2+1
		else
			1
		end
	else
		a = first(fs)
		ra = iseven(a) && a > 4 ? [1, a÷2-1, a÷2+1, a-1] : [1, -1]
		res = Int64[]
		for b in fs[2:end]
			rb = [1, -1]
			@show a, b
			@show res = rootm(a, b, ra, rb)
			@show sort!(res)
			@show res.^2 .% (a*b)
			a = a*b
			ra = res
		end
		sort!(res)
		res[end-1]
	end
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
ThreadsX = "ac1d9e8a-700a-412c-b207-f0111f4b6c0d"

[compat]
Primes = "~0.5.2"
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

[[deps.IntegerMathUtils]]
git-tree-sha1 = "f366daebdfb079fd1fe4e3d560f99a0c892e15bc"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.0"

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

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "747f4261ebe38a2bc6abf0850ea8c6d9027ccd07"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.2"

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
# ╟─0c14f4d5-cce7-4ecc-96c5-a7384c9b75c4
# ╠═7bdb9250-d7d0-492b-ba2b-f438e32aa388
# ╠═f4609f0c-09bc-43e1-ba0c-3910cab3c6db
# ╠═4f3e8ba0-22be-4df0-9f87-6fa9d066a690
# ╠═171f6346-8c5d-44ef-9f94-dc6749b92177
# ╠═6a586b4a-4e6a-406b-8311-8965df3c5e8f
# ╠═006dbf85-52a0-4f10-a4b7-b2f4157c45ed
# ╠═797f2234-dc3f-4b9f-bf84-1c552fa87b68
# ╠═41623696-d76f-4e0f-be72-b71da54c9435
# ╠═bd4f4089-06b4-4c2e-8ad1-b4ed9ed3ad59
# ╠═e97ba6ea-d118-47fc-a061-90ed0abf49c9
# ╠═7ea13e6f-2821-4127-ae7a-059c1b2f6faa
# ╠═ae730463-1b73-46c0-a1ab-6a09eabe063a
# ╠═3b3a6bc8-de07-4643-a7c1-a50424ec0ce9
# ╠═9b6348ae-b0d2-4433-ab2a-a291354fbdc2
# ╠═aaa5663b-bded-49d0-8b66-308b471f5e56
# ╠═62621a2a-dd62-11ec-0464-1fae769ad41d
# ╠═f9760fde-98fe-4d76-91e8-2067a19c7650
# ╠═20356332-6a58-4d5c-a0f9-dea2cf04f0b3
# ╠═f030e424-0e88-4c0b-8b1d-5a7e00f49d0e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
