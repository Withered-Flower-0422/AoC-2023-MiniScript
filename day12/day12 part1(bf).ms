// Brute force, takes a long time.
puzzle = file.readLines("/usr/AoC 2023/day12/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day12/sample.txt")

import "listUtil"
import "stringUtil"
list.cleaned = function(self)
	res = []
	for i in self
		if i != "" then res.push i
	end for
	return res
end function
numToBinStr = function(n)
	if n == 0 then return "0"
	tmp = ""
	while n
		tmp += n % 2
		n = floor(n / 2)
	end while
	return tmp.reverse
end function
string.append0 = function(self, l)
	return "0" * (l - self.len) + self
end function

getUnknownPos = function(s)
	res = []
	for i in s.indexes
		if s[i] == "?" then res.push i
	end for
	return res
end function
isMatch = function(s, r)
	res = s.split(".").cleaned; res.apply(@len)
	if res == r then return 1 else return 0
end function
getArr = function(s)
	res = 0
	s = s.split; spring = s[0]; record = s[1].split(","); record.apply(@val)
	unknownPos = getUnknownPos(spring)
	cnt = 2 ^ unknownPos.len
	while cnt; cnt -= 1
		tmp = spring.split("")
		bin = numToBinStr(cnt).append0(unknownPos.len)
		for i in unknownPos.indexes
			if bin[i].val then unknown = "#" else unknown = "."
			tmp[unknownPos[i]] = unknown
		end for
		if isMatch(tmp.join(""), record) then res += 1
	end while
	return res
end function
calculate = function(puzzle)
	res = []
	for i in puzzle
		res.push getArr(i)
	end for
	return res.sum
end function

ans = calculate(puzzle)
print ans