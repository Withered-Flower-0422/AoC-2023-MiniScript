// Followed a video on youtube.
// (https://www.youtube.com/watch?v=g3Ms5e7Jdqo)
puzzle = file.readLines("/usr/AoC 2023/day12/puzzle.txt")
sample = file.readLines("/usr/AoC 2023/day12/sample.txt")

import "listUtil"
import "stringUtil"

cache = {}
count = function(s, r)
	if s == "" then return [0, 1][r==[]]
	if r == [] then return [1, 0][s.contains("#")]
	key = [s, r]
	if cache.hasIndex(key) then return cache[key]
	res = 0
	if ".?".contains(s[0]) then res += count(s[1:], r[:])
	if "#?".contains(s[0]) then
		if r[0] <= s.len and not s[:r[0]].contains(".") and (r[0] == s.len or s[r[0]] != "#") then res += count(s[r[0] + 1:], r[1:])
	end if
	cache[key] = res
	return res
end function
calculate = function(puzzle)
	res = 0
	for i in puzzle
		tmp = i.split; s = ([tmp[0]] * 5).join("?"); r = tmp[1].split(",") * 5; r.apply(@val)
		res += count(s, r)
	end for
	return res
end function

ans = calculate(puzzle)
print ans