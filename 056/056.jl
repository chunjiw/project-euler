let m = 0
  for a in 1:99, b in 1:99
    s = sum(digits(big(a)^b)) 
    m = m < s ? s : m
  end
  m
end
