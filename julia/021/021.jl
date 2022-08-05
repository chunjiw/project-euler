using BenchmarkTools
using Primes

function divisors(n)
  n == 1 && return [1]
  res = [1]
  for d in 2:isqrt(n)
    if n % d == 0
      push!(res, d)
      if n ÷ d != d
        push!(res, n ÷ d)
      end
    end
  end
  res
end

function pdivisers(n)
  fs = factor(n)
  res = [1]
  for p in fs
    nextres = Int[]
    for r in res
      for i in 0:p.second
        push!(nextres, r * p.first^i)
      end
    end
    res = nextres
  end
  res
end
      
function isamicable(n)
  sd = sumdivisors(n)
  sd != n && sumdivisors(sd) == n
end


# @time divisors(10_000_000)
# @time pdivisers(10_000_000)

sumdivisors(n) = sum(divisors(n))

@show sumdivisors(220)
@show sumdivisors(284)
@show isamicable(220)
@show isamicable(284)
@show isamicable(10000)

@show sum(i for i in 1:9999 if isamicable(i))
