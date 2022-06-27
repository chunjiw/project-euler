using Primes

function ndivisors(m)
    f = factor(m)
    prod([p.second + 1 for p in f.pe])
end

trinum(n) = n * (n+1) ÷ 2

nd(n) = ndivisors(trinum(n))

let 
    n = 10
    while nd(n) <= 500
        n += 1
    end
    println(trinum(n))
end