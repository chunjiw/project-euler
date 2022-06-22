using Primes

function ϕ(n)
  fs = factor(n)
  res = 1
  for (p,k) in fs
    res *= p^k - p^(k-1)
  end
  res
end

function f(n)
  fs = factor(n)
  res = 1
  for (p,k) in fs
    res *= p / (p-1)
  end
  res
end




let n = 8319823
  ϕ(n), factor(n), f(n)
end

@time let 
  mf = typemax(Float64)
  res = 0
  for n in 2:9999_999
    if sort!(digits(n)) == sort!(digits(ϕ(n)))
      if f(n) < mf
        mf = f(n)
        res = n      
      end
    end
  end
  @show res, factor(res)
end


