function collatz!(book, n)
    if book[n] > 0 return book[n] end
    m = n
    cnt = 1
    while m > length(book) || book[m] == 0 
        m = nextcollatz(m)
        cnt += 1
    end
    book[n] = cnt + book[m] - 1
    # aggressively book keeping, but improves little
    m = n
    cnt = book[n] - 1
    while m > 1
        m = nextcollatz(m)
        if m <= length(book)
            if book[m] > 0
                break
            else
                book[m] = cnt
            end
        end
        cnt -= 1
    end
    book[n]
end

function nextcollatz(n)
    iseven(n) ? n ÷ 2 : 3n + 1
end

function collatz(n)
    cnt = 1
    while n > 1
        n = nextcollatz(n)
        cnt += 1
    end
    cnt
end

function longest(ul=1000_000)
    book = fill(0, ul)
    book[1] = 1
    p = 1
    while 2^p <= ul
        book[2^p] = p + 1
        p += 1
    end
    for i in 1:ul
        collatz!(book, i)
    end
    findmax(book)
    # @show book
    # for i in 1:1000
    #     # @show i
    #     # @show collatz!(book, i)
    #     @assert collatz!(book, i) == collatz(i)
    #     # @show book
    # end
end

using BenchmarkTools
@show @time longest()
@btime longest()
