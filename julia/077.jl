# Define f(m, n), m >= n, to be the number of ways of sum (of primes) to m start with n.

# For a prime p, f(p, p) = 1
# f(n, 2) = 1 - (n % 2)
# f(n, p) = sum(f(n - p, q) for q in previous primes of p (including p))


using Primes


function f(n, p)
    @assert isprime(p)
    p == 2 && return 1 - n % 2
    n == p && return 1
    n < p && return 0
    m = n - p
    s = 0
    while true
        s += f(m, p)
        p == 2 && break
        p = prevprime(p-1)
    end
    s
end

function f(n)
    p = prevprime(n)
    s = 0
    while true
        s += f(n, p)
        p == 2 && break
        p = prevprime(p-1)
    end
    isprime(n) ? s - 1 : s
end

f(70)
f(71)
