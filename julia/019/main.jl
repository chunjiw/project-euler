using Dates

d0 = Date("1900-01-07")    # Sunday
d1 = Date("1900-01-08")    # Monday

let s = 0
    for y in 1901:2000, m in 1:12
        d = Date(y, m, 1)
        if (d - d0).value % 7 == 0
            s += 1
        end
    end
    @show s
end
