function prevfrac(n, d, md)
    l = md ÷ d
    n = l*n
    d = l*d
    ni = n - 1
    di = d - 1
    while ni * d < n * di
        di -= 1
    end
    (ni, di + 1)
end

@show prevfrac(3, 7, 8)
@show prevfrac(3, 7, 1000_000)
@show prevfrac(1, 1, 8)
@show prevfrac(1, 8, 8)

@show prevfrac(2, 3, 8)   # should be 5/8
@show prevfrac(3, 5, 8)   # shoold be 4/7

function countfrac(md)
    cnt = 0
    n, d = 1, 1
    while n > 0
        @show n, d = prevfrac(n, d, md)
        cnt += 1
    end
    cnt
end

@show countfrac(8)