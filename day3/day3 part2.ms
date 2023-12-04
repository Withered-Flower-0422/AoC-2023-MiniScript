code = file.readLines("/usr/AoC 2023/day3/code.txt")
sample = file.readLines("/usr/AoC 2023/day3/sample.txt")

import "listUtil"

getNumber = function(s)
	res = []
	index = []
	tmp = ""
	on = 0
	for i in s.indexes
		if "0" <= s[i] <= "9" then
			if on == 0 then
				on = 1
				index.push i
			end if
			tmp += s[i]
		else
			if tmp then res.push tmp
			tmp = ""
			on = 0
		end if
	end for
	if tmp then res.push tmp
	return [res, index]
end function
getGearNumber = function(code)
	len1 = code[0].len
	len2 = code.len
	res2 = []
	index = []
	for i in code.indexes
		n = getNumber(code[i])
		for j in n[0].indexes
			res = []
			on = n[1][j] - 1
			off = on + n[0][j].len + 1
			res.push [i, on]; res.push [i, off]
			for k in range(on, off)
				res.push [i-1, k]
				res.push [i+1, k]
			end for
			for k in res
				if 0 <= k[0] < len2 and 0 <= k[1] < len1 then
					tmp = code[k[0]][k[1]]
					if tmp == "*" then
						res2.push n[0][j].val
						index.push k
						break
					end if
				end if
			end for
		end for
	end for
	return [res2, index]
end function
calculate = function(code)
	gearNumber = getGearNumber(code)
	gearMap = {}
	res = 0
	for i in gearNumber[1].indexes
		if not gearMap.hasIndex(gearNumber[1][i]) then gearMap[gearNumber[1][i]] = []
		gearMap[gearNumber[1][i]].push gearNumber[0][i]
	end for
	for s in gearMap
		if s.value.len > 1 then
			res += s.value.product
		end if
	end for
	return res
end function

ans = calculate(code)
print ans