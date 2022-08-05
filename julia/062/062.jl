using Combinatorics

function intcuberoot(n)
    l, r = 1, isqrt(n)
    while l <= r
        m = (l + r) ÷ 2
        if m^3 == n
            return m
        elseif m^3 < n
            l = m + 1
        else
            r = m - 1
        end
    end
end

iscube(n) = !isnothing(intcuberoot(n))
const icbrt = intcuberoot

digits2n(digits) = sum(digits[i] * 10^(i-1) for i in 1:length(digits))

let
    [i for i in 1:1000 if !iscube(i^3)] 
end

@time let
    checked = Set{Int}()
    for b in 1:999
        if b in checked
            continue
        end
        n = digits(b^3)
        s = Int[]
        for d in permutations(n)
            if last(d) != 0 && iscube(digits2n(d))
                push!(s, icbrt(digits2n(d)))
            end
        end
        if length(unique(s)) >= 3
            @show unique(s)
        end
        union!(checked, s)
    end
    @show length(checked)
end