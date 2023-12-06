puzzle = file.readLines("/usr/AoC 2023/day6/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day6/sample.txt")

list.cleaned = function(self)
	res = []
	for i in self
		if i != "" then res.push i
	end for
	return res
end function
getNum = function(puzzle)
	t = puzzle[0].split[1:].cleaned.join("")
	d = puzzle[1].split[1:].cleaned.join("")
	return {"t": t.val, "d": d.val}
end function
calculate = function(puzzle)
	race = getNum(puzzle)
	delta = sqrt(race.t ^ 2 - 4 * race.d)
	startAt = ceil((race.t - delta) / 2)
	endAt = floor((race.t + delta) / 2)
	if startAt*(race.t-startAt) == race.d then
		startAt += 1; endAt -= 1
	end if
	return endAt - startAt + 1
end function

ans = calculate(puzzle)
print ans