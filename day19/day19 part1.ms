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
getParts = function(puzzle)
	parts = []
	data = puzzle.split("")[1]
	for i in data
		m = {}
		conditions = i[1:-1].split(",")
		for j in conditions
			tmp = j.split("=")
			m[tmp[0]] = tmp[1].val
		end for
		parts.push m
	end for
	return parts
end function
istrue = function(p, con)
	conp = con[0]; cons = con[1]; conn = con[2:].val
	if cons == "<" then
		if p[conp] < conn then return 1 else return 0
	else
		if p[conp] > conn then return 1 else return 0
	end if
end function
travel = function(p, w)
	cur = "in"
	while not(cur == "A" or cur == "R")
		for rule in w[cur]
			tmp = rule.split(":")
			if tmp.len == 2 then
				con = tmp[0]; to = tmp[1]
				if istrue(p, con) then
					cur = to
					break
				end if
			else
				cur = tmp[0]
			end if
		end for
	end while
	return cur
end function
calculate = function(puzzle)
	workflows = getWorkflows(puzzle)
	parts = getParts(puzzle)
	total = 0
	for i in parts
		res = travel(i, workflows)
		if res == "A" then total += i.sum
	end for
	return total
end function

ans = calculate(puzzle)
print ans