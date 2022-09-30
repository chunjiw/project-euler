#!/usr/local/bin/julia

# One such number m = i^n satisfies 10^(n-1) <= i^n <= 10^n - 1
# i must be smaller than 10
# when 9^n < 10^(n-1), then i has no solution. 
# n > log(9) / (log(10) - log(9)) + 1 ~ 21.85
# so n ranges from 1 to 21
@show log(9) / (log(10) - log(9)) + 1

function npowerful(n::BigInt)
    floor(Int, (10^n - 1)^(1/n)) - ceil(Int, 10^(1-1/n)) + 1
end

for i in 1:21
    @show i, npowerful(big(i))
end

@show sum(npowerful(big(i)) for i in 1:21)