using DelimitedFiles

mlink = "https://projecteuler.net/project/resources/p081_matrix.txt"
mfile = download(mlink)
m = readdlm(mfile, ',', Int, '\n')

function pathsum(m)
    n = zeros(Int, size(m))
    n[1] = m[1]
    h, w = size(m)
    for i in eachindex(m)
        i == 1 && continue
        if i % h == 1
            n[i] = n[i-h] + m[i]
        elseif i <= h
            n[i] = n[i-1] + m[i]
        else
            n[i] = m[i] + (n[i-1] < n[i-h] ? n[i-1] : n[i-h])
        end
    end
    n
end

m0 = [
    131 673 234 103 18
    201 96 342 965 150
    630 803 746 422 111
    537 699 497 121 956
    805 732 524 37 331
]

@show pathsum(m0)[end]
@show pathsum(m)[end]