using Primes


let
    p = 600851475143

    factors = Int64[]

    @time for i in 1:1000
        pi = prime(i)
        if p % pi == 0
            p ÷= pi
            push!(factors, pi)
            println(i, " ", pi)
        end
    end

    println(prod(factors))
end