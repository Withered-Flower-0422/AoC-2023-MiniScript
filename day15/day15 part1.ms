puzzle = file.readLines("/usr/AoC 2023/day15/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day15/sample.txt")

import "listUtil"
import "stringUtil"

eachHASH = function(c, v=0)
	v += code(c); v *= 17; v %= 256
	return v
end function
HASH = function(s)
	v = 0
	for i in s
		v = eachHASH(i, v)
	end for
	return v
end function
calculate = function(puzzle)
	res = 0
	for i in puzzle[0].split(",")
		res += HASH(i)
	end for
	return res
end function

ans = calculate(puzzle)
print ans