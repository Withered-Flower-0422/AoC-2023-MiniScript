puzzle = file.readLines("/usr/AoC 2023/day16/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day16/sample.txt")

import "listUtil"
import "stringUtil"

u = [-1, 0]; d = [1, 0]; l = [0, -1]; r = [0, 1]
trans = {}
trans["|"] = {u: [u], d: [d], l: [u, d], r: [u, d]}
trans["-"] = {u: [l, r], d: [l, r], l: [l], r: [r]}
trans["/"] = {u: [r], d: [l], l: [d], r: [u]}
trans["\"] = {u: [l], d: [r], l: [u], r: [d]}
trans["."] = {u: [u], d: [d], l: [l], r: [r]}

calc = function(pd, puzzle)
	maxX = puzzle.len - 1; maxY = puzzle[0].len - 1
	seen = {pd: 1}; q = {pd: 1}; energized = {}
	while q;
		tmp = q.pop; pos = tmp[:2]; dir = tmp[2:]
		if not energized.hasIndex(pos) then energized.push pos
		nextDir = trans[puzzle[pos[0]][pos[1]]][dir]
		for i in nextDir
			nextPos = pos.plus(i)
			if not(0 <= nextPos[0] <= maxX and 0 <= nextPos[1] <= maxY) then continue
			nextpd = nextPos + i
			if not seen.hasIndex(nextpd) then
				seen.push nextpd; q.push nextpd
			end if
		end for
	end while
	return energized.len
end function
calculate = function(puzzle)
	start = [0, 0] + r
	res = calc(start, puzzle)
	return res
end function

ans = calculate(puzzle)
print ans