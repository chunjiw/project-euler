### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# ╔═╡ 756de4b0-2e80-4e82-abcd-f8a5bd8f6189
# function fromdigits(ds; base=10)
# 	n = 0
# 	m = 1
# 	for d in ds
# 		n += m * d
# 		m *= base
# 	end
# 	n
# end

# ╔═╡ 69f98bac-81f9-41bf-be03-3b972a743c57
fromdigits(digits; base=10) = sum(digits[k]*base^(k-1) for k=1:length(digits))

# ╔═╡ e7070cbb-72c0-49ca-85a0-bd5e26b510ae
hit(n) = sort!(digits(n)) == sort!(digits(2n)) == sort!(digits(3n)) == sort!(digits(4n)) == sort!(digits(5n)) == sort!(digits(6n))

# ╔═╡ 35d900fc-e5de-11ec-1ed4-a1e888586d15
let
	for d in 3:6
		for i in 10^(d-1) : 10^(d-1) + 7*10^(d-2)
			if hit(i)
				@show i
			end
		end
	end
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
# ╠═756de4b0-2e80-4e82-abcd-f8a5bd8f6189
# ╠═69f98bac-81f9-41bf-be03-3b972a743c57
# ╠═35d900fc-e5de-11ec-1ed4-a1e888586d15
# ╠═e7070cbb-72c0-49ca-85a0-bd5e26b510ae
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
