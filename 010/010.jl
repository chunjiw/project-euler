
function sump(n)
    s = 0
    b = BitArray([1 for i in 1:n])
    b[1] = false
    p = 2
    while !isnothing(p)
        s += p
        b[p:p:n] .= false
        p = findfirst(b)
    end
    s
end

@time sump(2_000_000)