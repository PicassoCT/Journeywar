--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if not (Spring.GetConfigInt("LuaSocketEnabled", 0) == 1) then
	Spring.Echo("LuaSocketEnabled is configurationally challenged")
	return false
end

function widget:GetInfo()
	return {
		name = "Spring Augmented Reality Plugin",
		desc = "Allows to view the Spring-Engine via Cardbord AR on your phone",
		author = "PicassoCT",
		version = "2.0",
		date = "YearOfTheGNU on a to hot morning between Dubai and Shanghai",
		license = "GNU GPL, v2 or later",
		layer = math.huge,
		hidden = false,
		handler = true,
		enabled = true -- loaded by default?
	}
end
--include("scripts/lib_type.lua" ) 
-- ARDevice --> Broadcast 
-- Host --> Broadcast his IP
-- ARDevice --> Send CFG to HostIP
-- HostWaits for Matrice DATA

local Chili, Screen0
local socket = socket
local message =""
--test
local recieveBroadcastHeader = "SPRINGAR;BROADCAST;ARDEVICE"	
local recieveResetHeader = "SPRINGAR;RESET;"	
local recievedCFGHeader = "SPRINGAR;CFG;"		
local sendBroadCastRecievedMessage	 = "sendBroadCastRecievedMessage"			
local recievedMatriceDataHeader = "SPRINGAR;DATA;CAMERA="	
local QuaternionHeader = "ROTATION="	
local nextStateToGo = recieveBroadcastHeader		
local sendMSGHeader 	= "SPRINGAR;DATA="					
local sendHostmessage = "SPRINGAR;REPLY;HOSTIP="
local sendResetCompleteMessage ="SPRINGAR;RESET_COMPLETE;"
local sendCFGRecievedMsg = "SPRINGAR;CFG;RECIEVED;"
local comSocket
local broadcast
local udp
local BroadcastIpAddress = '*'
local BroadcastSendFromAdress = "255.255.255.255"
local ARDeviceIpAddress = ""
local hostIPAddress = "192.168.178.20"
local TIME_FRAME_IN_MS = 30 
local BR_port = 9000 

local segmentSize = 8000
local watchdogGameFrame= Spring.GetGameFrame()
local TIMEOUT_WATCHDOG = 30 * 60 --seconds
local mapSizeX = Game.mapSizeX
local mapSizeZ = Game.mapSizeZ

local SIZE_SPRING_SQUARE = 2 -- meters, cause no english-american foolin around with cocklengths and gods-toes or other shennanigans


local fileBufferDesc = {} 
fileName= "ARBuffer"
fileBufferDesc[1] = {
	filePathName = "luaui/ar/"..fileName.."1"..".png",
	boolActive = false,	-- is currently a socket writing from this buffer?
	boolNotValid = false	-- is currently a write Process activ on this buffer?
	
}
fileBufferDesc[2] = {
	filePathName = "luaui/ar/"..fileName.."2"..".png",
	boolActive = false,	-- is currently a socket writing from this buffer?
	boolNotValid = false	-- is currently a write Process activ on this buffer?
	
}

------------------------------ Matrice Tools ------------------------------------
--[[
API

matrix function list:
	matrix.add
	matrix.columns
	matrix.concath
	matrix.concatv
	matrix.copy
	matrix.cross
	matrix.det
	matrix.div
	matrix.divnum
	matrix.dogauss
	matrix.elementstostring
	matrix.getelement
	matrix.gsub
	matrix.invert
	matrix.ipairs
	matrix.latex
	matrix.len
	matrix.mul
	matrix.mulnum
	matrix:new
	matrix.normf
	matrix.normmax
	matrix.pow
	matrix.print
	matrix.random
	matrix.replace
	matrix.root
	matrix.rotl
	matrix.rotr
	matrix.round
	matrix.rows
	matrix.scalar
	matrix.setelement
	matrix.size
	matrix.solve
	matrix.sqrt
	matrix.sub
	matrix.subm
	matrix.tostring
	matrix.transpose
	matrix.type
	--]]

--////////////
--// matrix //
--////////////

local matrix = {}

-- access to the metatable we set at the end of the file
local matrix_meta = {}

--/////////////////////////////
--// Get 'new' matrix object //
--/////////////////////////////

--// matrix:new ( rows [, columns [, value]] )
-- if rows is a table then sets rows as matrix
-- if rows is a table of structure {1,2,3} then it sets it as a vector matrix
-- if rows and columns are given and are numbers, returns a matrix with size rowsxcolumns
-- if num is given then returns a matrix with given size and all values set to num
-- if rows is given as number and columns is "I", will return an identity matrix of size rowsxrows
function matrix:new( rows, columns, value )
	-- check for given matrix
	if type( rows ) == "table" then
		-- check for vector
		if type(rows[1]) ~= "table" then -- expect a vector
			return setmetatable( {{rows[1]},{rows[2]},{rows[3]}},matrix_meta )
		end
		return setmetatable( rows,matrix_meta )
	end
	-- get matrix table
	local mtx = {}
	local value = value or 0
	-- build identity matrix of given rows
	if columns == "I" then
		for i = 1,rows do
			mtx[i] = {}
			for j = 1,rows do
				if i == j then
					mtx[i][j] = 1
				else
					mtx[i][j] = 0
				end
			end
		end
		-- build new matrix
	else
		for i = 1,rows do
			mtx[i] = {}
			for j = 1,columns do
				mtx[i][j] = value
			end
		end
	end
	-- return matrix with shared metatable
	return setmetatable( mtx,matrix_meta )
end

--// matrix ( rows [, comlumns [, value]] )
-- set __call behaviour of matrix
-- for matrix( ... ) as matrix.new( ... )
setmetatable( matrix, { __call = function( ... ) return matrix.new( ... ) end } )


-- functions are designed to be light on checks
-- so we get Lua errors instead on wrong input
-- matrix.<functions> should handle any table of structure t[i][j] = value
-- we always return a matrix with scripts metatable
-- cause its faster than setmetatable( mtx, getmetatable( input matrix ) )

--///////////////////////////////
--// matrix 'matrix' functions //
--///////////////////////////////

--// for real, complex and symbolic matrices //--

-- note: real and complex matrices may be added, subtracted, etc.
--		real and symbolic matrices may also be added, subtracted, etc.
--		but one should avoid using symbolic matrices with complex ones
--		since it is not clear which metatable then is used

--// matrix.add ( m1, m2 )
-- Add two matrices; m2 may be of bigger size than m1
function matrix.add( m1, m2 )
	local mtx = {}
	for i = 1,#m1 do
		local m3i = {}
		mtx[i] = m3i
		for j = 1,#m1[1] do
			m3i[j] = m1[i][j] + m2[i][j]
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.sub ( m1 ,m2 )
-- Subtract two matrices; m2 may be of bigger size than m1
function matrix.sub( m1, m2 )
	local mtx = {}
	for i = 1,#m1 do
		local m3i = {}
		mtx[i] = m3i
		for j = 1,#m1[1] do
			m3i[j] = m1[i][j] - m2[i][j]
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.mul ( m1, m2 )
-- Multiply two matrices; m1 columns must be equal to m2 rows
-- e.g. #m1[1] == #m2
function matrix.mul( m1, m2 )
	-- multiply rows with columns
	local mtx = {}
	for i = 1,#m1 do
		mtx[i] = {}
		for j = 1,#m2[1] do
			local num = m1[i][1] * m2[1][j]
			for n = 2,#m1[1] do
				num = num + m1[i][n] * m2[n][j]
			end
			mtx[i][j] = num
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.div ( m1, m2 )
-- Divide two matrices; m1 columns must be equal to m2 rows
-- m2 must be square, to be inverted,
-- if that fails returns the rank of m2 as second argument
-- e.g. #m1[1] == #m2; #m2 == #m2[1]
function matrix.div( m1, m2 )
	local rank; m2,rank = matrix.invert( m2 )
	if not m2 then return m2, rank end -- singular
	return matrix.mul( m1, m2 )
end

--// matrix.mulnum ( m1, num )
-- Multiply matrix with a number
-- num may be of type 'number' or 'complex number'
-- strings get converted to complex number, if that fails then to symbol
function matrix.mulnum( m1, num )
	local mtx = {}
	-- multiply elements with number
	for i = 1,#m1 do
		mtx[i] = {}
		for j = 1,#m1[1] do
			mtx[i][j] = m1[i][j] * num
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.divnum ( m1, num )
-- Divide matrix by a number
-- num may be of type 'number' or 'complex number'
-- strings get converted to complex number, if that fails then to symbol
function matrix.divnum( m1, num )
	local mtx = {}
	-- divide elements by number
	for i = 1,#m1 do
		local mtxi = {}
		mtx[i] = mtxi
		for j = 1,#m1[1] do
			mtxi[j] = m1[i][j] / num
		end
	end
	return setmetatable( mtx, matrix_meta )
end


--// for real and complex matrices only //--

--// matrix.pow ( m1, num )
-- Power of matrix; mtx^(num)
-- num is an integer and may be negative
-- m1 has to be square
-- if num is negative and inverting m1 fails
-- returns the rank of matrix m1 as second argument
function matrix.pow( m1, num )
	assert(num == math.floor(num), "exponent not an integer")
	if num == 0 then
		return matrix:new( #m1,"I" )
	end
	if num < 0 then
		local rank; m1,rank = matrix.invert( m1 )
		if not m1 then return m1, rank end -- singular
		num = -num
	end
	local mtx = matrix.copy( m1 )
	for i = 2,num	do
		mtx = matrix.mul( mtx,m1 )
	end
	return mtx
end

local function number_norm2(x)
	return x * x
end

--// matrix.det ( m1 )
-- Calculate the determinant of a matrix
-- m1 needs to be square
-- Can calc the det for symbolic matrices up to 3x3 too
-- The function to calculate matrices bigger 3x3
-- is quite fast and for matrices of medium size ~(100x100)
-- and average values quite accurate
-- here we try to get the nearest element to |1|, (smallest pivot element)
-- os that usually we have |mtx[i][j]/subdet| > 1 or mtx[i][j];
-- with complex matrices we use the complex.abs function to check if it is bigger or smaller
function matrix.det( m1 )
	
	-- check if matrix is quadratic
	assert(#m1 == #m1[1], "matrix not square")
	
	local size = #m1
	
	if size == 1 then
		return m1[1][1]
	end
	
	if size == 2 then
		return m1[1][1]*m1[2][2] - m1[2][1]*m1[1][2]
	end
	
	if size == 3 then
		return ( m1[1][1]*m1[2][2]*m1[3][3] + m1[1][2]*m1[2][3]*m1[3][1] + m1[1][3]*m1[2][1]*m1[3][2]
		- m1[1][3]*m1[2][2]*m1[3][1] - m1[1][1]*m1[2][3]*m1[3][2] - m1[1][2]*m1[2][1]*m1[3][3] )
	end
	
	--// no symbolic matrix supported below here
	local e = m1[1][1]
	local zero = type(e) == "table" and e.zero or 0
	local norm2 = type(e) == "table" and e.norm2 or number_norm2
	
	--// matrix is bigger than 3x3
	-- get determinant
	-- using Gauss elimination and Laplace
	-- start eliminating from below better for removals
	-- get copy of matrix, set initial determinant
	local mtx = matrix.copy( m1 )
	local det = 1
	-- get det up to the last element
	for j = 1,#mtx[1] do
		-- get smallest element so that |factor| > 1
		-- and set it as last element
		local rows = #mtx
		local subdet,xrow
		for i = 1,rows do
			-- get element
			local e = mtx[i][j]
			-- if no subdet has been found
			if not subdet then
				-- check if element it is not zero
				if e ~= zero then
					-- use element as new subdet
					subdet,xrow = e,i
				end
				-- check for elements nearest to 1 or -1
			elseif e ~= zero and math.abs(norm2(e)-1) < math.abs(norm2(subdet)-1) then
				subdet,xrow = e,i
			end
		end
		-- only cary on if subdet is found
		if subdet then
			-- check if xrow is the last row,
			-- else switch lines and multiply det by -1
			if xrow ~= rows then
				mtx[rows],mtx[xrow] = mtx[xrow],mtx[rows]
				det = -det
			end
			-- traverse all fields setting element to zero
			-- we don't set to zero cause we don't use that column anymore then anyways
			for i = 1,rows-1 do
				-- factor is the dividor of the first element
				-- if element is not already zero
				if mtx[i][j] ~= zero then
					local factor = mtx[i][j]/subdet
					-- update all remaining fields of the matrix, with value from xrow
					for n = j+1,#mtx[1] do
						mtx[i][n] = mtx[i][n] - factor * mtx[rows][n]
					end
				end
			end
			-- update determinant and remove row
			if math.fmod( rows,2 ) == 0 then
				det = -det
			end
			det = det * subdet
			table.remove( mtx )
		else
			-- break here table det is 0
			return det * 0
		end
	end
	-- det ready to return
	return det
end

--// matrix.dogauss ( mtx )
-- Gauss elimination, Gauss-Jordan Method
-- this function changes the matrix itself
-- returns on success: true,
-- returns on failure: false,'rank of matrix'

-- locals
-- checking here for the element nearest but not equal to zero (smallest pivot element).
-- This way the `factor` in `dogauss` will be >= 1, which
-- can give better results.
local pivotOk = function( mtx,i,j,norm2 )
	-- find min value
	local iMin
	local normMin = math.huge
	for _i = i,#mtx do
		local e = mtx[_i][j]
		local norm = math.abs(norm2(e))
		if norm > 0 and norm < normMin then
			iMin = _i
			normMin = norm
		end
	end
	if iMin then
		-- switch lines if not in position.
		if iMin ~= i then
			mtx[i],mtx[iMin] = mtx[iMin],mtx[i]
		end
		return true
	end
	return false
end

local function copy(x)
	return type(x) == "table" and x.copy(x) or x
end

-- note: in --// ... //-- we have a way that does no divison,
-- however with big number and matrices we get problems since we do no reducing
function matrix.dogauss( mtx )
	local e = mtx[1][1]
	local zero = type(e) == "table" and e.zero or 0
	local one = type(e) == "table" and e.one or 1
	local norm2 = type(e) == "table" and e.norm2 or number_norm2
	
	local rows,columns = #mtx,#mtx[1]
	-- stairs left -> right
	for j = 1,rows do
		-- check if element can be setted to one
		if pivotOk( mtx,j,j,norm2 ) then
			-- start parsing rows
			for i = j+1,rows do
				-- check if element is not already zero
				if mtx[i][j] ~= zero then
					-- we may add x*otherline row, to set element to zero
					-- tozero - x*mtx[j][j] = 0; x = tozero/mtx[j][j]
					local factor = mtx[i][j]/mtx[j][j]
					--// this should not be used although it does no division,
					-- yet with big matrices (since we do no reducing and other things)
					-- we get too big numbers
					--local factor1,factor2 = mtx[i][j],mtx[j][j] //--
					mtx[i][j] = copy(zero)
					for _j = j+1,columns do
						--// mtx[i][_j] = mtx[i][_j] * factor2 - factor1 * mtx[j][_j] //--
						mtx[i][_j] = mtx[i][_j] - factor * mtx[j][_j]
					end
				end
			end
		else
			-- return false and the rank of the matrix
			return false,j-1
		end
	end
	-- stairs right <- left
	for j = rows,1,-1 do
		-- set element to one
		-- do division here
		local div = mtx[j][j]
		for _j = j+1,columns do
			mtx[j][_j] = mtx[j][_j] / div
		end
		-- start parsing rows
		for i = j-1,1,-1 do
			-- check if element is not already zero			
			if mtx[i][j] ~= zero then
				local factor = mtx[i][j]
				for _j = j+1,columns do
					mtx[i][_j] = mtx[i][_j] - factor * mtx[j][_j]
				end
				mtx[i][j] = copy(zero)
			end
		end
		mtx[j][j] = copy(one)
	end
	return true
end

--// matrix.invert ( m1 )
-- Get the inverted matrix or m1
-- matrix must be square and not singular
-- on success: returns inverted matrix
-- on failure: returns nil,'rank of matrix'
function matrix.invert( m1 )
	assert(#m1 == #m1[1], "matrix not square")
	local mtx = matrix.copy( m1 )
	local ident = setmetatable( {},matrix_meta )
	local e = m1[1][1]
	local zero = type(e) == "table" and e.zero or 0
	local one = type(e) == "table" and e.one or 1
	for i = 1,#m1 do
		local identi = {}
		ident[i] = identi
		for j = 1,#m1 do
			identi[j] = copy((i == j) and one or zero)
		end
	end
	mtx = matrix.concath( mtx,ident )
	local done,rank = matrix.dogauss( mtx )
	if done then
		return matrix.subm( mtx, 1,(#mtx[1]/2)+1,#mtx,#mtx[1] )
	else
		return nil,rank
	end
end

--// matrix.sqrt ( m1 [,iters] )
-- calculate the square root of a matrix using "Denman Beavers square root iteration"
-- condition: matrix rows == matrix columns; must have a invers matrix and a square root
-- if called without additional arguments, the function finds the first nearest square root to
-- input matrix, there are others but the error between them is very small
-- if called with agument iters, the function will return the matrix by number of iterations
-- the script returns:
--		as first argument, matrix^.5
--		as second argument, matrix^-.5
--		as third argument, the average error between (matrix^.5)^2-inputmatrix
-- you have to determin for yourself if the result is sufficent enough for you
-- local average error
local function get_abs_avg( m1, m2 )
	local dist = 0
	local e = m1[1][1]
	local abs = type(e) == "table" and e.abs or math.abs
	for i=1,#m1 do
		for j=1,#m1[1] do
			dist = dist + abs(m1[i][j]-m2[i][j])
		end
	end
	-- norm by numbers of entries
	return dist/(#m1*2)
end
-- square root function
function matrix.sqrt( m1, iters )
	assert(#m1 == #m1[1], "matrix not square")
	local iters = iters or math.huge
	local y = matrix.copy( m1 )
	local z = matrix(#y, 'I')
	local dist = math.huge
	-- iterate, and get the average error
	for n=1,iters do
		local lasty,lastz = y,z
		-- calc square root
		-- y, z = (1/2)*(y + z^-1), (1/2)*(z + y^-1)
		y, z = matrix.divnum((matrix.add(y,matrix.invert(z))),2),
		matrix.divnum((matrix.add(z,matrix.invert(y))),2)
		local dist1 = get_abs_avg(y,lasty)
		if iters == math.huge then
			if dist1 >= dist then
				return lasty,lastz,get_abs_avg(matrix.mul(lasty,lasty),m1)
			end
		end
		dist = dist1
	end
	return y,z,get_abs_avg(matrix.mul(y,y),m1)
end

--// matrix.root ( m1, root [,iters] )
-- calculate any root of a matrix
-- source: http://www.dm.unipi.it/~cortona04/slides/bruno.pdf
-- m1 and root have to be given;(m1 = matrix, root = number)
-- conditions same as matrix.sqrt
-- returns same values as matrix.sqrt
function matrix.root( m1, root, iters )
	assert(#m1 == #m1[1], "matrix not square")
	local iters = iters or math.huge
	local mx = matrix.copy( m1 )
	local my = matrix.mul(mx:invert(),mx:pow(root-1))
	local dist = math.huge
	-- iterate, and get the average error
	for n=1,iters do
		local lastx,lasty = mx,my
		-- calc root of matrix
		--mx,my = ((p-1)*mx + my^-1)/p,
		--	((((p-1)*my + mx^-1)/p)*my^-1)^(p-2) *
		--	((p-1)*my + mx^-1)/p
		mx,my = mx:mulnum(root-1):add(my:invert()):divnum(root),
		my:mulnum(root-1):add(mx:invert()):divnum(root)
		:mul(my:invert():pow(root-2)):mul(my:mulnum(root-1)
		:add(mx:invert())):divnum(root)
		local dist1 = get_abs_avg(mx,lastx)
		if iters == math.huge then
			if dist1 >= dist then
				return lastx,lasty,get_abs_avg(matrix.pow(lastx,root),m1)
			end
		end
		dist = dist1
	end
	return mx,my,get_abs_avg(matrix.pow(mx,root),m1)
end


--// Norm functions //--

--// matrix.normf ( mtx )
-- calculates the Frobenius norm of the matrix.
-- ||mtx||_F = sqrt(SUM_{i,j} |a_{i,j}|^2)
-- http://en.wikipedia.org/wiki/Frobenius_norm#Frobenius_norm
function matrix.normf(mtx)
	local mtype = matrix.type(mtx)
	local result = 0
	for i = 1,#mtx do
		for j = 1,#mtx[1] do
			local e = mtx[i][j]
			if mtype ~= "number" then e = e:abs() end
			result = result + e^2
		end
	end
	local sqrt = (type(result) == "number") and math.sqrt or result.sqrt
	return sqrt(result)
end

--// matrix.normmax ( mtx )
-- calculates the max norm of the matrix.
-- ||mtx||_{max} = max{|a_{i,j}|}
-- Does not work with symbolic matrices
-- http://en.wikipedia.org/wiki/Frobenius_norm#Max_norm
function matrix.normmax(mtx)
	local abs = (matrix.type(mtx) == "number") and math.abs or mtx[1][1].abs
	local result = 0
	for i = 1,#mtx do
		for j = 1,#mtx[1] do
			local e = abs(mtx[i][j])
			if e > result then result = e end
		end
	end
	return result
end


--// only for number and complex type //--
-- Functions changing the matrix itself

--// matrix.round ( mtx [, idp] )
-- perform round on elements
local numround = function( num,mult )
	return math.floor( num * mult + 0.5 ) / mult
end
local tround = function( t,mult )
	for i,v in ipairs(t) do
		t[i] = math.floor( v * mult + 0.5 ) / mult
	end
	return t
end
function matrix.round( mtx, idp )
	local mult = 10^( idp or 0 )
	local fround = matrix.type( mtx ) == "number" and numround or tround
	for i = 1,#mtx do
		for j = 1,#mtx[1] do
			mtx[i][j] = fround(mtx[i][j],mult)
		end
	end
	return mtx
end

--// matrix.random( mtx [,start] [, stop] [, idip] )
-- fillmatrix with random values
local numfill = function( _,start,stop,idp )
	return math.random( start,stop ) / idp
end
local tfill = function( t,start,stop,idp )
	for i in ipairs(t) do
		t[i] = math.random( start,stop ) / idp
	end
	return t
end
function matrix.random( mtx,start,stop,idp )
	local start,stop,idp = start or -10,stop or 10,idp or 1
	local ffill = matrix.type( mtx ) == "number" and numfill or tfill
	for i = 1,#mtx do
		for j = 1,#mtx[1] do
			mtx[i][j] = ffill( mtx[i][j], start, stop, idp )
		end
	end
	return mtx
end


--//////////////////////////////
--// Object Utility Functions //
--//////////////////////////////

--// for all types and matrices //--

--// matrix.type ( mtx )
-- get type of matrix, normal/complex/symbol or tensor
function matrix.type( mtx )
	local e = mtx[1][1]
	if type(e) == "table" then
		if e.type then
			return e:type()
		end
		return "tensor"
	end
	return "number"
end

-- local functions to copy matrix values
local num_copy = function( num )
	return num
end
local t_copy = function( t )
	local newt = setmetatable( {}, getmetatable( t ) )
	for i,v in ipairs( t ) do
		newt[i] = v
	end
	return newt
end

--// matrix.copy ( m1 )
-- Copy a matrix
-- simple copy, one can write other functions oneself
function matrix.copy( m1 )
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	local mtx = {}
	for i = 1,#m1[1] do
		mtx[i] = {}
		for j = 1,#m1 do
			mtx[i][j] = docopy( m1[i][j] )
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.transpose ( m1 )
-- Transpose a matrix
-- switch rows and columns
function matrix.transpose( m1 )
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	local mtx = {}
	for i = 1,#m1[1] do
		mtx[i] = {}
		for j = 1,#m1 do
			mtx[i][j] = docopy( m1[j][i] )
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.subm ( m1, i1, j1, i2, j2 )
-- Submatrix out of a matrix
-- input: i1,j1,i2,j2
-- i1,j1 are the start element
-- i2,j2 are the end element
-- condition: i1,j1,i2,j2 are elements of the matrix
function matrix.subm( m1,i1,j1,i2,j2 )
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	local mtx = {}
	for i = i1,i2 do
		local _i = i-i1+1
		mtx[_i] = {}
		for j = j1,j2 do
			local _j = j-j1+1
			mtx[_i][_j] = docopy( m1[i][j] )
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.concath( m1, m2 )
-- Concatenate two matrices, horizontal
-- will return m1m2; rows have to be the same
-- e.g.: #m1 == #m2
function matrix.concath( m1,m2 )
	assert(#m1 == #m2, "matrix size mismatch")
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	local mtx = {}
	local offset = #m1[1]
	for i = 1,#m1 do
		mtx[i] = {}
		for j = 1,offset do
			mtx[i][j] = docopy( m1[i][j] )
		end
		for j = 1,#m2[1] do
			mtx[i][j+offset] = docopy( m2[i][j] )
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.concatv ( m1, m2 )
-- Concatenate two matrices, vertical
-- will return	m1
--					m2
-- columns have to be the same; e.g.: #m1[1] == #m2[1]
function matrix.concatv( m1,m2 )
	assert(#m1[1] == #m2[1], "matrix size mismatch")
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	local mtx = {}
	for i = 1,#m1 do
		mtx[i] = {}
		for j = 1,#m1[1] do
			mtx[i][j] = docopy( m1[i][j] )
		end
	end
	local offset = #mtx
	for i = 1,#m2 do
		local _i = i + offset
		mtx[_i] = {}
		for j = 1,#m2[1] do
			mtx[_i][j] = docopy( m2[i][j] )
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.rotl ( m1 )
-- Rotate Left, 90 degrees
function matrix.rotl( m1 )
	local mtx = matrix:new( #m1[1],#m1 )
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	for i = 1,#m1 do
		for j = 1,#m1[1] do
			mtx[#m1[1]-j+1][i] = docopy( m1[i][j] )
		end
	end
	return mtx
end

--// matrix.rotr ( m1 )
-- Rotate Right, 90 degrees
function matrix.rotr( m1 )
	local mtx = matrix:new( #m1[1],#m1 )
	local docopy = matrix.type( m1 ) == "number" and num_copy or t_copy
	for i = 1,#m1 do
		for j = 1,#m1[1] do
			mtx[j][#m1-i+1] = docopy( m1[i][j] )
		end
	end
	return mtx
end

local function tensor_tostring( t,fstr )
	if not fstr then return "["..table.concat(t,",").."]" end
	local tval = {}
	for i,v in ipairs( t ) do
		tval[i] = string.format( fstr,v )
	end
	return "["..table.concat(tval,",").."]"
end
local function number_tostring( e,fstr )
	return fstr and string.format( fstr,e ) or e
end

--// matrix.tostring ( mtx, formatstr )
-- tostring function
function matrix.tostring( mtx, formatstr )
	local ts = {}
	local mtype = matrix.type( mtx )
	local e = mtx[1][1]
	local tostring = mtype == "tensor" and tensor_tostring or
	type(e) == "table" and e.tostring or number_tostring
	for i = 1,#mtx do
		local tstr = {}
		for j = 1,#mtx[1] do
			tstr[j] = tostring(mtx[i][j],formatstr)
		end
		ts[i] = table.concat(tstr, "\t")
	end
	return table.concat(ts, "\n")
end

--// matrix.print ( mtx [, formatstr] )
-- print out the matrix, just calls tostring
function matrix.print( ... )
	print( matrix.tostring( ... ) )
end

--// matrix.latex ( mtx [, align] )
-- LaTeX output
function matrix.latex( mtx, align )
	-- align : option to align the elements
	--		c = center; l = left; r = right
	--		\usepackage{dcolumn}; D{.}{,}{-1}; aligns number by . replaces it with ,
	local align = align or "c"
	local str = "$\\left( \\begin{array}{"..string.rep( align, #mtx[1] ).."}\n"
	local getstr = matrix.type( mtx ) == "tensor" and tensor_tostring or number_tostring
	for i = 1,#mtx do
		str = str.."\t"..getstr(mtx[i][1])
		for j = 2,#mtx[1] do
			str = str.." & "..getstr(mtx[i][j])
		end
		-- close line
		if i == #mtx then
			str = str.."\n"
		else
			str = str.." \\\\\n"
		end
	end
	return str.."\\end{array} \\right)$"
end


--// Functions not changing the matrix

--// matrix.rows ( mtx )
-- return number of rows
function matrix.rows( mtx )
	return #mtx
end

--// matrix.columns ( mtx )
-- return number of columns
function matrix.columns( mtx )
	return #mtx[1]
end

--// matrix.size ( mtx )
-- get matrix size as string rows,columns
function matrix.size( mtx )
	if matrix.type( mtx ) == "tensor" then
		return #mtx,#mtx[1],#mtx[1][1]
	end
	return #mtx,#mtx[1]
end

--// matrix.getelement ( mtx, i, j )
-- return specific element ( row,column )
-- returns element on success and nil on failure
function matrix.getelement( mtx,i,j )
	if mtx[i] and mtx[i][j] then
		return mtx[i][j]
	end
end

--// matrix.setelement( mtx, i, j, value )
-- set an element ( i, j, value )
-- returns 1 on success and nil on failure
function matrix.setelement( mtx,i,j,value )
	if matrix.getelement( mtx,i,j ) then
		-- check if value type is number
		mtx[i][j] = value
		return 1
	end
end

--// matrix.ipairs ( mtx )
-- iteration, same for complex
function matrix.ipairs( mtx )
	local i,j,rows,columns = 1,0,#mtx,#mtx[1]
	local function iter()
		j = j + 1
		if j > columns then -- return first element from next row
			i,j = i + 1,1
		end
		if i <= rows then
			return i,j
		end
	end
	return iter
end

--///////////////////////////////
--// matrix 'vector' functions //
--///////////////////////////////

-- a vector is defined as a 3x1 matrix
-- get a vector; vec = matrix{{ 1,2,3 }}^'T'

--// matrix.scalar ( m1, m2 )
-- returns the Scalar Product of two 3x1 matrices (vectors)
function matrix.scalar( m1, m2 )
	return m1[1][1]*m2[1][1] + m1[2][1]*m2[2][1] + m1[3][1]*m2[3][1]
end

--// matrix.cross ( m1, m2 )
-- returns the Cross Product of two 3x1 matrices (vectors)
function matrix.cross( m1, m2 )
	local mtx = {}
	mtx[1] = { m1[2][1]*m2[3][1] - m1[3][1]*m2[2][1] }
	mtx[2] = { m1[3][1]*m2[1][1] - m1[1][1]*m2[3][1] }
	mtx[3] = { m1[1][1]*m2[2][1] - m1[2][1]*m2[1][1] }
	return setmetatable( mtx, matrix_meta )
end

--// matrix.len ( m1 )
-- returns the Length of a 3x1 matrix (vector)
function matrix.len( m1 )
	return math.sqrt( m1[1][1]^2 + m1[2][1]^2 + m1[3][1]^2 )
end


--// matrix.replace (mtx, func, ...)
-- for each element e in the matrix mtx, replace it with func(mtx, ...).
function matrix.replace( m1, func, ... )
	local mtx = {}
	for i = 1,#m1 do
		local m1i = m1[i]
		local mtxi = {}
		for j = 1,#m1i do
			mtxi[j] = func( m1i[j], ... )
		end
		mtx[i] = mtxi
	end
	return setmetatable( mtx, matrix_meta )
end

--// matrix.remcomplex ( mtx )
-- set the matrix elements to strings
-- IMPROVE: tostring v.s. tostringelements confusing
function matrix.elementstostrings( mtx )
	local e = mtx[1][1]
	local tostring = type(e) == "table" and e.tostring or tostring
	return matrix.replace(mtx, tostring)
end

--// matrix.solve ( m1 )
-- solve; tries to solve a symbolic matrix to a number
function matrix.solve( m1 )
	assert( matrix.type( m1 ) == "symbol", "matrix not of type 'symbol'" )
	local mtx = {}
	for i = 1,#m1 do
		mtx[i] = {}
		for j = 1,#m1[1] do
			mtx[i][j] = tonumber( loadstring( "return "..m1[i][j][1] )() )
		end
	end
	return setmetatable( mtx, matrix_meta )
end

--////////////////////////--
--// METATABLE HANDLING //--
--////////////////////////--

--// MetaTable
-- as we declaired on top of the page
-- local/shared metatable
-- matrix_meta

-- note '...' is always faster than 'arg1,arg2,...' if it can be used

-- Set add "+" behaviour
matrix_meta.__add = function( ... )
	return matrix.add( ... )
end

-- Set subtract "-" behaviour
matrix_meta.__sub = function( ... )
	return matrix.sub( ... )
end

-- Set multiply "*" behaviour
matrix_meta.__mul = function( m1,m2 )
	if getmetatable( m1 ) ~= matrix_meta then
		return matrix.mulnum( m2,m1 )
	elseif getmetatable( m2 ) ~= matrix_meta then
		return matrix.mulnum( m1,m2 )
	end
	return matrix.mul( m1,m2 )
end

-- Set division "/" behaviour
matrix_meta.__div = function( m1,m2 )
	if getmetatable( m1 ) ~= matrix_meta then
		return matrix.mulnum( matrix.invert(m2),m1 )
	elseif getmetatable( m2 ) ~= matrix_meta then
		return matrix.divnum( m1,m2 )
	end
	return matrix.div( m1,m2 )
end

-- Set unary minus "-" behavior
matrix_meta.__unm = function( mtx )
	return matrix.mulnum( mtx,-1 )
end

-- Set power "^" behaviour
-- if opt is any integer number will do mtx^opt
-- (returning nil if answer doesn't exist)
-- if opt is 'T' then it will return the transpose matrix
-- only for complex:
-- if opt is '*' then it returns the complex conjugate matrix
local option = {
	-- only for complex
	["*"] = function( m1 ) return matrix.conjugate( m1 ) end,
	-- for both
	["T"] = function( m1 ) return matrix.transpose( m1 ) end,
}
matrix_meta.__pow = function( m1, opt )
	return option[opt] and option[opt]( m1 ) or matrix.pow( m1,opt )
end

-- Set equal "==" behaviour
matrix_meta.__eq = function( m1, m2 )
	-- check same type
	if matrix.type( m1 ) ~= matrix.type( m2 ) then
		return false
	end
	-- check same size
	if #m1 ~= #m2 or #m1[1] ~= #m2[1] then
		return false
	end
	-- check elements equal
	for i = 1,#m1 do
		for j = 1,#m1[1] do
			if m1[i][j] ~= m2[i][j] then
				return false
			end
		end
	end
	return true
end

-- Set tostring "tostring( mtx )" behaviour
matrix_meta.__tostring = function( ... )
	return matrix.tostring( ... )
end

-- set __call "mtx( [formatstr] )" behaviour, mtx [, formatstr]
matrix_meta.__call = function( ... )
	matrix.print( ... )
end

--// __index handling
matrix_meta.__index = {}
for k,v in pairs( matrix ) do
	matrix_meta.__index[k] = v
end


--/////////////////////////////////
--// symbol class implementation
--/////////////////////////////////

-- access to the symbolic metatable
local symbol_meta = {}; symbol_meta.__index = symbol_meta
local symbol = symbol_meta

function symbol_meta.new(o)
	return setmetatable({tostring(o)}, symbol_meta)
end
symbol_meta.to = symbol_meta.new

-- symbol( arg )
-- same as symbol.to( arg )
-- set __call behaviour of symbol
setmetatable( symbol_meta, { __call = function( _,s ) return symbol_meta.to( s ) end } )


-- Converts object to string, optionally with formatting.
function symbol_meta.tostring( e,fstr )
	return string.format( fstr,e[1] )
end

-- Returns "symbol" if object is a symbol type, else nothing.
function symbol_meta:type()
	if getmetatable(self) == symbol_meta then
		return "symbol"
	end
end

-- Performs string.gsub on symbol.
-- for use in matrix.replace
function symbol_meta:gsub(from, to)
	return symbol.to( string.gsub( self[1],from,to ) )
end

-- creates function that replaces one letter by something else
-- makereplacer( "a",4,"b",7, ... )(x)
-- will replace a with 4 and b with 7 in symbol x.
-- for use in matrix.replace
function symbol_meta.makereplacer( ... )
	local tosub = {}
	local args = {...}
	for i = 1,#args,2 do
		tosub[args[i]] = args[i+1]
	end
	local function func( a ) return tosub[a] or a end
	return function(sym)
		return symbol.to( string.gsub( sym[1], "%a", func ) )
	end
end

-- applies abs function to symbol
function symbol_meta.abs(a)
	return symbol.to("(" .. a[1] .. "):abs()")
end

-- applies sqrt function to symbol
function symbol_meta.sqrt(a)
	return symbol.to("(" .. a[1] .. "):sqrt()")
end

function symbol_meta.__add(a,b)
	return symbol.to(a .. "+" .. b)
end

function symbol_meta.__sub(a,b)
	return symbol.to(a .. "-" .. b)
end

function symbol_meta.__mul(a,b)
	return symbol.to("(" .. a .. ")*(" .. b .. ")")
end

function symbol_meta.__div(a,b)
	return symbol.to("(" .. a .. ")/(" .. b .. ")")
end

function symbol_meta.__pow(a,b)
	return symbol.to("(" .. a .. ")^(" .. b .. ")")
end

function symbol_meta.__eq(a,b)
	return a[1] == b[1]
end

function symbol_meta.__tostring(a)
	return a[1]
end

function symbol_meta.__concat(a,b)
	return tostring(a) .. tostring(b)
end

matrix.symbol = symbol

-----------------------> Library End

function scaleMatrice(objInCamCoord_mat, sx,sy,sz)
		scale_mat = matrix{{sx,0,0,0},
		{0,sy,0,0},
		{0,0,sz,0},
	{0,0,0,1}}
	
	return scale_mat* objInCamCoord_mat
end

function getMinorMat(mat, row, col)
	sign= (-1)^(row+col)
	minor= matrix(#mat-1,#mat-1,0)
	for i=1,#minor do
		for j=1,#minor do
			ix,jx = i,j
			if ix >= row then ix = ix+1 end
			if jx >= col then jx = jx+1 end
			minor[i][j] = sign*mat[ix][jx]
		end
	end
	
	return minor
end

function quaternionToEulerAngle( x, y, z, w)
	
	t0 = 2.0 * (w * x + y * z);
	t1 = 1.0 - 2.0 * (x * x + y * y);
	X = math.atan2(t0, t1);
	
	t2 = 2.0 * (w * y - z * x);
	if(t2 > 1.0) then
		t2 = 1.0;
	elseif(t2 < -1.0)then
		t2 = -1.0;
	end
	Y = math.asin(t2);
	
	t3 = 2.0 * (w * z + x * y);
	t4 = 1.0 - 2.0 * (y * y + z * z);
	Z = math.atan2(t3, t4);
	
	return X*math.pi, Y*math.pi, Z*math.pi
end

function setCamera(camPos, rot_quat)
	camState = Spring.GetCameraState()

	MAX_MAP_SIZE = math.max(mapSizeZ,mapSizeX)
	--Scalefactor = OriginalScale(1m)/TotalSizeOfSquareInReality (e.g. 2m)* biggest map size in Elmo
	scaleFactor = (SIZE_SPRING_SQUARE * MAX_MAP_SIZE)
	
	for i=1,4 do
		camPos[i]=camPos[i]*scaleFactor
	end
	
	camPos[1] =camPos[1] + MAX_MAP_SIZE/2
	camPos[2] =camPos[2] + MAX_MAP_SIZE/2	

	camState.px= camPos[1]
	camState.pz= camPos[2]
	camState.py= camPos[3]
	
	x,y,z,w=rot_quat[1],rot_quat[2],rot_quat[3],rot_quat[4]
		
	camState.dx = 2.0 * (x * z - w * y)
	camState.dy = 2.0 * (y * z + w * x)
	camState.dz = 1.0 - 2.0 * (x * x + y * y)
	
	
	--extract the rotation from the quaternion
	--camState.dx, camState.dz,	camState.dy= quaternionToEulerAngle(rot_quat[1],rot_quat[2],rot_quat[3],rot_quat[4])
	--extract the rotation components as radiants
	--camState.dx, camState.dz,	camState.dy= math.random(-10,10)/10, math.random(-10,10)/10, math.random(-10,10)/10
	Spring.SetCameraState(camState)
end
------------------------------ String Tools ------------------------------------

-->splits a string with seperators into a table of substrings
function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
--> serializes a whole table to string
function tableToString(tab)
	PostFix = "}"
	PreFix = "{"
	conCat=""..PreFix
	for key, value in pairs(tab) do
		conCat= conCat.."["..toString(key).."] ="..toString(value)..","
	end
	
	return conCat..PostFix
end

--> converts a non-stringElement to String
function toString(element)
	typeE = type(element)
	
	if typeE == "boolean" then
		if element == true then 
			return "true"
		else 
			return "false"
		end 
	end
	if typeE == "number" then return ""..element end
	if typeE == "string" then return element end
	if typeE == "table" then return tableToString(element) end
end

-->removes whitespacecharacters from a string
function trim(s)
	return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

--> Echos the spring connection related settings out
local function dumpConfig()
	-- dump all luasocket related config settings to console
	for _, conf in ipairs({"TCPAllowConnect", "TCPAllowListen", "UDPAllowConnect", "UDPAllowListen" }) do
		Spring.Echo(conf .. " = " .. Spring.GetConfigString(conf, ""))
	end
end

--------------------- Data Transfer Logic for Buffer---------------------------

local deviceData={
	deviceName = 	'S8',
	viewWidth = 	60,
	viewHeigth = 	70,
	seperator = 	30
}

local tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 

function getActiveBuffer()
	if fileBufferDesc[1].boolActive == true then return fileBufferDesc[1], 1 end
	
	return fileBufferDesc[2], 2
end

function getWriteableBuffer()
	if fileBufferDesc[1].boolNotValid == true then return fileBufferDesc[1], 1 end
	
	return fileBufferDesc[2], 2
end

--> Handled by writing function once done- waiting for the sendeSemaphore to drop
function switchWriteBuffer()
	Spring.Echo("function switchWriteBuffer()")
	_, activeBufferNr = getActiveBuffer()
	_, writeBufferNr = getWriteableBuffer()
	while boolSendDataSemaphore == true do
		Sleep(1)
	end
	fileBufferDesc[activeBufferNr].boolActive = false
	fileBufferDesc[activeBufferNr].boolNotValid = true
	
	fileBufferDesc[writeBufferNr].boolActive = true
	fileBufferDesc[writeBufferNr].boolNotValid = false
end

boolDataInBufferValid = false
local coWriteBuffer

--> Drops a screenshot to file in a coroutine
function copyFrameToBuffer()
	Spring.Echo("function copyFrameToBuffer()")
	if not coWriteBuffer or coroutine.status(coWriteBuffer) == "dead" then
		-- socket is writeable
		
		coWriteBuffer=		coroutine.create(function()
			gl.CopyToTexture(tex, 0, 0, 0, 0, deviceData.viewWidth, deviceData.viewHeigth);
			gl.RenderToTexture(	tex, 
			gl.SaveImage,
			0,
			0,
			deviceData.viewWidth,
			deviceData.viewHeigth, 
			getWriteableBuffer().filePathName);
			
			switchWriteBuffer()										
		end
		)
		coroutine.resume(coWriteBuffer)
		
		
	end
end
--------------------------------------------------------------------------------

-->Creates and returns an unconnected UDP object. Unconnected objects support the sendto, 
-- receive, receivefrom, getsockname, setoption, settimeout, setpeername, setsockname, and close. 
-- The setpeername is used to connect the object.
function BroadcastConnect()
	Spring.Echo(" Broadcast SocketConnect("..BroadcastIpAddress..",".. BR_port..")")
	broadcast=socket.udp()
	assert(broadcast:settimeout(0))
	assert(broadcast:setoption('broadcast', true))
	--assert(broadcast:setoption('dontroute', true))
	success, errmsg =	broadcast:setsockname(BroadcastIpAddress, BR_port)
	if not success then Spring.Echo(errmsg) end
	return broadcast
end

--> opens a udpsocket
function UDPConnect(ip, peername, peerport)
	Spring.Echo(" UDPSocketConnect("..ip..",".. BR_port..")")
	if not udp then
		udp=socket.udp()
		assert(udp:settimeout(1/66))
		success, errmsg = udp:setsockname(ip, BR_port)
		assert(success, errmsg)
		
		if peername then -- changes a unconnected udp port into a connected udp-port
			assert(udp:setpeername(peername, peerport))
		end
	end
	return udp
end

function sendMessage(Socket, ip, port, data)
	assert(type(ip) == "string")
	assert(type(port) == "string" or type(port) == "number")
	assert(type(data) == "string")
	Spring.Echo("gui_arCam::sendMessage:" .. data .. " to " .. ip)
	if Socket then
		
		local	 success, e_msg = Socket:sendto(data, ip, port)
		
		if not success then
			Spring.Echo("Failed to send message " .. data .. " to " ..ip.." with error "..e_msg)
		end
	end
	return success, e_msg
end

function widget:Shutdown()
	if udp then udp:close() end
	if broadcast then broadcast:close() end
end
function widget:Initialize()	
	Spring.Echo("function widget:Initialize()")
	
	fileBufferDesc[1].boolNotValid = false
	fileBufferDesc[1].Active = true
	
	comSocket = BroadcastConnect()	
	nextStateToGo = recieveBroadcastHeader
	
end


local coSendData 
boolSendDataSemaphore = false
-- called when data can be written to a socket
local function transferDataToARDevice(ip)
	
	-- load image
	-- Spring.Echo("Sending test data to "..ARDeviceIpAddress)
	
	if nextStateToGo == recievedMatriceDataHeader then		
		
		if not coSendData or coroutine.status(coSendData) == "dead" then
			-- socket is writeable
			
			coSendData=		coroutine.create(function()
				
				data = VFS.LoadFile(getActiveBuffer().filePathName)				
				boolSendDataSemaphore = true
				numberOfSegments = data:len()/segmentSize
				
				for i=0, i < numberOfSegments, 1 do
					local segment = data:sub(i*segmentSize +1,(i+1)*segmentSize +1)
					
					local success, e_msg = nil, nil
					if i+1 < numberOfSegments then
						success, e_msg = udp:sendto(sendMSGHeader..i..";"..segment, ARDeviceIpAddress, BR_port)
					else
						success, e_msg = udp:sendto(sendMSGHeader.."LAST;"..segment, ARDeviceIpAddress, BR_port)
					end
					if not success then
						Spring.Echo("transferDataToARDevice"..e_msg)
					end
				end
				boolSendDataSemaphore = false
			end
			)
			if boolSendDataSemaphore == false then
				coroutine.resume(coSendData)
			end
		end
	end
end

oldState = nil
function whoWatchesTheWatchdog(newState)
	
	if newState == oldState and newState ~= recievedMatriceDataHeader then 
		
		if Spring.GetGameFrame() - watchdogGameFrame > TIMEOUT_WATCHDOG then
			nextStateToGo =recieveResetHeader
			watchdogGameFrame = Spring.GetGameFrame()
		end	
	end
	
	if newState ~= oldState then 
		Spring.Echo("Statemachine: "..newState)
		watchdogGameFrame = Spring.GetGameFrame()
	end
	
	oldState = newState
end

function RecieveConfigureARCameraMessage(configStr)
	Spring.Echo("RecieveConfigureARCameraMessage:"..configStr)
	configStr= configStr:gsub(recievedCFGHeader,"")
	arrayOfTokens = split(configStr,";")
	Spring.Echo(arrayOfTokens)
	if arrayOfTokens[5] then
		deviceData.deviceName = arrayOfTokens[1]:gsub("MODEL","") or "No model Name recieved"
		displayWidth= arrayOfTokens[2]:gsub("DISPLAYWIDTH=","")
		
		deviceData.viewWidth = tonumber(displayWidth)
		displayHeigth = arrayOfTokens[3]:gsub("DISPLAYHEIGTH=","")
		
		deviceData.viewHeigth = tonumber(displayHeigth)
		displayRatio = arrayOfTokens[4]:gsub("DISPLAYDIVIDE=","") 
		
		deviceData.seperator = math.min(100,math.max(1,tonumber(displayRatio)		or 50))
		ARDeviceIpAddress = arrayOfTokens[5]:gsub("IPADDRESS=","") 
		
		-- Spring.Echo(deviceData.viewWidth,deviceData.viewHeigth, ARDeviceIpAddress)
		tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 
		return true
	end
	return false
end

old_camPos ={0,0,0,0}
oldrot_quat= {0,0,0,0}
function setCamMatriceFromMessage(recievedData)

		if recievedData then
		recievedData=recievedData:gsub(recievedMatriceDataHeader,'')
		recievedData=recievedData:gsub(QuaternionHeader,'')
		raw_data = split(recievedData, ";")

		boolCompleteCamMatrix= true
		camPos ={0,0,0,0}
		for i=1, 4 do
			mat_val = tonumber(raw_data[i])
			if false == (type(mat_val)=="number") then 
				boolCompleteCamMatrix = false
				break
			end
			camPos[i]= mat_val		
		end		
		if boolCompleteCamMatrix == true then
			old_camPos= camPos
		end
		
		boolCompleteRotQuat = true
		newrot_quat = {0,0,0,0}
		for q=i+1, i+4 do
			newrot_quat[q-i] = tonumber(raw_data[q])
			if false == (type(newrot_quat[q-i]) == "number") then 
				boolCompleteRotQuat = false
				break
			end
		end	
		
		if boolCompleteRotQuat == true then
			oldrot_quat= newrot_quat
		end
		
		setCamera(old_camPos, oldrot_quat)
	end
end

function widget:Update()

	data, ip, port = nil, nil, nil
	
	data, ip, port = comSocket:receivefrom()
	
	if data and ip then Spring.Echo("Recieved text " .. data .. " from " ..ip) end
	
	if data and data:find(recieveResetHeader) then
		nextStateToGo = recieveResetHeader
	end	
	Spring.Echo("CurrentState:"..nextStateToGo)
	communicationStateMachine[nextStateToGo](data,ip,port)
	
	whoWatchesTheWatchdog(nextStateToGo)
	
	
	if nextStateToGo == recievedMatriceDataHeader and true == false  then
		--upate only on completed transfer
		if boolSendDataSemaphore == false then
			copyFrameToBuffer()
		end
		transferDataToARDevice(ARDeviceIpAddress)
	end
end

delay = 0
--> Simple Statemachine in Table
communicationStateMachine= 
{
	[recieveResetHeader] = function (data, ip, port)
		comSocket = broadcast
		local success, e_msg = sendMessage(comSocket, BroadcastSendFromAdress, BR_port, sendResetCompleteMessage )
		if success then
			nextStateToGo = recieveBroadcastHeader 	
		end		
	end,	
	[recieveBroadcastHeader] = function (data, ip, port)
		if data and data:find(recieveBroadcastHeader) then
			--Spring.Echo("recieveBroadcastHeader:"..data.." from "..ip)
			ARDeviceIpAddress = ip
			local success, e_msg=	sendMessage(comSocket, BroadcastSendFromAdress, BR_port, sendHostmessage..hostIPAddress)	
			--Spring.Echo("sendHostmessage "..sendHostmessage..hostIPAddress.." -> "..ARDeviceIpAddress..":"..BR_port)
			nextStateToGo = recievedCFGHeader 
			
		end
	end,		
	[recievedCFGHeader]= function (data, ip, port)
		if data and data:find(recievedCFGHeader) then
			comSocket = UDPConnect("192.168.178.20") --hostIPAddress
			if RecieveConfigureARCameraMessage(data) == true then	
				sendMessage(udp, ARDeviceIpAddress, BR_port, sendCFGRecievedMsg)						
				nextStateToGo = recievedMatriceDataHeader 
			end
		end			
	end,	
	
	[recievedMatriceDataHeader] = function (data, ip, port)		
		if data and data:find(recievedMatriceDataHeader) then
			setCamMatriceFromMessage(data)
		end
	end,
	
}
