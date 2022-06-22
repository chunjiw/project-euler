using Primes

ϕ(n) = prod(p^k - p^(k-1) for (p,k) in factor(n))

@show sum(ϕ(i) for i in 2:1000_000)