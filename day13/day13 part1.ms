puzzle = file.readLines("/usr/AoC 2023/day13/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day13/sample.txt")

import "listUtil"
import "stringUtil"
import "mathUtil"

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
getMirrorPos = function(pattern)
	for i in range(0, pattern.len-2)
		if pattern[i] == pattern[i+1] then
			isMirror = 1
			tmp = mathUtil.min(i, pattern.len-i-2)
			for j in range(1, tmp, 1)
				if pattern[i-j] != pattern[i+1+j] then
					isMirror = 0
					break
				end if
			end for
			if isMirror then return i + 1
		end if
	end for
	return 0
end function
calculate = function(puzzle)
	res = 0
	pattern = puzzle.split("")
	for i in pattern
		row = getMirrorPos(i)
		clm = getMirrorPos(trans(i))
		res += 100 * row + clm
	end for
	return res
end function

ans = calculate(puzzle)
print ans