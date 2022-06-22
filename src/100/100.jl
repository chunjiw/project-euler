# https://math.stackexchange.com/questions/1139749/can-we-predict-when-a-polynomial-can-take-more-than-one-perfect-square-value
# https://en.wikipedia.org/wiki/Pell%27s_equation#Fundamental_solution_via_continued_fractions

p(b, r) = b/(b+r) * (b-1)/(b+r-1)

println(p(15, 6))
println(p(85, 35))

N = 1_000_000_000_000

delta(b) = 8b^2 - 8b + 1
issq(s) = isqrt(s)^2 == s

"""
    bsearch(N)
Search for b that yields integer r, and satisfy b+r > N, where
b(b-1)/(b+r)/(b+r-1) = 1/2
"""
function bsearch(N)
    left = 100
    right = N ÷ 2
    b = 0
    while left < right
        b = (left + right) ÷ 2
        if delta(b-1) <= (2N-1)^2 <= delta(b)
            return b
        elseif delta(b) < (2N-1)^2
            left = b + 1
        elseif delta(b-1) > (2N-1)^2
            right = b - 1
        else
            throw(error("what happened?"))
        end
    end
    b
end

# bmin = bsearch(N)
for b in 1:2:bmin
    if issq(delta(BigInt(b)))
        println(b, " ", isqrt(delta(b)) ÷ 2 - b + 1)
    end
end

