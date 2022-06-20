function rev(n, k)
	res = 0
	for i in 1:k
		res, n = 10res + n % 10, n ÷ 10
	end
	res
end

ispalin(n) = n == rev(n, ndigits(n))

f(n, p) = sum(1 for k in p:p:n if ispalin(k))

function h(d, p, k)
	pma = [powermod(10, i, p) for i in 0:d-1]
	pm(i) = pma[i+1]

	cnt = zeros(Int, p)
	for i in 0:10^k-1
		i % 10 > 0 || continue
		r = mod1(i + pm(d-k) * rev(i, k), p)
		cnt[r] += 1
	end
	
	m = (d-2k+1) ÷ 2
	m1 = m - Int(isodd(d))
	sum(cnt[mod1(-(j + rev(j, m1) * pm(m)) % p * pm(k), p)] for j in 0:10^m-1)
end

function g(d, p)
	k = d ÷ 4
	reduce(+, h(dd, p, k) for dd in 2k+1:d; init=0) + f(10^min(2k, d)-1, p)
end

@show @time g(32, 10^7+19)