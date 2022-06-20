### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ 3d898365-b128-43cd-917e-f40d3c649ee8
# function powermod(i, b=10, m=10_000_019)
# 	res = 1
# 	while i > 10
# 		res *= b^10 % m 
# 		res %= m
# 		i -= 10
# 	end
# 	res *= b^i % m
# 	res % m
# end

# ╔═╡ 96066055-0b45-485c-8bd4-5be4ba3ac4cc
let k = 32, m = 10_000_019
	[[BigInt(10)^i % m for i in 0:k-1] [10^i % m for i in 0:k-1] [powermod(10,i,m) for i in 0:k-1]]
end

# ╔═╡ 2cb2598c-e2fb-11ec-0f7c-7762d6ec7ae8
function countdp(k, m = 10_000_019)
	A = [powermod(10, i, m) for i in 0:k-1]
	B = [(A[i] + A[end-i+1]) % m for i in 1:k÷2]
	if k % 2 == 1
		push!(B, A[k÷2+1])
	end
	V = fill(0, m)
	V[1] = 1
	for x in B
		W = copy(V)
		for d in 1:9
			i = x * d % m 
			V[1:i] .+= @view W[end-i+1:end]
			V[i+1:end] .+= @view W[1:end-i]
		end
	end
	V[1] - 1
end

# ╔═╡ 73f595c2-7752-4665-9097-fe4a904d0c60
countdp(32) + countdp(31)

# ╔═╡ 5908e637-508e-4cd2-8342-c7488b1d6171
@time countdp(30)

# ╔═╡ 35d3416a-057f-459e-b4a3-698ce217b253
countdp(16)

# ╔═╡ 6b978300-bd73-4c57-8dfc-198342237f5d
@code_warntype countdp(16)

# ╔═╡ 2415c3db-7573-40db-9d37-189b5f5e2c2f
let k = 4, m = 109
	A = [powermod(10, i, m) for i in 0:k-1]
	B = [(A[i] + A[end-i+1]) % m for i in 1:k÷2]
	if k % 2 == 1
		push!(B, A[k÷2+1])
	end
	V = fill(0, m)
	V[1] = 1
	for x in B
		W = copy(V)
		for d in 9:-1:1
			i = x * d % m 
			V[1:i] .+= W[end-i+1:end]
			V[i+1:end] .+= W[1:end-i]
		end
	end
	V[1] - 1
end

# ╔═╡ b2058ae0-ecf5-432c-a31d-872574290079
a = collect(1:10)

# ╔═╡ 8ccc0a9a-42dc-4f12-bf4b-ea6c2daacdf8
a[end+1:end]

# ╔═╡ 75bddda6-298d-4cd1-bdfb-73891b96eba9
1001 % 109

# ╔═╡ 281a2f6b-41fb-4b2d-8a22-371468b0bef8


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
# ╠═3d898365-b128-43cd-917e-f40d3c649ee8
# ╠═96066055-0b45-485c-8bd4-5be4ba3ac4cc
# ╠═2cb2598c-e2fb-11ec-0f7c-7762d6ec7ae8
# ╠═73f595c2-7752-4665-9097-fe4a904d0c60
# ╠═5908e637-508e-4cd2-8342-c7488b1d6171
# ╠═35d3416a-057f-459e-b4a3-698ce217b253
# ╠═6b978300-bd73-4c57-8dfc-198342237f5d
# ╠═2415c3db-7573-40db-9d37-189b5f5e2c2f
# ╠═b2058ae0-ecf5-432c-a31d-872574290079
# ╠═8ccc0a9a-42dc-4f12-bf4b-ea6c2daacdf8
# ╠═75bddda6-298d-4cd1-bdfb-73891b96eba9
# ╠═281a2f6b-41fb-4b2d-8a22-371468b0bef8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
