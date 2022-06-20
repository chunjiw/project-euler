import time
import numpy as np
import random

t0 = time.time()
m = 10000019
v = np.array([0]*m)
w = np.copy(v)
for _ in range(100):
    i = random.randint(0, m-1)
    if i > 0:
        v[:i] += w[-i:]
        v[i:] += w[:-i]
    else:
        v += w
print(time.time() - t0)
