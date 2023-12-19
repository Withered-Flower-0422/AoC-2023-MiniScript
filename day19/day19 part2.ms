// https://www.youtube.com/watch?v=3RwIpUegdU4

puzzle = file.readLines("/usr/AoC 2023/day19/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day19/sample.txt")

import "listUtil"
import "stringUtil"

getWorkflows = function(puzzle)
	workflows = {}
	data = puzzle.split("")[0]
	for i in data
		tmp = i.split("{")
		workflows[tmp[0]] = tmp[1][:-1].split(",")
	end for
	return workflows
end function
count = function(workflows, ranges, name = "in")
	if name == "R" then return 0
	if name == "A" then
		product = 1
		for i in ranges.values
			product *= i[1] - i[0] + 1
		end for
		return product
	end if
	rules = workflows[name][:-1]; fallback = workflows[name][-1]
	//print rules; print fallback
	total = 0; do = 1
	for i in rules
		tmp = i.split(":")
		key = tmp[0][0]; cmp = tmp[0][1]; n = tmp[0][2:].val; target = tmp[1]
		lo = ranges[key][0]; hi = ranges[key][1]
		if cmp == "<" then
			T = [lo, n - 1]
			F = [n, hi]
		else
			T = [n + 1, hi]
			F = [lo, n]
		end if
		if T[0] <= T[1] then
			copy = ranges + {}
			copy[key] = T
			total += count(workflows, copy, target)
		end if
		if F[0] <= F[1] then
			ranges = ranges + {}
			ranges[key] = F
		else
			do = 0
			break
		end if
	end for
	if do then total += count(workflows, ranges, fallback)
	return total
end function
calculate = function(puzzle)
	workflows = getWorkflows(puzzle)
	ranges = {"x": [1, 4000], "m": [1, 4000], "a": [1, 4000], "s": [1, 4000]}
	return count(workflows, ranges)
end function

ans = calculate(puzzle)
print ans