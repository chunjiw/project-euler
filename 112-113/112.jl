function increasing(n)
    d0 = 9
    while n > 0
        d1 = n % 10
        if d1 > d0
            return false
        end
        d0 = d1
        n ÷= 10
    end
    true
end

function decreasing(n)
    d0 = 0
    while n > 0
        d1 = n % 10
        if d1 < d0
            return false
        end
        d0 = d1
        n ÷= 10
    end
    true
end

@time let 
    bouncy = 0
    n = 21780
    for i in 1:n
        if !increasing(i) && !decreasing(i)
            bouncy += 1
        end
    end
    @show bouncy, bouncy / n
end

@time let 
    bouncy = 0
    i = 1
    while true
        if !increasing(i) && !decreasing(i)
            bouncy += 1
        end        
        if 100bouncy == 99i
            @show bouncy, i, bouncy / i
            break
        end
        i += 1
    end 
end