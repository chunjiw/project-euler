function ispalindrome(i)
    s = string(i)
    len = length(s)
    l, r = 1, len
    while l <= r
        if s[l] != s[r]
            return false
        end
        l += 1
        r -= 1
    end
    return true
end

# println(ispalindrome(1))
# println(ispalindrome(10))
# println(ispalindrome(101))
# println(ispalindrome(1001))

let 
    r = 0
    for i in 101:999, j in 101:999
        if ispalindrome(i*j)
            r = r < i*j ? i*j : r
            # println(i*j)
        end
    end
    println(r)
end