### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 76979c9e-0b08-4785-9329-b247a52576f4
using Primes, ThreadsX

# ╔═╡ ddcb513a-eb3a-4ab5-b094-8b49bb0baa26
md"##### Self inverses in $\mathbb{U}_p$
If $p$ is prime, 

$a^2 ≡ 1 \pmod p, 0< a < p$
$(a+1)(a-1) ≡ 0 \pmod p$
then $a=1$ or $a=p-1$, so $I(p) = 1$
"

# ╔═╡ ea1c33e7-6a28-489a-9be6-1401a758ddd6
md"##### Self inverses in $\mathbb{U}_{p^k}$
If $p$ is prime, 

$a^2 ≡ 1 \pmod {p^k}$
$(a+1)(a-1) ≡ 0 \pmod {p^k}$

Solutions are a subset of the solutions to 

$(b+1)(b-1) ≡ 0 \pmod {p}$
similar as above, $b=p^i \pm 1$ for $i=0,1,2,...,k$. 

$(b+1)(b-1) = p^i(p^i\pm2)$
If $p > 2$, then only $i=0,k$ are solutions: $a=1$ or $a=p^k-1$

If $p=2$, then $a=2^{k-1}\pm1$
"

# ╔═╡ cda311e2-ee9c-47d0-8098-fba4a92d8a3a
md"##### Self inverses in $\mathbb{U}_{pq}$
If $p$ and $q$ are coprime, then 

$a≡ 1 \pmod{p}$
$a≡-1 \pmod{q}$
Also, there exists $u$ and $v$ such that

$up+vq=1$

according to the Chinese Remainder Theorem, 

$a≡up-vq$
Same conclusion if swap $(p,q)$ to $(q,p)$.

This only gives one solution, not all solutions
"

# ╔═╡ 482f3af1-fd5f-435c-9eeb-f2c017c588ce
md"##### Self inverses in $\mathbb{U}_{2^kp}$
$a = 2^imp+1$
$a^2 = 2^{i+1}mp(2^{i-1}mp+1)+1 ≡ 1 \pmod{2^kp}$
then we have $i+1=k$ or $i=1, k\leq3$, so 

$a=2^{k-1}p+1=n/2 + 1$
or

$k=3, a=2mp+1=6p+1$
where $m < 4-1/2p$ is odd, so $m=3$ or

$k=2, a=2mp+1=2p+1$
where $m < 2-1/2p$ is odd, so $m=1$.


"

# ╔═╡ 17864715-64e0-4852-a2e0-b9dfbf51774c
md"##### Self inverses come in pairs
If $a^2≡1 \pmod p$ then $(p-a)^2≡(-a)^2≡1 \pmod p$
"

# ╔═╡ 360fabb6-d6e0-11ec-348e-ed21df0b329a
function I0(n)
	for i in n-2:-1:1
		if gcd(i, n) == 1 && i*i%n == 1
			return i
		end
	end
	1
end			

# ╔═╡ 97807c28-96bd-4d10-b362-c4d99b0f6b3f
@time I0(30030_000)

# ╔═╡ be249e60-2c98-43c9-a309-bea741dd8b22
gcdx(5, 3*7*11)

# ╔═╡ c8ca6aac-2dcc-4743-8fd8-8068efbc7b1d
(128*3 + 5*7*11)%(3*5*7*11)

# ╔═╡ 15db835b-5688-4be4-ade4-b63ba0a1cf29
gcdx(15,7)

# ╔═╡ 715e4b91-0f31-41d6-add3-3c6eb7b34eda
gcdx(3,5)

# ╔═╡ e9bd9636-7cf4-47e7-a8f6-8226aab0620b
mod((16*2-15*7), 48)

# ╔═╡ cee3c5af-55c0-4ffe-be0d-bfb5e58f5cb3
23^2%48

# ╔═╡ 7542c494-88d4-492b-b521-908c4cf858fe
25^2%48

# ╔═╡ 0cd47374-b4e7-4820-9aba-447b21f453d0
19^2%24

# ╔═╡ 40150afe-e86c-476b-b295-371d739ddc96
gcdx(3,16)

# ╔═╡ 5ed1b208-5a1e-482f-8575-44566bec5e32
# sum(I1(n) for n in 3:20_000_000)

# ╔═╡ eeaed0fc-b804-4b9f-953f-5b7a177b129c
factors(f::Primes.Factorization) = [p.first^p.second for p in f]

# ╔═╡ 72d41d97-3df6-4717-87be-f8dd27d97c30
function I1(n)
	if n == 4 return 1 end
	if n == 8 return 5 end
	r = 1
	ps = factor(n)
	fs = factors(ps)
	if ps[2] > 1
		if ps[2] == 3
			a = 6n÷fs[1] + 1
			r = r < a ? a : r
		else
			a = n÷2 + 1
			r = r < a ? a : r
		end
	end
	for m in 1:2^(length(fs)-1)-1
		a = 1
		i = 1
		while m > 0
			a *= fs[i]^(m % 2)
			m ÷= 2
			i += 1
		end
		_, u, v = gcdx(a, n÷a)
		x = mod(u*a - v*n÷a, n)
		x = max(x, n-x)
		r = (x != n-1) && (r < x) ? x : r
	end
	r
end

# ╔═╡ eceac062-569c-4c8b-a06b-590b490ef536
@time I1(30030_000)

# ╔═╡ 56842c2c-92b8-40cc-97a1-93aabd3fab9f
I1(3*5)

# ╔═╡ 093359e2-c31b-4f6b-9c40-82e9c8cc4196
I1(3*5*7)

# ╔═╡ abeb8d7f-bf0b-4eae-b26f-c0b98f5a9108
I1(3*5*7*11)

# ╔═╡ 0590f2fe-05c9-46ef-9b86-50fd37c04876
factor.(findall(I0.(3:1000) .!= I1.(3:1000)) .+2)

# ╔═╡ 56a0ea43-bee3-4562-92ed-c25b7a339d54
let
	ns = 32 .* primes(3,1000)
	factor.(ns[findall(I0.(ns) .!= I1.(ns))])
end

# ╔═╡ 200d6f8f-8453-49fe-965c-2d5e8bac5faa
I0.(2 .^(2:11)), I1.(2 .^(2:11))

# ╔═╡ 4f285b84-b747-42d2-947e-5ca6cfe4cdc6
I0.(3 .^(2:11)), I1.(3 .^(2:11))

# ╔═╡ e863dda6-d273-4009-be51-c00e21be79f4
I0(8), I1(8)

# ╔═╡ 479d6f08-ab7f-43c3-ac7d-96b51d435ff3
I0(8*125), I1(8*125)

# ╔═╡ a4b4eb16-7957-401b-92ea-8bb636f1ca1d
cI(n) = (I0(n), I1(n))

# ╔═╡ 7cdc777e-2313-40f6-8d83-ebf78d7a27f8
cI(3*2^4)

# ╔═╡ e315fe40-791b-4b9d-ae41-9594d50b7b4d
cI(3^8*5^5)

# ╔═╡ ca3d9c67-f1f7-4c0f-ab93-847b3435ec7e
cI(8)

# ╔═╡ a8c00e55-85dd-4595-98f5-38faeb1f92af
cI(19*81)

# ╔═╡ 20e53371-09f9-4b50-ad97-a13177b623c0
cI(3^10)

# ╔═╡ ca396678-9829-4a3d-83c9-22bddacec479
I0(81), I1(81)

# ╔═╡ 5cad458c-858d-4c28-bf88-97720e70865e
gcdx(7,15)

# ╔═╡ 6e06cfaf-e856-4572-b9c4-a130433659b1
64^2 % 105

# ╔═╡ 2fa758b0-05e7-4b11-86cf-d6e3d44576e3
let
	ps = factor(20_000_001)
	first(ps)
end

# ╔═╡ 275f9197-3787-4952-80ab-0e8df09202d1
prod(primes(14))

# ╔═╡ 0d1ee9ee-ca31-4caa-a8ed-d44411ed4666
3^10

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
git-tree-sha1 = "b153278a25dd42c65abbf4e62344f9d22e59191b"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.43.0"

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
# ╟─ddcb513a-eb3a-4ab5-b094-8b49bb0baa26
# ╟─ea1c33e7-6a28-489a-9be6-1401a758ddd6
# ╟─cda311e2-ee9c-47d0-8098-fba4a92d8a3a
# ╟─482f3af1-fd5f-435c-9eeb-f2c017c588ce
# ╟─17864715-64e0-4852-a2e0-b9dfbf51774c
# ╠═360fabb6-d6e0-11ec-348e-ed21df0b329a
# ╠═97807c28-96bd-4d10-b362-c4d99b0f6b3f
# ╠═eceac062-569c-4c8b-a06b-590b490ef536
# ╠═56842c2c-92b8-40cc-97a1-93aabd3fab9f
# ╠═093359e2-c31b-4f6b-9c40-82e9c8cc4196
# ╠═abeb8d7f-bf0b-4eae-b26f-c0b98f5a9108
# ╠═be249e60-2c98-43c9-a309-bea741dd8b22
# ╠═c8ca6aac-2dcc-4743-8fd8-8068efbc7b1d
# ╠═15db835b-5688-4be4-ade4-b63ba0a1cf29
# ╠═715e4b91-0f31-41d6-add3-3c6eb7b34eda
# ╠═e9bd9636-7cf4-47e7-a8f6-8226aab0620b
# ╠═cee3c5af-55c0-4ffe-be0d-bfb5e58f5cb3
# ╠═0590f2fe-05c9-46ef-9b86-50fd37c04876
# ╠═56a0ea43-bee3-4562-92ed-c25b7a339d54
# ╠═7cdc777e-2313-40f6-8d83-ebf78d7a27f8
# ╠═e315fe40-791b-4b9d-ae41-9594d50b7b4d
# ╠═ca3d9c67-f1f7-4c0f-ab93-847b3435ec7e
# ╠═7542c494-88d4-492b-b521-908c4cf858fe
# ╠═0cd47374-b4e7-4820-9aba-447b21f453d0
# ╠═40150afe-e86c-476b-b295-371d739ddc96
# ╠═a8c00e55-85dd-4595-98f5-38faeb1f92af
# ╠═20e53371-09f9-4b50-ad97-a13177b623c0
# ╠═200d6f8f-8453-49fe-965c-2d5e8bac5faa
# ╠═4f285b84-b747-42d2-947e-5ca6cfe4cdc6
# ╠═e863dda6-d273-4009-be51-c00e21be79f4
# ╠═479d6f08-ab7f-43c3-ac7d-96b51d435ff3
# ╠═a4b4eb16-7957-401b-92ea-8bb636f1ca1d
# ╠═ca396678-9829-4a3d-83c9-22bddacec479
# ╠═5ed1b208-5a1e-482f-8575-44566bec5e32
# ╠═72d41d97-3df6-4717-87be-f8dd27d97c30
# ╠═eeaed0fc-b804-4b9f-953f-5b7a177b129c
# ╠═76979c9e-0b08-4785-9329-b247a52576f4
# ╠═5cad458c-858d-4c28-bf88-97720e70865e
# ╠═6e06cfaf-e856-4572-b9c4-a130433659b1
# ╠═2fa758b0-05e7-4b11-86cf-d6e3d44576e3
# ╠═275f9197-3787-4952-80ab-0e8df09202d1
# ╠═0d1ee9ee-ca31-4caa-a8ed-d44411ed4666
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
