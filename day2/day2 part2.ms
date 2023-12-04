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
count = function(s)
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
	return bag
end function
minMultiply = function(l)
	r = 0; g = 0; b = 0
	for i in l
		bag = count(i)
		if bag.red > r then r = bag.red
		if bag.green > g then g = bag.green
		if bag.blue > b then b = bag.blue
	end for
	return r*g*b
end function
calculate = function(l)
	res = 0
	for i in l
		res += minMultiply(split(i))
	end for
	return res
end function

ans = calculate(code)
print ans