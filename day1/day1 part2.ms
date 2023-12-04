code = file.readLines("/usr/AoC 2023/day1/code.txt")
sample1 = file.readLines("/usr/AoC 2023/day1/sample1.txt")
sample2 = file.readLines("/usr/AoC 2023/day1/sample2.txt")

import "stringUtil"

dic = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
firstEngNum = function(s)
	index = s.len - 1
	for i in dic.indexes
		if s.indexOf(dic[i]) < index then
			index = s.indexOf(dic[i])
			tmp = i+1
		end if
	end for
	return tmp
end function
lastEngNum = function(s)
	s = s.reverse
	index = s.len - 1
	for i in dic.indexes
		if s.indexOf(dic[i].reverse) < index then
			index = s.indexOf(dic[i].reverse)
			tmp = i+1
		end if
	end for
	return tmp
end function
numToEng = function(s)
	for i in dic.indexes
		s = s.replace(i+1, dic[i])
	end for
	return s
end function
getNumber = function(s)
	s = numToEng(s)
	res = [firstEngNum(s), lastEngNum(s)]
	return res.join("").val
end function
calculate = function(code)
	res = 0
	for i in code
		res += getNumber(numToEng(i))
	end for
	return res
end function

ans = calculate(code)
print ans