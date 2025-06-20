from math import gcd

def numdigits(n):
    res = 0
    while n:
        n //= 10
        res += 1
    return res


a, b = 2, 1
counter = 0
for _ in range(999):
    a, b = 2*a+b, a
    g = gcd(a, b)
    a //= g
    b //= g
    if numdigits(a+b) > numdigits(a):
        counter += 1
print(counter)