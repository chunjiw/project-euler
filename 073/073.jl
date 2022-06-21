function countbetween(d)
    cnt = 0
    l = d ÷ 3 + 1
    r = d % 2 == 0 ? d ÷ 2 - 1 : d ÷ 2
    for n in l:r
        cnt += gcd(n, d) == 1 ? 1 : 0
    end
    cnt
end

f(n) = sum(countbetween(i) for i in 2:n)

@show countbetween(8)
@show f(8)

@show f(12000)