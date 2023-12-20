puzzle = file.readLines("/usr/AoC 2023/day20/puzzle.txt")
sample1 = file.readLines("/usr/AoC 2023/day20/sample1.txt")
sample2 = file.readLines("/usr/AoC 2023/day20/sample2.txt")

inputs = [puzzle, sample1, sample2][0][:]

import "listUtil"
import "stringUtil"

low = 0; high = 0

Flipflop = {}
Flipflop.state = 0
Flipflop.init = function
	self.state = 0
end function
Flipflop.func = function(receive, module)
	if receive then
		return null
	else
		self.state = not self.state
		return self.state
	end if
end function

Conjunction = {}
Conjunction.init = function
	self.memory = {}
	for i in modules
		if i.value.link.contains(self.name) then self.memory[i.key] = 0
	end for
end function
Conjunction.func = function(receive, module)
	self.memory[module] = receive
	for i in self.memory
		if i.value == 0 then return 1
	end for
	return 0
end function

Broadcaster = {}
Broadcaster.init = function; end function
Broadcaster.func = function(receive, module)
	return 0
end function

modules = {}
for i in inputs
	data = i.split(" -> ")
	if data[0] == "broadcaster" then
		modules.broadcaster = new Broadcaster
		modules.broadcaster.name = "broadcaster"
		modules.broadcaster.type = "bc"
		modules.broadcaster.link = data[1].split(", ")
	else if data[0][0] == "%" then
		modules[data[0][1:]] = new Flipflop
		modules[data[0][1:]].name = data[0][1:]
		modules[data[0][1:]].type = "ff"
		modules[data[0][1:]].link = data[1].split(", ")
	else if data[0][0] == "&" then
		modules[data[0][1:]] = new Conjunction
		modules[data[0][1:]].name = data[0][1:]
		modules[data[0][1:]].type = "cj"
		modules[data[0][1:]].link = data[1].split(", ")
	end if
end for
for s in modules
	s.value.init
end for

pressButton = function
	globals.low += 1; q = [["broadcaster", 0, null]]
	while q
		data = q.pull; task = data[0]; pra1 = data[1]; pra2 = data[2]
		if modules.hasIndex(task) then
			res = modules[task].func(pra1, pra2)
			for i in modules[task].link
				if res == 0 then
					globals.low += 1
				else if res == 1 then
					globals.high += 1
				end if
				if res != null then q.push [i, res, task]
			end for
		end if
	end while
end function

for i in range(1, 1000)
	pressButton
end for
print low * high

////////////////////////////////////////////////////////////////////////////////
exit
////////////////////////////////////////////////////////////////////////////////
getState = function
	res = {}
	for s in modules
		if s.value.type == "ff" then res[s.value.name] = s.value.state
		if s.value.type == "cj" then res[s.value.name] = s.value.memory + {}
	end for
	return res
end function

seen = []; step = 0
while 1
	state = getState
	startAt = seen.indexOf(state)
	if startAt != null then break
	seen.push state
	pressButton
	step += 1
end while
cycle = step - startAt
cycles = floor((1000 - startAt) / cycle)
remain = (1000 - startAt) % cycle
while startAt; startAt -= 1
	pressButton
end while
_low = low; _high = high
while cycle; cycle -= 1
	pressButton
end while
dl = low - _low; dh = high - _high
low += (cycles-2) * dl; high += (cycles-2) * dh
while remain; remain -= 1
	pressButton
end while

ans = low * high
print ans