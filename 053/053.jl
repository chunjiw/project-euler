function p53(n)
  r = 1
  while r <= n ÷ 2 && binomial(n, r) <= 1000_000
    r += 1
  end
  r <= n ÷ 2 ? n - 2r + 1 : 0
end

@show sum(p53(n) for n in 1:100)