// I failed to tackle with this part on my own,
// so I followed a video on [youtube](https://www.youtube.com/watch?v=NmxHw_bHhGM)
// to finish this part.

puzzle = file.readLines("/usr/AoC 2023/day5/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day5/sample.txt")

import "listUtil"

max = function(a, b)
	if a > b then return a else return b
end function
min = function(a, b)
	if a < b then return a else return b
end function
getLines = function(puzzle)
	res = []
	mapList = [
	"seed-to-soil",
	"soil-to-fertilizer",
	"fertilizer-to-water",
	"water-to-light",
	"light-to-temperature",
	"temperature-to-humidity",
	"humidity-to-location"]
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
		res.push {"startLine": startLine, "endLine": endLine}
	end for
	return res
end function
calculate = function(puzzle)
	res = []
	tmp = puzzle[0].split(" ")[1:]
	tmp.apply(@val)
	seeds = []
	for i in range(0, tmp.len - 1, 2)
		seeds.push [tmp[i], tmp[i] + tmp[i+1]]
	end for
	mapLines = getLines(puzzle)
	for k in range(0, 6)
		ranges = []
		for i in range(mapLines[k].startLine, mapLines[k].endLine - 1)
			tmp = puzzle[i].split(" ")
			tmp.apply(@val)
			ranges.push tmp
		end for
		nw = []
		while seeds
			do = 1
			se = seeds.pop
			for i in ranges
				os = max(se[0], i[1])
				oe = min(se[1], i[1] + i[2])
				if os < oe then
					nw.push [os - i[1] + i[0], oe - i[1] + i[0]]
					if os > se[0] then seeds.push [se[0], os]
					if se[1] > oe then seeds.push [oe, se[1]]
					do = 0
					break
				end if
			end for
			if do then nw.push se
		end while
		seeds = nw
	end for
	for i in seeds
		res.push i[0]
	end for
	return res.min
end function

ans = calculate(puzzle)
print ans
