// General search algorithm.

import "listUtil"
if not globals.hasIndex("qa") then
	import "qa"
	globals.qa = qa
end if

// Helper function to find the index to insert something in a sorted list.
// Note that this ONLY works properly on a sorted list.
insertPosInSortedList = function(list, valueToInsert)
	high = list.len
	low = 0
	while low < high
		mid = floor((high + low) / 2)
		if valueToInsert > list[mid] then
			low = mid + 1
		else
			high = mid
		end if
	end while
	return low
end function


Search = {}

// Search.neighbors:
//	input: a state
//	output: a map with key: neighboring state; value: incremental cost
// (If all your costs are uniform, you can just treat the output map as
// a set and push the neighbors onto it.)
Search.neighbors = function(state)
	qa.assert false, "please override Search.neighbors"
	return {}
end function

// Search.heuristic (optional):
//	input: a state, and an end state
//	output: numeric value indicating how close the first is to the 
//		end state.  Note that this must never overestimate the true
//		cost, or we may not be able to find the least-cost path.
//		(An overly punishing heuristic results in greedier behavior,
//		which may return an answer faster, but it may be suboptimal.)
Search.heuristic = function(fromState, toEndState)
	return 0
end function

// Use this heuristic function if your states are [x,y] positions.
heuristic2DDistance = function(xyList1, xyList2)
    a = xyList2[0] - xyList1[0]
	b = xyList2[1] - xyList1[1]
	return sqrt(a^2 + b^2)
end function

// ...Unless you can only move orthogonally; then use this one.
manhattanDistance = function(xyList1, xyList2)
    return abs(xyList2[0] - xyList1[0]) + abs(xyList2[1] - xyList1[1])
end function

// findPath: a least-cost or best-first search (depending on whether
// you have implemented Search.heuristic).  Guaranteed to find the
// best solution, and if your heuristic is good, to be fairly fast.
//	input: start and end states
//	output: series of states from start to end
Search.findPath = function(startState, endState)
	qa.assert startState != null and endState != null
	print "Searching for path from "+ startState + " to " + endState
	
	toDo = []			// list of states to check, in est. cost order
	estCost = []		// corresponding list of estimated cost for each state
	self.steps = 0		// just FYI, how many states we checked to find a path
	
	toDo.push startState		// starting with just the initial state
	estCost.push 0
	
	camefrom = {}				// map of state to previous state it came from
	camefrom[startState] = null	// (starting with start state)
	actualCost = {}				// map of state -> actual cost to get here
	actualCost[startState] = 0
	lineCount = 0
	
	bestHeur = self.heuristic(startState, endState)
	while toDo
		self.steps = self.steps + 1
		currentEstTotal = estCost.pull
		current = toDo.pull
		
		if current[:endState.len] == endState then 
			print "FOUND IT!"
			break	// success!		
		end if
		//print "checking " + current
		gfx.setPixel current[0], current[1], color.silver	// HACK
		
		currentActualCost = actualCost[current]
		
		for kv in self.neighbors(current)
			nextState = kv.key
			incrementalCost = kv.value
			
			// calculate actual and estimated-total cost for this neighbor
			cost = currentActualCost + incrementalCost
			heur = self.heuristic(nextState, endState)
			if heur < bestHeur then
			print "New best heur: " + heur + " (at cost: " + cost + ")"
				bestHeur = heur
			end if
			estimate = cost + heur
						
			// if we already knew a cheaper way to get to this neighbor,
			// or we have already done this neighbor, then skip to the next one
			idx = toDo.indexOf(nextState)
			if actualCost.hasIndex(nextState) or (idx != null and estCost[idx] < estimate) then continue
			
			// otherwise, insert into our check list in estimated-total-cost order
			i = insertPosInSortedList(estCost, estimate)
			toDo.insert i, nextState
			estCost.insert i, estimate
			camefrom[nextState] = current
			actualCost[nextState] = cost
//			print "inserted " + nextState + " with est. " + estimate + " and cost " + cost
		end for
//		key.get
		current = null
	end while
	
	// Now walk the camefrom list to build our path (backwards)
	found = null
	for k in camefrom.indexes
		if k[:endState.len] == endState then
			found = k
			break
		end if
	end for
	endState = found
	print "Final end state: " + endState
	if found == null then return []
	
	if not camefrom.hasIndex(endState) then return []	// no solution
	current = endState
	result = []
	while current != startState
		result.push current
		current = camefrom[current]
	end while
	result.push startState
	result.reverse
	return result
end function

// Search.randomWalk: use our neighbors function to randomly
//	walk from the given start state, to some other reachable state.
Search.randomWalk = function(startState, steps=1)
	qa.assert startState != null
	qa.assert steps isa number
	state = startState
	for i in range(1, steps)
		state = self.neighbors(state).indexes.any
	end for
	return state
end function

testScramble = function
	// Test problem: swap any two neighboring characters to unscramble a word.
	// State is a string.
	// Neighbors are found by swapping every pair of characters.
	// Heuristic uses how many letters are in the right place.
	scramble = new Search
	scramble.neighbors = function(state)
		result = {}
		for i in range(0, state.len-2)
			result.push state[:i] + state[i+1] + state[i] + state[i+2:]
		end for
		return result
	end function
	scramble.heuristic = function(fromState, toEndState)
		diff = 0
		for i in fromState.indexes
			if fromState[i] != toEndState[i] then diff = diff + 0.5
		end for
		return diff
	end function

	start = "HLEOW LLRDO"
	goal  = "HELLO WORLD"
	print "Path from " + start + " to " + goal + ":"
	print scramble.findPath(start, goal)
	print "...found in " + scramble.steps + " steps."
end function
