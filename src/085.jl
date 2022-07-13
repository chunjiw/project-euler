f(m, n) = m * (m+1) * n * (n+1) ÷ 4
f(3, 2)

let 
    res = [f(m, n) for m in 1:2000, n in 1:2000]
    _, c = findmin(abs.(res .- 2_000_000))
    c[1] * c[2]
end

