# using dictionary

using StaticArrays
import Base: isempty, length, iterate, getindex, setindex!

struct DigitsCount
    # 1 2 3 4 5 6 7 8 9 0
    count::MVector{10, Int}
    function DigitsCount(iter)
        digits = new(zeros(Int, 10))
        for i in iter
            digits[i] += 1
        end
        digits
    end
    DigitsCount() = DigitsCount([])
end

# DigitsCount() = DigitsCount(zeros(Int, 10))
# function DigitsCount(iter)
#     digits = DigitsCount()
#     for i in iter
#         digits[i] += 1
#     end
#     digits
# end

isempty(d::DigitsCount) = sum(d.count) == 0

function iterate(d::DigitsCount)
    i = findfirst(d.count .> 0)
    isnothing(i) ? nothing : (i, i + 1)
end
function iterate(d::DigitsCount, state)
    i = findfirst(d.count[state:end] .> 0)
    isnothing(i) ? nothing : (i + state - 1, i + state)
end

length(d::DigitsCount) = count(d.count .> 0)

getindex(d::DigitsCount, i) = i == 0 ? d.count[10] : d.count[i]
function setindex!(d::DigitsCount, v, i)
    i = i == 0 ? 10 : i
    d.count[i] = v
end

nsol(d::DigitsCount) = sum(d.count)


function nextup(digits)
    if isempty(digits) return DigitsCount(1:9) end
    newd = DigitsCount()
    for d in digits, di in d:9
        newd[di] += digits[d]
    end
    newd
end

function nextdown(digits)
    if isempty(digits) return DigitsCount(1:9) end
    newd = DigitsCount()
    for d in digits, di in 0:d
        newd[di] += digits[d]
    end
    newd
end

function bouncywith(dn)
    res1 = DigitsCount()
    res2 = DigitsCount()
    for _ in 1:dn
        res1 = nextup(res1)
        res2 = nextdown(res2)
    end
    nsol(res1) + nsol(res2) - 9
end

function bouncy(dn)
    res1 = DigitsCount()
    res2 = DigitsCount()
    c = 0
    for _ in 1:dn
        res1 = nextup(res1)
        res2 = nextdown(res2)
        c += nsol(res1) + nsol(res2) - 9
    end
    c
end

@show bouncywith(1)
@show bouncywith(2)
@show bouncywith(3)

@show bouncy(3)
@show bouncy(6)
# @time sum(bouncy(10))
# @time sum(bouncy(20))
# @time sum(bouncy(30))