issqrt(n) = n == isqrt(n)^2

function minx(d)
    d % 50 == 0 && @show d
    issqrt(d) && return (0,0)
    y = big(1)
    while !issqrt(d*y^2 + 1)
        y += 1
    end
    d, isqrt(d*y^2 + 1)
end

@show mx = minx.(1:1000)
@show findmax(x -> x[2], mx)  