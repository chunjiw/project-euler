
"""
Turn a/(√n - b) into i + (√n - c) / d
"""
function confrac(n, a, b)
    # @assert (a + b)^2 > n
    # @assert (n - b^2) % a == 0
    d = (n - b^2) ÷ a
    # c ≡ -b (mod d) and c is in isqrt(n)-d+1 : isqrt(n)
    x = mod(isqrt(n) + b, d)
    c = isqrt(n) - x
    # @assert (b + c) % d == 0
    i = (b + c) ÷ d
    (i, c, d)
end

function seqlen(n)
    @assert isqrt(n)^2 < n
    a, b = 1, isqrt(n)
    s = Set{Tuple{Int, Int, Int}}()
    # s = Vector{Tuple{Int, Int, Int}}()
    while true
        i, c, d = confrac(n, a, b)
        a, b = d, c
        if (i, c, d) in s
            break
        else
            push!(s, (i, c, d))
        end
    end
    length(s)
end

@time let
    cnt = 0
    for n in 2:10000
        isqrt(n)^2 == n && continue
        if isodd(seqlen(n))
            cnt += 1
        end
    end
    @show cnt
end