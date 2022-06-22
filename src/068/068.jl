# Sum of inner 5: A
# Sum of outter 5: B
# 2A + B = 5n
# A + B = 55
# A = 5(n-11)
# n is from 14 to 19, corresponding to A 15:5:40

# for the concatenated string to be maximum, then the minimum in B should be maximized
# in which case A is 1:5, B is 6:10, n = 14

# data structure 
# B: x   *   *   *   *
#    |  
# A: y - z   *   *   *

# x + y + z = n

concat(m, n) = m * 10^(length(digits(n))) + n
concat(a, b, c...) = concat(concat(a, b), c...)

function concat(A::Vector{Int}, B::Vector{Int})
    n = 14
    res = 0
    for (i,b) in enumerate(B)
        res = concat(res, b, A[i], A[i+1])
    end
    for b in 6:10
        if !(b in B) && b + A[5] + A[1] == n
            return concat(res, b, A[5], A[1])
        end
    end
    0
end

function grow(A, B)
    n = 14
    i = length(A)
    if i == 5
        @show B, A, concat(A, B)
        return
    end
    for b in 6:10
        b in B && continue
        push!(B, b)
        a = n - b - A[i]
        if a < 1 || a in A
            pop!(B)
            continue
        else
            push!(A, a)
        end
        grow(A, B)
        pop!(A)
        pop!(B)
    end
end

let 
    A = [3, 5]
    B = [6]
    grow(A, B)
end

let 
    A = [5, 3]
    B = [6]
    grow(A, B)
end