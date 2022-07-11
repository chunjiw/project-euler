using DelimitedFiles

m = [
    131 673 234 103 18
    201 96 342 965 150
    630 803 746 422 111
    537 699 497 121 956
    805 732 524 37 331
]

# this is DFS. BFS should be faster
function walk!(n, m, i, j)
    @show i, j
    for (ni, nj) in neighbors(i, j, size(n)...)
        if n[ni, nj] > n[i, j] + m[ni, nj]
            n[ni, nj] = n[i, j] + m[ni, nj]
            walk!(n, m, ni, nj)
        end
    end
end

function neighbors(i, j, h, w)
    res = Vector{Tuple{Int, Int}}()
    i > 1 && push!(res, (i-1, j))
    i < h && push!(res, (i+1, j))
    j > 1 && push!(res, (i, j-1))
    j < w && push!(res, (i, j+1))
    res
end

function pathsum_dfs(m)
    n = fill(typemax(Int), size(m))
    n[1] = m[1]
    walk!(n, m, 1, 1)
    n[end]
end

function pathsum(m)
    n = fill(typemax(Int), size(m))
    n[1] = m[1]
    front = Vector{Tuple{Int, Int}}()
    nextfront = Vector{Tuple{Int, Int}}()
    push!(front, (1,1))
    while !isempty(front) || !isempty(nextfront)
        while !isempty(front)
            i, j = pop!(front)
            for (ni, nj) in neighbors(i, j, size(m)...)
                if n[ni, nj] > n[i, j] + m[ni, nj]
                    n[ni, nj] = n[i, j] + m[ni, nj]
                    push!(nextfront, (ni, nj))
                end
            end
        end
        front, nextfront = nextfront, front
    end
    n[end]
end

@show pathsum(m)

mfile = download("https://projecteuler.net/project/resources/p083_matrix.txt")
m = readdlm(mfile, ',', Int, '\n')
@show @time pathsum(m)