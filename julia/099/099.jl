using DelimitedFiles

f = download("https://projecteuler.net/project/resources/p099_base_exp.txt", "p099_base_exp.txt")

nums = readdlm(f, ',', Int)


m = 0
mi = 0
for i in 1:1000
    l = nums[i,2] * log(nums[i,1])
    if l > m
        m = l
        mi = i
    end
end
println(mi)
