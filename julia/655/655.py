import numpy as np
import time

def f(k, m): # counts palindromes divisible by m with k, k-2, k-4,... digits
    A = [10**i % m for i in range(k)]
    B = [(A[i] + A[-(i+1)]) % m for i in range(k//2)]
    if k % 2 == 1:
        B.append(A[k//2])
    # V = np.array([1] + [0]*(m-1))
    V = np.zeros(m, dtype=np.uint32)
    V[0] = 1
    for x in B:
        W = np.copy(V)
        for d in range(1, 10):
            i = x*d % m
            if i > 0:
                V[:i] += W[-i:]
                V[i:] += W[:-i]
            else:
                V += W
    return V[0] - 1

def main(k, m):
    return f(k, m) + f(k-1, m)

if __name__ == "__main__":
    t0 = time.time()
    print(main(32, 10000019))
    print(time.time() - t0)