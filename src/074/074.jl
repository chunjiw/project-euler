function sumfac(n)
    res = 0
    while n > 0
        res += factorial(n % 10)
        n ÷= 10
    end
    res
end

function countchain(n, sink_entry)
    nchain = [n]
    while !(last(nchain) in keys(sink_entry))
        push!(nchain, sumfac(last(nchain)))
    end
    l0 = length(nchain) + sink_entry[last(nchain)] - 1
    l = l0
    for i in nchain
        sink_entry[i] = l
        l -= 1
    end
    l0
end

let
    sink_entry = Dict{Int,Int}()
    sink_entry[145] = 1
    sink_entry[169] = 3
    sink_entry[363601] = 3
    sink_entry[1454] = 3
    sink_entry[871] = 2
    sink_entry[872] = 2
    sink_entry[45361] = 2
    sink_entry[45362] = 2
    sink_entry[1] = 1
    sink_entry[2] = 1
    sink_entry[40585] = 1
    # @show sink_entry
    # @show @time countchain(69, sink_entry)
    # @show @time countchain(9, sink_entry)
    # @show @time countchain(540, sink_entry)
    @show @time count(countchain(i, sink_entry) == 60 for i in 1:999_999)
    # @show @time countchain(14558, sink_entry)
    # for i in 10_000:99_999
    #     println(i, " ", countchain(i, sink_entry))
    # end
end

