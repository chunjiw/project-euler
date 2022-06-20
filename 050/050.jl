using Pkg
Pkg.activate(".")
using Primes, OffsetArrays

sum(prime(i) for i in 1:500)

from = 1:10
to = 541:550
A = OffsetArray(ones(Int, length(from), length(to)), from, to)

for i in from, j in to
    p = sum(prime(k) for k in i:j)
    A[i,j] = isprime(p) ? p : 0
end

