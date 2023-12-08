// Utilities for working with 3-element lists which we treat as [x, y, z],
// as well as 3D arrays which we interpret as a 3D grid.

// We'll auto-import listUtil; this defines handy functions like:
//		list.dot  		// dot product
//		list.times  	// scaling and element-wise multiplication
//		list.multiplyBy	// some, but in place
//		list.plus		// addition
//		list.add		// addition, in place
//		list.apply		// apply a function to each element
//		list.apply1		// same, but with an argument
import "listUtil"

// accessors so you can use pos.x as a synonym for pos[0], etc.
list.x = function; return self[0]; end function
list.y = function; return self[1]; end function
list.z = function; return self[2]; end function

// standard directions
left = [-1, 0, 0]
right = [1, 0, 0]
down = [0, -1, 0]
up = [0, 1, 0]
forward = [0, 0, 1]
back = [0, 0, -1]
neighbors6 = [left, right, down, up, forward, back]

// Cross product
list.cross = function(b)
	return [
		self.y * b.z - self.z * b.y,
		self.z * b.x - self.x * b.z,
		self.x * b.y - self.y * b.x]
end function

//----------------------------------------------------------------------
// 3D array helpers

// Get bounds of a 3D array for any dimension
list.sizeOfDim = function(dim=0)
	a = self
	while dim
		a = a[0]
		dim = dim - 1
	end while
	return a.len
end function
list.sizeX = function; return self.len; end function
list.sizeY = function; return self[0].len; end function
list.sizeZ = function; return self[0][0].len; end function

// Check whether a given coordinate is in bounds.
// (Pass in an [x,y,z] list, or separate x,y,z values.)
list.inBounds = function(xOrList, y=null, z=null)
	if xOrList isa list then
		x = xOrList[0]; y = xOrList[1]; z = xOrList[2]
	else
		x = xOrList
	end if
	return x >= 0 and x < self.sizeX and
		y >= 0 and y < self.sizeY and
		z >= 0 and z < self.sizeZ
end function

// get: get the value at a given [x,y,z] point, or a default
// value if out of bounds.
list.get = function(coordinates, defaultValue=null)
	if not self.inBounds(coordinates) then return defaultValue
	return self[coordinates[0]][coordinates[1]][coordinates[2]]
end function

// Set: set the value at a given [x,y,z] point, if in bounds.
list.set = function(coordinates, newValue)
	if self.inBounds(coordinates) then
		self[coordinates[0]][coordinates[1]][coordinates[2]] = newValue
	end if
end function


// Flood fill: fill all 6-connected neighbors that have the same
// value as the given value, with a new value.  Think 3D paint bucket.
// Parameters:
//		origin -- [x,y,z] starting position
//		newValue -- value to change to
list.floodFill = function(origin, newValue)
	if not self.inBounds(origin) then return
	toDo = [origin]
	oldValue = self[origin[0]][origin[1]][origin[2]]
	if oldValue == newValue then return
	while toDo
		pos = toDo.pop
		if self[pos[0]][pos[1]][pos[2]] == newValue then continue
		self[pos[0]][pos[1]][pos[2]] = newValue
		for n in neighbors6
			npos = pos.plus(n)
			if self.inBounds(npos) and self[npos[0]][npos[1]][npos[2]] == oldValue then
				toDo.push npos
			end if
		end for
	end while
end function

