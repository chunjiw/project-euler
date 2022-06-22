function strip0(n)
  while n % 10 == 0
    n ÷= 10
  end
  n
end

let n = 99
  p = big(1)
  for i in 1:n
    p *= strip0(i)
    p = strip0(p)
  end
  p, length(digits(p)), sum(digits(p))
end