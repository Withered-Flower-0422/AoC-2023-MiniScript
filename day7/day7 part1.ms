puzzle = file.readLines("/usr/AoC 2023/day7/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day7/sample.txt")

import "listUtil"

getTypeRank =function(s)
	count = s.split("").counts
	m = count.values.max
	l = count.len
	if l == 1 then
		return 6
	else if l == 2 then
		if m == 4 then return 5 else return 4
	else if l == 3 then
		if m == 3 then return 3 else return 2
	else if l == 4 then
		return 1
	else
		return 0
	end if
end function
min = function(s1, s2)
	rank = "AKQJT98765432"
	r1 = getTypeRank(s1); r2 = getTypeRank(s2)
	if r1 == r2 then
		for i in range(0, 4)
			if rank.indexOf(s1[i]) < rank.indexOf(s2[i]) then
				return s2
			else if rank.indexOf(s1[i]) > rank.indexOf(s2[i]) then
				return s1
			end if
		end for
	end if
	if r1 > r2 then return s2 else return s1
end function
calculate = function(puzzle)
	m = {}
	rank = []
	res = 0
	for i in puzzle
		tmp = i.split
		m[tmp[0]] = tmp[1].val
	end for
	k = m.indexes
	while k
		minCard = k[0]
		for i in range(1, k.len-1, 1)
			minCard = min(minCard, k[i])
		end for
		rank.push minCard
		k.remove k.indexOf(minCard)
	end while
	for i in rank.indexes
		res += (i + 1) * m[rank[i]]
	end for
	return res
end function

ans = calculate(puzzle)
print ans