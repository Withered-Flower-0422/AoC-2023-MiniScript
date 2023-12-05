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
	cnt = [1] * puzzle.len
	for i in puzzle.indexes
		myWinNum = []
		num = getNum(puzzle[i])
		for j in num.myNum
			if num.winNum.contains(j) then myWinNum.push j
		end for
		if myWinNum then
			for j in range(i+1, i+myWinNum.len)
				cnt[j] += cnt[i]
			end for
		end if
	end for
	return cnt
end function

ans = calculate(puzzle)
print ans.sum