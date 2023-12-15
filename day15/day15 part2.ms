puzzle = file.readLines("/usr/AoC 2023/day15/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day15/sample.txt")

import "listUtil"
import "stringUtil"

eachHASH = function(c, v=0)
	v += code(c); v *= 17; v %= 256
	return v
end function
HASH = function(s)
	v = 0
	if s.indexOf("-") then
		for i in s[:-1]
			v = eachHASH(i, v)
		end for
		return [v, "-"]
	else
		for i in s[:-2]
			v = eachHASH(i, v)
		end for
		return [v, "="]
	end if
end function
calculate = function(puzzle)
	box = []
	for i in range(255)
		box.push []
	end for
	for i in puzzle[0].split(",")
		v = HASH(i)
		if v[1] == "-" then
			for j in box[v[0]].indexes
				if box[v[0]][j].split[0] == i[:-1] then
					box[v[0]].remove j
					break
				end if
			end for
		else
			needPush = 1
			for j in box[v[0]].indexes
				if box[v[0]][j].split[0] == i[:-2] then
					box[v[0]][j] = i.replace("=", " ")
					needPush = 0
					break
				end if
			end for
			if needPush then box[v[0]].push i.replace("=", " ")
		end if
	end for
	res = 0
	for i in box.indexes
		for j in box[i].indexes
			res += (i + 1) * (j + 1) * box[i][j].split[1].val
		end for
	end for
	return res
end function

ans = calculate(puzzle)
print ans