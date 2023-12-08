puzzle = file.readLines("/usr/AoC 2023/day8/puzzle.txt")
sample1 = file.readLines("/usr/AoC 2023/day8/sample1.txt")
sample2 = file.readLines("/usr/AoC 2023/day8/sample2.txt")
sample3 = file.readLines("/usr/AoC 2023/day8/sample3.txt")

import "listUtil"
lcm = function(a, b)
	ab = a * b
	while a % b
		tmp = a; a = b; b = tmp % b
	end while
	return ab / b
end function

getNodes = function(puzzle)
	puzzle.pull; puzzle.pull
	nodes = {}
	for i in puzzle
		tmp = i.split(" = ")
		nodes[tmp[0]] = tmp[1][1:-1].split(", ")
	end for
	return nodes
end function
calculate = function(puzzle)
	steps = []; ins = puzzle[0]; nodes = getNodes(puzzle); current = []
	for i in nodes
		if i.key[-1] == "A" then current.push i.key
	end for
	for i in current
		step = 0
		while i[-1] != "Z"; step += 1
			i = nodes[i][ins[(step-1)%ins.len]=="R"]
		end while
		steps.push step
	end for
	return steps.reduce(@lcm)
end function

ans = calculate(puzzle)
print ans