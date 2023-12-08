puzzle = file.readLines("/usr/AoC 2023/day8/puzzle.txt")
sample1 = file.readLines("/usr/AoC 2023/day8/sample1.txt")
sample2 = file.readLines("/usr/AoC 2023/day8/sample2.txt")

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
	step = 0; ins = puzzle[0]; nodes = getNodes(puzzle); current = "AAA"
	while current != "ZZZ"; step += 1
		current = nodes[current][ins[(step-1)%ins.len]=="R"]
	end while
	return step
end function

ans = calculate(puzzle)
print ans