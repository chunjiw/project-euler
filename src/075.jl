# using https://en.wikipedia.org/wiki/Pythagorean_triple#A_variant


l(m, n) = m * (m+n)
ls(m, n, limit) = l(m,n) : l(m,n) : limit


@time let 
    limit = 1_500_000
    d = Dict{Int, Int}()
    for m in 3:2:limit
        for n in 1:2:m-1
            l(m, n) > limit && break
            gcd(m, n) > 1 && continue
            k = l(m, n)
            while k <= limit
                d[k] = get!(d, k, 0) + 1
                k += l(m, n)
            end
        end
    end
    @show count(d[k] == 1 for k in keys(d))
end