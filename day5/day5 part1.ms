puzzle = file.readLines("/usr/AoC 2023/day5/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day5/sample.txt")

import "listUtil"

getMapedNum = function(seed, puzzle)
	mapList = [
	"seed-to-soil",
	"soil-to-fertilizer",
	"fertilizer-to-water",
	"water-to-light",
	"light-to-temperature",
	"temperature-to-humidity",
	"humidity-to-location"]
	seed = seed.val
	for k in range(0, 6)
		for i in puzzle.indexes
			if puzzle[i].indexOf(mapList[k]) != null then
				startLine = i + 1
				break
			end if
		end for
		endLine = startLine + 1
		while endLine < puzzle.len and puzzle[endLine]
			endLine += 1
		end while
		for i in range(startLine, endLine - 1)
			tmp = puzzle[i].split(" ")
			tmp.apply(@val)
			if tmp[1] <= seed < tmp[1] + tmp[2] then
				seed -= tmp[1] - tmp[0]
				break
			end if
		end for
	end for
	return seed
end function
calculate = function(puzzle)
	seeds = puzzle[0].split(" ")[1:]
	seeds.apply1(@getMapedNum, puzzle)
	return seeds
end function

ans = calculate(puzzle)
print ans.min