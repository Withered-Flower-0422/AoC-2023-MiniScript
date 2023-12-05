puzzle = file.readLines("/usr/AoC 2023/day1/puzzle.txt")
sample1 = file.readLines("/usr/AoC 2023/day1/sample1.txt")
sample2 = file.readLines("/usr/AoC 2023/day1/sample2.txt")

getNumber = function(s)
	res = []
	for i in s
		if "1" <= i <= "9" then res.push i
	end for
	return [res[0], res[-1]].join("").val
end function
calculate = function(puzzle)
	res = 0
	for i in puzzle
		res += getNumber(i)
	end for
	return res
end function

ans = calculate(puzzle)
print ans