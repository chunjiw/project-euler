open("061-cleaned-up.jl", "r") do f
    io = IOBuffer()
    for l in readlines(f) 
        if !startswith(l, "#")
            write(io, l, "\n")
        end
    end
    write("061-code-only.jl", take!(io))
        # for [l for l in readlines(f) if !startswith(l, "#")])
end