inveuc(p, q, a) = q, a*q + p

@time let n = 100
    seqe = fill(1, n - 1)
    seqe[2 : 3 : n-1] .= 2 : 2 : 2*(length(2:3:n-1))
    p, q = big(0), big(1)
    for a in reverse!(seqe)
        p, q = inveuc(p, q, a)
    end
    @show sum(digits(p+2q))
end