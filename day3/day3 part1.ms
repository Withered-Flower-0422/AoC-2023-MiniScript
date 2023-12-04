code = file.readLines("/usr/AoC 2023/day3/code.txt")
sample = file.readLines("/usr/AoC 2023/day3/sample.txt")

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
getAdjacentNumber = function(code)
	len1 = code[0].len
	len2 = code.len
	res2 = []
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
					if not(tmp == "." or "0" <= tmp <= "9") then
						res2.push n[0][j].val
						break
					end if
				end if
			end for
		end for
	end for
	return res2
end function

ans = getAdjacentNumber(code)
print ans.sum