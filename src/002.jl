
f(a, b, c) = (b + c, b + 2c, 2b + 3c)

let 
    a, b, c = 2, 3, 5
    s = 0
    while a <= 4_000_000
        s += a
        a, b, c = f(a, b, c)
    end
    println(s)
end