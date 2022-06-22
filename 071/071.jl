


function f(d)
  n = d * 3 ÷ 7
  if 7n == 3d
    n -= 1
  end
  3/7 - n/d, n ÷ gcd(n,d)  
end

let
  mg = 1
  res = 0
  for d in 999_999:-1:1
    g, rd = f(d)
    if g < mg
      mg = g
      res = rd
    end
  end
  res
end