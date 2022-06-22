# Brute force
@time let
    s::Int = 0
    for i in 1:1000-1
        if i % 3 == 0 || i % 5 == 0
            s += i
        end
    end
    println(s)
end

# Sift
@time let
    s3 = sum(3:3:999)
    s5 = sum(5:5:999)
    s15 = sum(15:15:999)
    println(s3 + s5 - s15)
end