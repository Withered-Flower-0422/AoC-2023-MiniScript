puzzle = file.readLines("/usr/AoC 2023/day10/puzzle.txt")
sample1 = file.readLines("/usr/AoC 2023/day10/sample1.txt")
sample2 = file.readLines("/usr/AoC 2023/day10/sample2.txt")

import "listUtil"

north = [-1, 0]; south = [1, 0]; west = [0, -1]; east = [0, 1]
pipes = {}
pipes["|"] = [north, south]
pipes["-"] = [east, west]
pipes["L"] = [north, east]
pipes["J"] = [north, west]
pipes["7"] = [south, west]
pipes["F"] = [south, east]
pipes["."] = [[0, 0], [0, 0]]
pipes.getS = function(puzzle)
	length = puzzle.len; width = puzzle[0].len
	res = []
	for i in puzzle.indexes
		tmp = puzzle[i].indexOf("S")
		if tmp != null then
			pos = [i, tmp]
		end if
	end for
	if pos[0] >= 1 and next(pos.plus(north), puzzle).contains(pos) then res.push north
	if pos[0] < length-1 and next(pos.plus(south), puzzle).contains(pos) then res.push south
	if pos[1] >= 1 and next(pos.plus(west), puzzle).contains(pos) then res.push west
	if pos[1] < width-1 and next(pos.plus(east), puzzle).contains(pos) then res.push east
	pipes.S = res
	return pos
end function
next = function(pos, puzzle)
	tmp = pipes[puzzle[pos[0]][pos[1]]]
	return [tmp[0].plus(pos), tmp[1].plus(pos)]
end function
calculate = function(puzzle)
	start = pipes.getS(puzzle)
	cur = start
	roads = [cur[:]]
	direction = pipes[puzzle[cur[0]][cur[1]]][0]
	while 1
		cur = cur.plus(direction)
		if cur == start then break
		tmp = pipes[puzzle[cur[0]][cur[1]]]
		direction = [tmp[1], tmp[0]][tmp[0].plus(direction)!=[0, 0]]
		roads.push cur[:]
	end while
	return roads
end function

ans = calculate(puzzle)
print ans.len / 2