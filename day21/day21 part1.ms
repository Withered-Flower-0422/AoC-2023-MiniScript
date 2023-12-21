puzzle = file.readLines("/usr/AoC 2023/day21/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day21/sample.txt")

import "listUtil"
import "stringUtil"
list.filtered1 = function(func, arg1)
	result = []
	for elem in self
		if func(elem, arg1) then result.push elem
	end for
	return result
end function

U = [-1, 0]; D = [1, 0]; L = [0, -1]; R = [0, 1]

getS = function(puzzle)
	for i in puzzle.indexes
		for j in puzzle[i].indexes
			if puzzle[i][j] == "S" then return [i, j]
		end for
	end for
end function
walk = function(pos, puzzle)
	res = []
	res.push pos.plus(U)
	res.push pos.plus(D)
	res.push pos.plus(L)
	res.push pos.plus(R)
	return res
end function
inRange = function(pos, puzzle)
	r = puzzle.len; c = puzzle[0].len
	return 0 <= pos[0] < r and 0 <= pos[1] < c
end function
isValid = function(pos, puzzle)
	return inRange(pos, puzzle) and puzzle[pos[0]][pos[1]] != "#"
end function
calculate = function(puzzle, step=64)
	cur = {getS(puzzle): 1}
	while step; step -= 1
		res = {}
		for i in cur
			tmp = walk(i.key, puzzle).filtered1(@isValid, puzzle)
			for j in tmp
				res.push j
			end for
		end for
		cur = res
	end while
	return cur.len
end function

ans = calculate(puzzle)
print ans