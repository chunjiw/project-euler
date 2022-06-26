using OffsetArrays

keylogfile = download("https://projecteuler.net/project/resources/p079_keylog.txt")

f = Vector{Set{Int}}(undef, 10)
for i in 1:10
    f[i] = Set()
end
follower = OffsetVector(f, 0:9)


open(keylogfile, "r") do io
    for l in readlines(io)
        @show a, b, c = parse.(Int, [l[i] for i in 1:3])
        push!(follower[a], b)
        push!(follower[b], c)
    end
end

follower