puzzle = file.readLines("/usr/AoC 2023/day6/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day6/sample.txt")

import "listUtil"

list.cleaned = function(self)
	res = []
	for i in self
		if i != "" then res.push i
	end for
	return res
end function
getNum = function(puzzle)
	race = []
	t = puzzle[0].split[1:].cleaned
	d = puzzle[1].split[1:].cleaned
	for i in t.indexes
		race.push {"t": t[i].val, "d": d[i].val}
	end for
	return race
end function
calculate = function(puzzle)
	res = []
	race = getNum(puzzle)
	for i in race
		delta = sqrt(i.t ^ 2 - 4 * i.d)
		startAt = ceil((i.t - delta) / 2)
		endAt = floor((i.t + delta) / 2)
		if startAt*(i.t-startAt) == i.d then
			startAt += 1; endAt -= 1
		end if
		res.push endAt - startAt + 1
	end for
	return res.product
end function

ans = calculate(puzzle)
print ans