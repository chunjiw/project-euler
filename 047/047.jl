using Primes

lendis(n) = length(factor(n))

found(n) = lendis(n) == lendis(n+1) == lendis(n+2) == lendis(n+3) == 4

@show found(644)

let
  n = 1
  while !found(n)
    n += 1
  end
  @show n
end