puzzle = file.readLines("/usr/AoC 2023/day11/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day11/sample.txt")

import "listUtil"
import "stringUtil"

trans = function(puzzle)
	res = []
	for i in puzzle[0].indexes
		tmp = ""
		for j in puzzle.indexes
			tmp += puzzle[j][i]
		end for
		res.push tmp
	end for
	return res
end function
halfExpand = function(puzzle)
	res = puzzle[:]
	i = 0
	while i < res.len
		if not res[i].contains("#") then
			res.insert i+1, res[i]
			i += 1
		end if
		i += 1
	end while
	return res
end function
expand = function(puzzle)
	res = halfExpand(puzzle)
	res = trans(res)
	res = halfExpand(res)
	res = trans(res)
	return res
end function

getGlxPos = function(puzzle)
	res = []
	puzzle = expand(puzzle)
	for i in puzzle.indexes
		for j in puzzle[i].indexes
			if puzzle[i][j] == "#" then res.push [i, j]
		end for
	end for
	return res
end function
calculate = function(puzzle)
	res = []
	glxPos = getGlxPos(puzzle)
	for i in glxPos.indexes
		for j in range(i+1, glxPos.len-1, 1)
			res.push abs(glxPos[i][0] - glxPos[j][0]) + abs(glxPos[i][1] - glxPos[j][1])
		end for
	end for
	return res.sum
end function

ans = calculate(puzzle)
print ans