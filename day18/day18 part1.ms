puzzle = file.readLines("/usr/AoC 2023/day18/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day18/sample.txt")

import "listUtil"
import "stringUtil"

DIR = {"U": [-1, 0], "D": [1, 0], "L": [0, -1], "R": [0, 1]}

calculate = function(puzzle)
	apex = []; cur = [0, 0]; length = 0
	for i in puzzle
		tmp = i.split; dir = DIR[tmp[0]]; step = tmp[1].val
		length += step
		cur.add(dir.times(step))
		apex.push cur[:]
	end for
	A = 0; B = 0
	for i in apex.indexes
		A += apex[i-1][0] * apex[i][1]
		B += apex[i-1][1] * apex[i][0]
	end for
	return (abs(A - B) + length) / 2 + 1
end function

ans = calculate(puzzle)
print ans