puzzle = file.readLines("/usr/AoC 2023/day18/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day18/sample.txt")

import "listUtil"
import "stringUtil"
import "json"

DIR = {"3": [-1, 0], "1": [1, 0], "2": [0, -1], "0": [0, 1]}

calculate = function(puzzle)
	apex = []; cur = [0, 0]; length = 0
	for i in puzzle
		tmp = i.split; dir = DIR[tmp[2][7]]; step = json.hexToInt(tmp[2][2:7])
		length += step
		cur.add(dir.times(step))
		apex.push cur[:]
	end for
	
	///////////////////////////////////////////////////
	//A = 0; B = 0                                   //
	//for i in apex.indexes                          //
	//A += apex[i-1][0] * apex[i][1]                 //
	//B += apex[i-1][1] * apex[i][0]                 //
	//end for                                        //
	//return (abs(A - B) + length) / 2 + 1           //
	///////////////////////////////////////////////////
	
	// The code above can get the correct answer theoretically.
	// It can get sample's answer, but not the puzzle's because
	// of the loss of accuracy. The loss of accuracy resulted in
	// my answer being 5 smaller than the correct answer.
	// So I used the code below to avoid the loss of accuracy.
	
	resA = []; resB = []
	for i in apex.indexes
		resA.push apex[i-1][0] * apex[i][1]
		resB.push apex[i-1][1] * apex[i][0]
	end for
	resA.sort; resB.sort; res = 0
	for i in resA.indexes
		res += resA[i] - resB[i]
	end for
	return (abs(res) + length) / 2 + 1
end function

ans = calculate(puzzle)
print ans