class Solution:

    def array(self, num):
        arr = []
        while num:
            arr.append(num % 10)
            num //= 10
        return arr

    def isPalin(self, num):
        arr = self.array(num)
        i, j = 0, len(arr) - 1
        while i < j:
            if arr[i] != arr[j]:
                return False
            i += 1
            j -= 1
        return True
    
    def reverse(self, num):
        arr = self.array(num)
        ans = 0
        for d in arr:
            ans *= 10
            ans += d
        return ans

    def addreverse(self, num):
        return num + self.reverse(num)

    def isLychrel(self, num):
        num = self.addreverse(num)
        count = 1
        while count < 50 and not self.isPalin(num):
            num = self.addreverse(num)
            count += 1
        return not self.isPalin(num)

sol = Solution()
sol.isLychrel(349)
print(len([num for num in range(10000) if sol.isLychrel(num)]))