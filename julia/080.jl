# http://www.afjarvis.staff.shef.ac.uk/maths/jarvisspec02.pdf

function _sqrtdigit(a, digitlimit=100)
    a = big(5a)
    b = big(5)
    while a > 0 && b < big(10)^105
        if a >= b
            a -= b
            b += 10
        else
            a *= 100
            b = (b - 5) * 10 + 5
        end
    end
    sum(digits(b)[end-99:end])
end

@show _sqrtdigit(2)

@show sum(_sqrtdigit(a) for a in 2:99 if isqrt(a)^2 != a)



