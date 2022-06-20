# using array to keep track of the digits uses too much memory

function nextup(digits)
    if isempty(digits) return 1:9 end
    res = Int64[]
    for d in digits, di in d:9        
        push!(res, di)
    end
    res
end

function nextdown(digits)
    if isempty(digits) return 1:9 end
    res = Int64[]
    for d in digits, di in 0:d
        push!(res, di)
    end
    res
end


function bouncywith(dn)
    res1 = []
    res2 = []
    for _ in 1:dn
        res1 = nextup(res1)
        res2 = nextdown(res2)
    end
    length(res1) + length(res2) - 9
end

function bouncy(dn)
    res1 = []
    res2 = []
    c = 0
    for _ in 1:dn
        res1 = nextup(res1)
        res2 = nextdown(res2)
        c += length(res1) + length(res2) - 9
    end
    c
end

bouncywith(1)
bouncywith(2)
bouncywith(3)
# bouncy(3)


# @time bouncy(6)
# @time sum(bouncy(10))
# @time sum(bouncy(20))
# @time sum(bouncy(30))