### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 51efcdac-d4a4-11ec-01f6-0b9f4fbe32ae
using StaticArrays

# ╔═╡ 6f0bdb76-17e3-4ad7-be6d-bdee017f4d5c
begin
	import Base: isempty, length, iterate, getindex, setindex!, show
	
	struct DigitsCount
		count::MVector{10, Int}
	    function DigitsCount(iter)
	        digits = new(zeros(Int, 10))
	        for i in iter
	            digits[i] += 1
	        end
	        digits
	    end
	    DigitsCount() = DigitsCount([])
	end
	
	isempty(d::DigitsCount) = sum(d.count) == 0
	
	function iterate(d::DigitsCount)
	    i = findfirst(d.count .> 0)
	    isnothing(i) ? nothing : (
			i == 10 ? (0, 11) : (i, i + 1)
		)
	end
	function iterate(d::DigitsCount, state)
	    i = findfirst(d.count[state:end] .> 0)
	    isnothing(i) ? nothing : (
			i + state - 1 == 10 ? (0, 11) : (i + state - 1, i + state)
		)
	end
	
	length(d::DigitsCount) = count(d.count .> 0)

	getindex(d::DigitsCount, i) = i == 0 ? d.count[10] : d.count[i]
	function setindex!(d::DigitsCount, v, i)
	    i = i == 0 ? 10 : i
	    d.count[i] = v
	end
	
	function show(io::IO, d::DigitsCount)
		write(io, "digit - 1 2 3 4 5 6 7 8 9 0\n")
		write(io, "count - ")
		write(io, join(["$i " for i in d.count]))
	end
end;

# ╔═╡ 649e588d-0265-48d8-b280-c5abf64d22f5
let
	a = DigitsCount(0)
	[i for i in a]
end

# ╔═╡ 5195c192-15a7-46e6-8024-4ace71614c5d
nsol(d::DigitsCount) = sum(d.count)

# ╔═╡ bd35fcae-4f09-4a1d-9f25-409e6513b801
function nextup(digits)
    if isempty(digits) return DigitsCount(1:9) end
    newd = DigitsCount()
    for d in digits, di in d:9
        newd[di] += digits[d]
    end
    newd
end

# ╔═╡ 3f9a2d4b-c775-40ab-93f3-026627e0ea2a
let
	a = DigitsCount()
	a[7] = 1
	a
	a = nextup(a)
	a = nextup(a)
	a = nextup(a)
end

# ╔═╡ 4f956ae1-1ab9-4675-b839-31128b55f78e
function nextdown(digits)
    if isempty(digits) return DigitsCount(1:9) end
    newd = DigitsCount()
    for d in digits, di in 0:d
        newd[di] += digits[d]
    end
    newd
end

# ╔═╡ b8eb2bb3-c336-40b7-a5cb-f57de6d6c19d
function bouncyat(dn)
    res1 = DigitsCount()
    res2 = DigitsCount()
    for _ in 1:dn
        res1 = nextup(res1)
        res2 = nextdown(res2)
    end
    nsol(res1) + nsol(res2) - 9
end

# ╔═╡ a47514f7-5fe9-4b81-8b78-8a65088e0c8c
bouncyat(3)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[compat]
StaticArrays = "~1.4.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

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

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "cd56bf18ed715e8b09f06ef8c6b781e6cdc49911"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.4"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
"""

# ╔═╡ Cell order:
# ╠═51efcdac-d4a4-11ec-01f6-0b9f4fbe32ae
# ╠═6f0bdb76-17e3-4ad7-be6d-bdee017f4d5c
# ╠═3f9a2d4b-c775-40ab-93f3-026627e0ea2a
# ╠═649e588d-0265-48d8-b280-c5abf64d22f5
# ╠═a47514f7-5fe9-4b81-8b78-8a65088e0c8c
# ╠═5195c192-15a7-46e6-8024-4ace71614c5d
# ╠═bd35fcae-4f09-4a1d-9f25-409e6513b801
# ╠═4f956ae1-1ab9-4675-b839-31128b55f78e
# ╠═b8eb2bb3-c336-40b7-a5cb-f57de6d6c19d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
