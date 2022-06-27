for (root, dirs, files) in walkdir("./src")
    if length(files) == 1 && endswith(files[1], "jl")
        println(root)
        println(joinpath(root, files[1]))
        mv(joinpath(root, files[1]), joinpath("./src", files[1]))
        rm(root)
    end
end