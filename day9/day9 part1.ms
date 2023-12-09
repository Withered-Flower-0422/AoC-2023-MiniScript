puzzle = file.readLines("/usr/AoC 2023/day9/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day9/sample.txt")

import "listUtil"
list.removedVal = function(val, removeAll=false)
	result = self[:]
	result.removeVal(val, removeAll)
	return result
end function

getDiffList = function(l)
	res = []
	for i in range(0, l.len-2)
		res.push l[i+1] - l[i]
	end for
	return res
end function
getNextNum = function(l)
	endNum = [l[-1]]
	while l.removedVal(0, 1)
		l = getDiffList(l)
		endNum.push l[-1]
	end while
	return endNum.sum
end function
calculate = function(puzzle)
	res = []
	for i in puzzle
		tmp = i.split
		tmp.apply(@val)
		res.push getNextNum(tmp)
	end for
	return res.sum
end function

ans = calculate(puzzle)
print ans