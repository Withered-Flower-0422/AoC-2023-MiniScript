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