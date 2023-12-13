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
canBeRepaired = function(s1, s2)
	cnt = 0
	for i in s1.indexes
		if s1[i] != s2[i] then cnt += 1
	end for
	if cnt == 1 then return 1 else return 0
end function
getMirrorPos = function(pattern, fixed=0)
	for i in range(1, pattern.len-1)
		tmp = pattern[:i] + [""] + pattern[i:]
		repaired = fixed; isMirror = 1
		min = mathUtil.min(i, tmp.len-i-1)
		for j in range(1, min)
			if repaired then
				if tmp[i-j] != tmp[i+j] then
					isMirror = 0
					break
				end if
			else
				if tmp[i-j] != tmp[i+j] then
					if canBeRepaired(tmp[i-j], tmp[i+j]) then
						repaired = 1
					else
						isMirror = 0
						break
					end if
				end if	
			end if
		end for
		if isMirror and repaired then return i
	end for
	return 0
end function
calculate = function(puzzle, fixed=0)
	res = 0
	pattern = puzzle.split("")
	for i in pattern
		row = getMirrorPos(i, fixed)
		clm = getMirrorPos(trans(i), fixed)
		res += 100 * row + clm
	end for
	return res
end function

ans = calculate(puzzle)
print ans
// for part 1, ans = calculate(puzzle, 1)
