puzzle = file.readLines("/usr/AoC 2023/day17/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day17/sample.txt")

import "listUtil"
import "stringUtil"
list.applied = function(func)
	res = self[:]
	res.apply(@func)
	return res
end function

for i in puzzle.indexes; puzzle[i] = puzzle[i].split("").applied(@val); end for
for i in sample.indexes; sample[i] = sample[i].split("").applied(@val); end for

exit

calculate = function(puzzle)
	maxR = puzzle.len - 1; maxC = puzzle[0].len - 1
	seen = {}; pq = [[0, 0, 0, 0, 0, 0]]
	while pq
		tmp = pq.pop
		hl = tmp[0]; r = tmp[1]; c = tmp[2]; dr = tmp[3]; dc = tmp[4]; n = tmp[5]
		if r == maxR and c == maxC then return hl
		if not(0 <= r <= maxR and 0 <= c <= maxC) then continue
		if seen.hasIndex([r, c, dr, dc, n]) then continue
		seen.push [r, c, dr, dc, n]
		if n < 3 and [dr, dc] != [0, 0] then
			nr = r + dr; nc = c + dc
			if 0 <= nr <= maxR and 0 <= nc <= maxC then pq.push [hl + puzzle[nr][nc], nr, nc, dr, dc, n + 1]
		end if
		for i in [[0, 1], [1, 0], [0, -1], [-1, 0]]
			if [-dr, -dc] != i != [dr, dc] then
				nr = r + dr; nc = c + dc
				if 0 <= nr <= maxR and 0 <= nc <= maxC then pq.push [hl + puzzle[nr][nc], nr, nc, dr, dc, 1]
			end if
		end for
	end while
end function

ans = calculate(puzzle)
print ans