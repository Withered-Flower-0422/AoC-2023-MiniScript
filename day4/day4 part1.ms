puzzle = file.readLines("/usr/AoC 2023/day4/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day4/sample.txt")

import "listUtil"

getNum = function(s)
	winNum = []
	myNum = []
	winOn = s.indexOf(":") + 2
	winOff = s.indexOf("|") - 3
	myOn = s.indexOf("|") + 2
	myOff = s.len - 2
	for i in range(winOn, winOff, 3)
		winNum.push s[i: i+2].val
	end for
	for i in range(myOn, myOff, 3)
		myNum.push s[i: i+2].val
	end for
	return {"winNum": winNum, "myNum": myNum}
end function
calculate = function(puzzle)
	res = 0
	for i in puzzle
		myWinNum = []
		num = getNum(i)
		for j in num.myNum
			if num.winNum.contains(j) then myWinNum.push j
		end for
		if myWinNum then res += 2 ^ (myWinNum.len - 1)
	end for
	return res
end function

ans = calculate(puzzle)
print ans