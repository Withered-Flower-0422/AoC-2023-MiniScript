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
getEptRC = function(puzzle)
	row = []; clm = []
	for i in puzzle.indexes
		if not puzzle[i].contains("#") then row.push i
	end for
	puzzle = trans(puzzle)
	for i in puzzle.indexes
		if not puzzle[i].contains("#") then clm.push i
	end for
	return {"row": row, "clm": clm}
end function
getGlxPos = function(puzzle)
	res = []
	for i in puzzle.indexes
		for j in puzzle[i].indexes
			if puzzle[i][j] == "#" then res.push [i, j]
		end for
	end for
	return res
end function
calculate = function(puzzle, times=1000000)
	res = []
	glxPos = getGlxPos(puzzle)
	empty = getEptRC(puzzle)
	for i in glxPos.indexes
		for j in range(i+1, glxPos.len-1, 1)
			cnt = 0
			for k in empty.row
				if glxPos[i][0] < k < glxPos[j][0] or glxPos[j][0] < k < glxPos[i][0] then cnt += 1
			end for
			x = abs(glxPos[i][0] - glxPos[j][0]) + (times - 1) * cnt
			cnt = 0
			for k in empty.clm
				if glxPos[i][1] < k < glxPos[j][1] or glxPos[j][1] < k < glxPos[i][1] then cnt += 1
			end for
			y = abs(glxPos[i][1] - glxPos[j][1]) + (times - 1) * cnt
			res.push x + y
		end for
	end for
	return res.sum
end function

ans = calculate(puzzle)
print ans
// for part 1, ans = calculate(puzzle, 2)
