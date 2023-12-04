code = file.readLines("/usr/AoC 2023/day2/code.txt")
sample = file.readLines("/usr/AoC 2023/day2/sample.txt")

removeSpace = function(s)
	res = ""
	for i in s
		if i != " " then res += i
	end for
	return res
end function
getSepIndex = function(s, sep)
	res = []
	for i in s.indexes
		if s[i] == sep then res.push i
	end for
	return res
end function
split = function(s)
	res = []
	s = removeSpace(s)[s.indexOf(":"):]
	semiIndex = [-1] + getSepIndex(s, ";") + [s.len]
	for i in range(0, semiIndex.len-2)
		res.push s[semiIndex[i]+1:semiIndex[i+1]]
	end for
	return res
end function
isOverflow = function(s)
	bag = {"red": 0, "green": 0, "blue": 0}
	res = []
	comIndex = [-1] + getSepIndex(s, ",") + [s.len]
	for i in range(0, comIndex.len-2)
		res.push s[comIndex[i]+1:comIndex[i+1]]
	end for
	for i in res
		for j in ["red", "green", "blue"]
			if i.indexOf(j) then
				bag[j] = i[:i.indexOf(j)].val
				break
			end if
		end for
	end for
	if bag.red > 12 or bag.green > 13 or bag.blue > 14 then
		return 1
	else
		return 0
	end if
end function
calculate = function(l)
	cnt = 0
	for i in l.indexes
		overflow = 0
		tmp = split(l[i])
		for j in tmp
			if isOverflow(j) then
				overflow = 1
				break
			end if
		end for
		if not overflow then cnt += i + 1
	end for
	return cnt
end function

ans = calculate(code)
print ans