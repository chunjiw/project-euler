
def root2(n):
    a = 0
    x = 1
    r = 1
    ans = 0
    for _ in range(n):
        a = 10*a + x
        # solve for largest x such that 20*a*x + x*x <= r*100
        i, j = 0, 9
        while i < j:
            m = (i+j+1) // 2
            if 20*a*m + m*m < 100*r:
                i = m
            else:
                j = m-1
        x = j
        r = 100*r - 20*a*x - x*x
        ans += x
    return ans

def root13(n):
    a = 0
    x = 3
    r = 4
    ans = 0
    for _ in range(n):
        a = 10*a + x
        # solve for largest x such that 20*a*x + x*x <= r*100
        i, j = 0, 9
        while i < j:
            m = (i+j+1) // 2
            if 20*a*m + m*m < 100*r:
                i = m
            else:
                j = m-1
        x = j
        r = 100*r - 20*a*x - x*x
        ans += x
    return ans

print(root2(100))
print(root13(1000))