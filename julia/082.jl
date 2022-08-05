m = [
    131 673 234 103 18
    201 96 342 965 150
    630 803 746 422 111
    537 699 497 121 956
    805 732 524 37 331
]

function pathsum(m)
    n = zeros(Int, size(m))
    h, w = size(m)
    n[1:h] .= m[1:h]
    for j in 2:w
        n[:, j] .= n[:, j-1] .+ m[:, j]
        n0 = copy(n[:, j])
        for i1 in 1:h, i2 in i1+1:h
            n[i2, j] = min(n[i2, j], n0[i1] + sum(m[i1+1:i2, j]))
            n[i1, j] = min(n[i1, j], n0[i2] + sum(m[i1:i2-1, j]))
        end
    end
    minimum(n[:, end])
end

@show pathsum(m)

using DelimitedFiles
mlink = "https://projecteuler.net/project/resources/p082_matrix.txt"
mfile = download(mlink)
m = readdlm(mfile, ',', Int, '\n')

@show pathsum(m)