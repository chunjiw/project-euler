### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# ╔═╡ 04d240a4-e5ef-11ec-10d1-a7b510b2d66b
tri3(n) = n*(n+1)÷2

# ╔═╡ 0ce29e79-7182-4470-9525-bf41bd011259
squ4(n) = n*n

# ╔═╡ 800e79a1-701e-4fa9-a37a-4f182a4a2fc7
pen5(n) = n*(3n-1)÷2

# ╔═╡ 03dc5151-39e9-449e-9d60-eae1748e8482
hex6(n) = n*(2n-1)

# ╔═╡ 9d2fc79a-2212-4610-a061-372e5567ef4a
hep7(n) = n*(5n-3)÷2

# ╔═╡ 9c368624-6ded-4148-bd75-b8f4c176003c
oct8(n) = n*(3n-2)

# ╔═╡ 41f647c4-6b88-4ef2-9d18-330b0d8081cc
begin
	p3 = [tri3(n) for n in 1:200 if 1000 <= tri3(n) <= 9999]
	p4 = [squ4(n) for n in 1:200 if 1000 <= squ4(n) <= 9999]
	p5 = [pen5(n) for n in 1:200 if 1000 <= pen5(n) <= 9999]
	p6 = [hex6(n) for n in 1:200 if 1000 <= hex6(n) <= 9999]
	p7 = [hep7(n) for n in 1:200 if 1000 <= hep7(n) <= 9999]
	p8 = [oct8(n) for n in 1:200 if 1000 <= oct8(n) <= 9999]
end

# ╔═╡ 854854a6-40ce-4e29-be9d-15fb1a26bb7a
first2of4(n) = n ÷ 100

# ╔═╡ cfe39732-cb93-4f0b-961b-9abddf5a8272
last2of4(n) = n % 100

# ╔═╡ a15fdff4-cfac-411e-a973-78970072768b
function grow!(s, l=fill(false,6), ps=[p3, p4, p5, p6, p7, p8])
	if length(s) >= 6
		if first2of4(first(s)) == last2of4(last(s))
			@show s, sum(s)
		end
		return
	end
	if isempty(s)
		for n in ps[1]
			push!(s, n)
			l[1] = true
			grow!(s, l)
			l[1] = false
			pop!(s)
		end
	else
		tar = last2of4(last(s))
		for p in findall(l .== false)
			indices = findall(x -> first2of4(x) == tar, ps[p])
			for i in indices
				push!(s, ps[p][i])
				l[p] = true
				grow!(s, l)
				l[p] = false
				pop!(s)
			end
		end
	end
end

# ╔═╡ 308772d5-5b6c-4e2e-ae3f-764c49c6ace1
grow!(Int[])

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
# ╠═04d240a4-e5ef-11ec-10d1-a7b510b2d66b
# ╠═0ce29e79-7182-4470-9525-bf41bd011259
# ╠═800e79a1-701e-4fa9-a37a-4f182a4a2fc7
# ╠═03dc5151-39e9-449e-9d60-eae1748e8482
# ╠═9d2fc79a-2212-4610-a061-372e5567ef4a
# ╠═9c368624-6ded-4148-bd75-b8f4c176003c
# ╠═41f647c4-6b88-4ef2-9d18-330b0d8081cc
# ╠═854854a6-40ce-4e29-be9d-15fb1a26bb7a
# ╠═cfe39732-cb93-4f0b-961b-9abddf5a8272
# ╠═a15fdff4-cfac-411e-a973-78970072768b
# ╠═308772d5-5b6c-4e2e-ae3f-764c49c6ace1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
