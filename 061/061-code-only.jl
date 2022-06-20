tri3(n) = n*(n+1)÷2

squ4(n) = n*n

pen5(n) = n*(3n-1)÷2

hex6(n) = n*(2n-1)

hep7(n) = n*(5n-3)÷2

oct8(n) = n*(3n-2)

begin
    p3 = [tri3(n) for n in 1:200 if 1000 <= tri3(n) <= 9999]
    p4 = [squ4(n) for n in 1:200 if 1000 <= squ4(n) <= 9999]
    p5 = [pen5(n) for n in 1:200 if 1000 <= pen5(n) <= 9999]
    p6 = [hex6(n) for n in 1:200 if 1000 <= hex6(n) <= 9999]
    p7 = [hep7(n) for n in 1:200 if 1000 <= hep7(n) <= 9999]
    p8 = [oct8(n) for n in 1:200 if 1000 <= oct8(n) <= 9999]
end

first2of4(n) = n ÷ 100

last2of4(n) = n % 100

function grow!(s, l=fill(false,6), ps=[p3, p4, p5, p6, p7, p8])
    if length(s) >= 6
        if first2of4(first(s)) == last2of4(last(s))
            @show s, sum(s)
        end
        return
    end
    if isempty(s)
        for n in ps[1]
            push!(s, n)
            l[1] = true
            grow!(s, l)
            l[1] = false
            pop!(s)
        end
    else
        tar = last2of4(last(s))
        for p in findall(l .== false)
            indices = findall(x -> first2of4(x) == tar, ps[p])
            for i in indices
                push!(s, ps[p][i])
                l[p] = true
                grow!(s, l)
                l[p] = false
                pop!(s)
            end
        end
    end
end

grow!(Int[])
