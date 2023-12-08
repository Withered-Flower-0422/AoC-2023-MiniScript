puzzle = file.readLines("/usr/AoC 2023/day7/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day7/sample.txt")

import "listUtil"
import "aoc"

mapper = function(s)
	mapLetter = {"T": "B", "J": "C", "Q": "D", "K": "E", "A": "F"}
	for i in mapLetter
		s = s.replace(i.key, i.value)
	end for
	return s
end function
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
compare = function(s1, s2)
	r1 = getTypeRank(s1); r2 = getTypeRank(s2)
	if r1 == r2 then
		s1 = mapper(s1); s2 = mapper(s2)
		if s1 > s2 then
			return 1
		else if s1 < s2 then
			return -1
		else
			return 0
		end if
	end if
	if r1 > r2 then return 1 else return -1
end function
calculate = function(puzzle)
	m = {}
	res = 0
	for i in puzzle
		tmp = i.split
		m[tmp[0]] = tmp[1].val
	end for
	k = m.indexes
	k.sortWithFunction @compare
	for i in k.indexes
		res += (i + 1) * m[k[i]]
	end for
	return res
end function

ans = calculate(puzzle)
print ans