puzzle = file.readLines("/usr/AoC 2023/day14/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day14/sample.txt")

import "listUtil"
import "stringUtil"
list.applied1 = function(func, arg1)
	result = self[:]
	result.apply1(@func, arg1)
	return result
end function

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
slide = function(s, dir)
	spaces = s.replace("O", "")
	O = s.replace(".", "")
	return [O + spaces, spaces + O][dir]
end function
slideOnce = function(puzzle, dir)
	res = []
	for i in puzzle
		res.push i.split("#").applied1(@slide, dir).join("#")
	end for
	return res
end function
slided = function(puzzle)
	puzzle = trans(puzzle)
	puzzle = slideOnce(puzzle, 0)
	puzzle = trans(puzzle)
	puzzle = slideOnce(puzzle, 0)
	puzzle = trans(puzzle)
	puzzle = slideOnce(puzzle, 1)
	puzzle = trans(puzzle)
	puzzle = slideOnce(puzzle, 1)
	return puzzle
end function
calculate = function(puzzle)
	cache = []
	while cache.indexOf(puzzle) == null
		cache.push puzzle[:]
		puzzle = slided(puzzle)
	end while
	startAt = cache.indexOf(puzzle); cycle = cache.len - startAt
	final = trans(cache[(1000000000-startAt)%cycle+startAt])
	res = 0
	for i in final
		for j in i.indexes
			if i[j] == "O" then res += i.len - j
		end for
	end for
	return res
end function

ans = calculate(puzzle)
print ans