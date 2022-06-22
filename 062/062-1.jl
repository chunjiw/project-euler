


let 
    ds = [sort!(digits(n^3)) for n in 1:9999]
    for (i,d) in enumerate(ds)
        if length(findall(x -> x == d, ds)) == 5
            @show i, i^3, d
            break
        end
    end
end

