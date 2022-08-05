# Define f(m, n), m >= n, to be the number of ways of sum to m start with n.
# f(m, 1) = f(m, m-1) = f(m, m) = 1
# f(m, n) = sum( f(m-n, i) for i in 1:min(n, m-n) )
# e.g. f(5, 3) = f(2, 2) + f(2, 1)
# e.g. f(5, 2) = f(3, 2) + f(3, 1)

table = fill(-1, 100, 100)

function f(m, n)
    (m == 1 || n == 1 || n == m - 1 || n == m) && return 1
    table[m, n] > -1 && return table[m, n]
    table[m, n] = sum( f(m-n, i) for i in 1:min(n, m-n))
    table[m, n]
end

f(m) = m < 2 ? 0 : sum(f(m, i) for i in 1:m-1)

for m in 1:5
    @show m, f(m)
end

@show @time f(100)