using BenchmarkTools

function ispower(n, base)
    base == 1 && return false
    while n > 1
        n % base == 0 || return false
        n ÷= base
    end
    return true
end

function digitsum(n)
    s = 0
    while n > 0
        s += n % 10 
        n ÷= 10
    end
    s
end

# Search the base and exponential space

@time let 
    dsp = Int64[]
    for m in 2:20, n in 2:200
        if digitsum(n^m) == n
            push!(dsp, n^m)
        end
    end
    sort!(dsp)
    @show dsp[2], dsp[10], dsp[30]
end

# Too slow to search for the power
# @time let
#     i = 0 
#     n = 70
#     while i < 20
#         if ispower(n, digitsum(n))
#             i += 1
#             @show i, n
#         end
#         n += 1
#     end
# end