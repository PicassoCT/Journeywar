--//=============================================================================
VFS.Include(CHILI_DIRNAME .. "headers/borderline.lua", nil, VFS.RAW_FIRST)
VFS.Include(CHILI_DIRNAME .. "headers/util.lua", nil, VFS.RAW_FIRST)
--- HabaneroButton module

--- HabaneroButton fields.
-- Inherits from Control.
-- @see control.Control
-- @table HabaneroButton
-- @string[opt="HabaneroButton"] caption caption to be displayed
HabaneroButton = Control:Inherit{
	classname= "HabaneroButton",
	caption = 'HabaneroButton', 
	--local Coordinates
	defaultWidth = 70,
	width= 0,
	defaultHeight = 20,
	heigth = 0,
	xMin= 0,
	xMax = 1,
	yMin = 0,
	yMax = 1,
	midPointX=0,
	midPointY=0,
	boolInFocus=false,
	boolRelativePixelSize = false,
	cmdID = 0,
	numberOfStates= 3,
	currentState = 1,
	boolSelectable= false,
	boolSelected = false,

	currentColor = {0,0,0,1},
	selectedTextColor ={1,1,1,1},
	unselectedTextColor ={0,0,0,1},
	stateColors={
				[1]={245/255,64/255,9/255, 0.6},
				[2]={24/255,238/255,191/255, 0.6},
				[3]={27/255,234/255,31/255, 0.6}
				},
	stateOffset = 0,
	
	borderline ={},
	boolBorder= false,
	borderColor = { 0, 0, 0.1, 1},
	borderType = "static",

	--focusColor
	--activeColor
	--backgroundColor
	--stateTriColor[3]
	
	--Points in Order, Clockwise in local Coordinates - last coordinate is a Copy of the first
	--triStrip should not be self-intersecting or incomplete
	triStrip ={}
}

local this = HabaneroButton
local inherited = this.inherited

--//=============================================================================

--- Sets the caption of the HabaneroButton
-- @string caption new caption of the HabaneroButton
function HabaneroButton:SetCaption(caption)
	if (self.caption == caption) then return end
	self.caption = caption
	self:Invalidate()
end

function HabaneroButton:FlipState(cmd)
	if (self.boolSelectable == true) then self.boolSelectable = false else self.boolSelectable = true end
end

function HabaneroButton:SetSelectable( bActive )
	self.boolSelectable = bActive	
	self:setCurrentColorByState()
	self:Invalidate()
end
function HabaneroButton:SetSelected( bActive )
	self.boolSelected = bActive	
	self:setCurrentColorByState()
	self:Invalidate()
end

function boolToNumber(bool)
if type(bool) ~= "boolean" then return bool end
	if bool == true then 
		return 1
	else 
		return 0 
	end
end

function HabaneroButton:SetState( State, StateMax )
	State = boolToNumber(State) + self.stateOffset

	self.numberOfStates = StateMax
	self.currentState = ((State - 1 ) % self.numberOfStates)+1
	
	self:setCurrentColorByState()
	self:Invalidate()
end

--//=============================================================================


--//=============================================================================

function HabaneroButton:DrawControl()
	--// gets overriden by the skin/theme
end

--//=============================================================================
function getZeroScreen(this)
	while this.parent do 	this = this.parent;	end
	
	return this
end


function HabaneroButton:mixByStateFactor(self, factor, smallestStep)
	if #self.stateColors < 2 then return self.stateColors[1]end

	lowerStep= math.max(1,math.floor((factor*self.numberOfStates)/smallestStep))
	upperStep= math.min(math.ceil((factor*self.numberOfStates)/smallestStep), self.numberOfStates)

	return mixTable(self.stateColors[lowerStep],self.stateColors[upperStep], (factor-(lowerStep*smallestStep)/smallestStep))
end

function HabaneroButton:setCurrentColorByState()
	self.font.color = self.unselectedTextColor
	self.currentColor = self.backgroundColor
		
	if self.boolSelectable == true then
		self.font.color = self.selectedTextColor	
		self.currentColor = mixTable(self.activeColor, self.backgroundColor,0.5)	
	end
	
	if self.boolInFocus == true and self.boolSelectable == true  then	
		self.currentColor = self.focusColor
	end
	
	if self.boolSelected == true then
		self.currentColor = self.activeColor
	end

	if string.find(self.name, 'statebutton') and self.boolSelectable == true then
		index = math.max(1, math.min(self.numberOfStates,self.currentState))
		factor= index/self.numberOfStates
		
		self.currentColor = self:mixByStateFactor(self, factor, #self.stateColors/self.numberOfStates)
	end
end

function getRecursivePixelDimensions(this)
	if this.parent then
		if this.parent.width and this.parent.height then
			typeWidth, typeHeight = type(this.parent.width) , type(this.parent.height)
			
			if typeWidth == "string" and typeHeight == "string" then
				factorWidth = 100/tonumber(string.sub(this.parent.width,'%%',''))
				factorHeigth = 100/tonumber(string.sub(this.parent.heigth,'%%',''))
				px,py = getRecursivePixelDimensions(this.parent)
				return factorWidth* px, factorHeigth * py
			else
				return this.parent.width, this.parent.height
			end
		end
	end
	
	return this.width, this.height
end

--> gets the parents of the handed objects absolut size in pixel, and the gridslotdimensions
function getParentTotalSizePixel(self)
	--debugging
	zeroScreen = getZeroScreen(self)
	
	--no parent
	if not self.parent then error("No parent existing for HabaneroButton "..self.caption); return end
	
	--self is root
	if self == zeroScreen then
		return zeroScreen.width, zeroScreen.height	
	end
	
	typeX,typeY=type(self.parent.width),type(self.parent.height)
	rows,columns = self.parent.rows or 1 , self.parent.columns or 1
	
	if typeX == "string" and typeY == "string" then
		px,py = getRecursivePixelDimensions(self.parent)
		return px, py, rows, columns
	else
		return self.parent.width, self.parent.height, rows, columns
	end
	
end


--//=============================================================================

-- M = M_Hexagon
-- When D(p1, p2, p3) < 0, then (p2,p3) is a right turn relative to vector (p1,p2);
-- When D(p1, p2, p3) > 0, then (p2,p3) is a left turn relative to vector (p1,p2);
-- When D(p1, p2, p3) = 0, then p1, p2, p3 are colinear.
local function Determinant(p1, p2, p3)
	return p2[1]*p3[2] + p1[1]*p2[2] + p1[2]*p3[1]
	     - p2[1]*p1[2] - p3[1]*p2[2] - p3[2]*p1[1]
end

local function IsRightTurn(p1, p2, p3)
	return Determinant(p1, p2, p3) < 0
end

local function IsLeftTurn(p1, p2, p3)
	return Determinant(p1, p2, p3) > 0
end

local function SingleStepModulo(x, N)
	if x > 0 then
		if x <= N then
			return x
		elseif x == N+1 then
			return 1
		end
	elseif x == 0 then
		return N
	end
	error("Parameter out of range: " .. x)
end

local function ListToString(L)
	return table.concat(L, " ")
end


-- Input is a polygon M with at least 3 vertices given in order as they are connected
--       and the index in M of the vertex with the lowest x coordinate
-- Output is a table of indexes to M
-- O(n) time, O(n) space
local function SortMonotone(M, lowest_x)
	local sorted_vertices = {lowest_x}

	local walk_i_left =  SingleStepModulo(lowest_x-1, #M)
	local walk_i_right = SingleStepModulo(lowest_x+1, #M)
	local xl, xr
	-- Guaranteed different indices, as we have at least 4 vertices
	while true do
		xl = M[walk_i_left][1]
		xr = M[walk_i_right][1]

		if xl < xr then
			sorted_vertices[#sorted_vertices + 1] = walk_i_left
			walk_i_left = SingleStepModulo(walk_i_left - 1, #M)
		elseif xr < xl then
			sorted_vertices[#sorted_vertices + 1] = walk_i_right
			walk_i_right = SingleStepModulo(walk_i_right + 1, #M)
		else -- Same x coordinate, take left walk (lower)
			if M[walk_i_left][2] < M[walk_i_right][2] then
				sorted_vertices[#sorted_vertices + 1] = walk_i_left
				walk_i_left = SingleStepModulo(walk_i_left - 1, #M)
			else
				sorted_vertices[#sorted_vertices + 1] = walk_i_right
				walk_i_right = SingleStepModulo(walk_i_right + 1, #M)
			end
		end

		vi = sorted_vertices[#sorted_vertices]
		print ("SortMonotone: inserted " .. vi .. ":" .. M[vi][1] .. ", " .. M[vi][2])

		if walk_i_left == walk_i_right then
			break
		end
	end
	-- Leftover
	sorted_vertices[#sorted_vertices+1] = walk_i_left
	return sorted_vertices
end


-- Input is a polygon M with at least 3 vertices given in order as they are connected
--       and the index in M of the vertex with the lowest x coordinate
-- Output is a table giving the indices of the hull the respective vertex belongs to
--       (1 = lower, 2 = upper, 3 = endpoints)
-- O(n) time, O(n) space
local function GetHullIndices(M, lowest_x)
	local whichHull = {}
	whichHull[lowest_x] = 1
	print ("hull vertex " .. lowest_x .. ":" .. whichHull[lowest_x])

	local walk_i_left =  SingleStepModulo(lowest_x-1, #M)
	local walk_i_right = SingleStepModulo(lowest_x+1, #M)
	local xl, xr
	-- Guaranteed different indices, as we have at least 4 vertices
	xl = M[walk_i_left][1]
	xr = M[walk_i_right][1]

	d = Determinant(M[walk_i_left], M[lowest_x], M[walk_i_right])

	-- We know that (in general position), the vertex at lowest_x is convex
	-- therefore we can figure out whether its neighbours are in lower or upper hull
	local rightHull = 1
	if d < 0 then -- right turn, forward walk is on upper hull, backward on lower
		rightHull = 2
	elseif d > 0 then -- left turn, forward walk is on lower hull, backward on upper
		rightHull = 1
	else
		error("Vertices are colinear!")
	end

	-- Walk forward through indices and copy active hull indicator
	local prevPoint = M[lowest_x]
	while true do
		local currPoint = M[walk_i_right]

		if currPoint[1] < prevPoint[1] then
			-- mark point with highest x (there may be many in general)
			whichHull[walk_i_right-1] = 3
			break -- end of hull reached
		end
		whichHull[walk_i_right] = rightHull
		print ("GetHullIndices: fwd " .. walk_i_right .. ":" .. rightHull)

		walk_i_right = SingleStepModulo(walk_i_right + 1, #M)
		prevPoint = currPoint
	end

	-- Walk backward through indices and copy active hull indicator
	if rightHull == 2 then
		rightHull = 1
	else
		rightHull = 2
	end

	prevPoint = M[lowest_x]
	while true do
		local currPoint = M[walk_i_left]

		if currPoint[1] < prevPoint[1] then
			break -- end of hull reached
		end
		whichHull[walk_i_left] = rightHull
		print ("GetHullIndices: bwd " .. walk_i_left .. ":" .. rightHull)

		walk_i_left = SingleStepModulo(walk_i_left - 1, #M)
		prevPoint = currPoint
	end

	for i = 1, #whichHull do
		local hi = whichHull[i]
		print ("hull vertex " .. i .. ":" .. (hi or "nil"))
	end
	return whichHull
end


-- Output of this is not a DCEL as is being done in the book, but a list of
-- 3-vertex pairs for direct use in rendering
local function TriangulateMonotone(M)
	if #M < 4 then -- already a triangle or less
		return {M}
	end
	local triangles = {}

	-- Also we are not processing y-monotone, but x-monotone polygons
	-- First sort M by x coordinate. We keep two lists of indices, one of the
	-- upper and one for the lower hull.
	local upper_hull = {}
	local lower_hull = {}
	-- How do we know which side of lowest_x represents the lower hull?
	local lowest_x = FindFirstPointByX(M)

	sorted_vertices = SortMonotone(M, lowest_x)
	whichHull = GetHullIndices(M, lowest_x)

	stack = {sorted_vertices[1], sorted_vertices[2]}
	for i = 3, #sorted_vertices - 1 do
		-- Nomenclature:
		-- v: vertex being processed, vi: its index in M
		-- t: vertex that was on top of stack, ti: its index in M
		-- q: vertex that was below t on stack, qi: its index in M
		vi = sorted_vertices[i]
		v = M[vi]
		print ("")
		print ("Iteration " .. i .. ", vertex " .. vi .. " :")
		local str = "Stack:"
		for k,v in pairs(stack) do
			str = str .. " " .. v
		end
		print (str)

		ti = stack[#stack]
		-- are v and last of stack on the same path?
		if vi == ti + 1 or vi == ti - 1 then
			print ("Indices " .. vi .. " and " .. ti .. " are on the same path")
			-- A diagonal s(i-1), vi is valid when s(i-1), s(i), vi form a right turn
			-- i.e.   q, v is valid when q, t, v form a right turn

			-- "Pop one vertex from S"
			--stack[#stack] = nil

			qi = stack[#stack-1]
			while #stack > 0 do
				q = M[qi]
				t = M[ti]
				if (whichHull[vi] == 2 and IsRightTurn(q, t, v))
				or (whichHull[vi] == 1 and IsLeftTurn(q, t, v)) then
					-- Lower hull => left turns define legal diagonals
					-- Upper hull => right turns define legal diagonals
					triangle = {qi, ti, vi}
					print ("Triangle: " .. triangle[1] .. ", " .. triangle[2]
				    	   .. ", " .. triangle[3])
					table.insert(triangles, triangle)
				else
					break -- no point looking backward
				end

				ti = qi -- ti has been lost to a triangle, qi is our new top
				stack[#stack]= nil -- remove ti
				qi = stack[#stack] -- next top
			end
			-- "Push uj onto S"
			table.insert(stack, vi)

			--table.insert(stack, ti)
		else -- not on the same path
			for j = 2, #stack do
				triangle = {stack[j-1], stack[j], vi}
				print ("Triangle: " .. triangle[1] .. ", " .. triangle[2]
				       .. ", " .. triangle[3])
			end
			stack = {sorted_vertices[i-1], sorted_vertices[i]}
		end
	end

	-- Last triangle.
	triangle = {stack[1], stack[2], sorted_vertices[#sorted_vertices]}
	print ("Triangle: " .. triangle[1] .. ", " .. triangle[2]
	       .. ", " .. triangle[3])
end


--TriangulateMonotone(M)
local function GetMonotonePolygonHulls(M, leftmost_x)
	local walk_i_left  = SingleStepModulo(leftmost_x-1, #M)
	local walk_i_right = SingleStepModulo(leftmost_x+1, #M)
	local xl, xr
	-- Guaranteed different indices, as we have at least 4 vertices
	xl = M[walk_i_left][1]
	xr = M[walk_i_right][1]

	d = Determinant(M[walk_i_left], M[leftmost_x], M[walk_i_right])


	local fwd_hull = {leftmost_x}
	local bwd_hull = {leftmost_x}
	local highest_x = nil

	-- Walk forward through M
	local prevPoint = M[leftmost_x]
	while true do
		local currPoint = M[walk_i_right]

		if currPoint[1] < prevPoint[1] then
			-- mark point with highest x (there may be many in general,
			-- but this loop takes the one with the lowest y coordinate.
			rightmost_x = SingleStepModulo(walk_i_right-1, #M)
			break -- end of hull reached
		end
		table.insert(fwd_hull, walk_i_right)
		print ("GetMonotonePolygonHulls: fwd " .. walk_i_right)

		walk_i_right = SingleStepModulo(walk_i_right + 1, #M)
		prevPoint = currPoint
	end

	-- Walk backward through M

	prevPoint = M[leftmost_x]
	while walk_i_left ~= rightmost_x do
		local currPoint = M[walk_i_left]

		table.insert(bwd_hull, walk_i_left)
		print ("GetMonotonePolygonHulls: bwd " .. walk_i_left)

		walk_i_left = SingleStepModulo(walk_i_left - 1, #M)
	end
	table.insert(bwd_hull, rightmost_x)

	-- We know that (in general position), the vertex at leftmost_x is convex
	-- therefore we can figure out whether its neighbours are in lower or upper hull
	if d < 0 then -- right turn, forward walk is on upper hull, backward on lower
		return bwd_hull, fwd_hull
	elseif d > 0 then -- left turn, forward walk is on lower hull, backward on upper
		return fwd_hull, bwd_hull
	else
		error("Vertices are colinear!")
	end
end


-- Returns the position of value in M, expressed in
-- terms of indices of list. [left_index, right_index].
-- If value is equal to some element, then the indices returned will be the same.
-- if value is outside, then left_index will be 0 and right_index
-- either positive (to the right) or negative.
local function Bisect(M, list, value)
	local lind = 1
	local rind = #list

	if value > M[list[#list]][1] then
		return 0, 1
	elseif value < M[list[1]][1] then
		return 0, -1
	end

	local mind

	while lind+1 < rind do
		mind = math.floor( (lind+rind) /2)

		if value > M[list[mind]][1] then
			lind = mind
		elseif value < M[list[mind]][1] then
			rind = mind
		else
			return mind, mind
		end
	end

	return lind, rind
end


---------------------------
-- non-monotone polygons --
---------------------------

local function SplitToMonotoneSortHelper(M, lhs, rhs)
	local l = M[lhs][1]
	local r = M[rhs][1]
	if l < r then
		return true
	elseif l == r and M[lhs][2] < M[rhs][2] then
		return true
	else
		return false
	end
end

-- Returns a list of polugons (vertices list) obtained by decomposing M
-- to a union of x - monotone polygons.
local function SplitToMonotonePolygons(M)
	local lowest_x = FindFirstPointByX(M)

	-- Sort vertices of M by x coordinate to prepare for line sweep
	-- We first require to copy M, so the vertex order (and thus our knowledge
	-- of edges) is preserved.
	local vertices = {} -- contains indices into M
	for i = 1, #M do
		vertices[i] = i
	end
	table.sort (vertices, function(l,r) return SplitToMonotoneSortHelper(M, l, r) end)
	print ("Sorted: " .. ListToString(vertices))

	-- Now that we have a list of sorted vertices, we can sweep.
	local T = {} -- State tree


end


--> generates a trianglestrip from a outline
function convertOutlineToTriStrip(outline)
	midPoint={x=0,y=0}
	for i=1,#outline do
		midPoint.x,midPoint.y = midPoint.x + outline[i].x,midPoint.y + outline[i].y
	end
	midPoint.x,midPoint.y= midPoint.x/#outline , midPoint.y/#outline
	
	ltriStrip={}
	for i=1,#outline do
		ltriStrip[3*(i-1)+1] = {x=outline[i].x,y=outline[i].y}
		ltriStrip[3*(i-1)+2]= {x=midPoint.x, y=midPoint.y}
		ltriStrip[3*(i-1)+3]= {x=outline[i+1].x,y=outline[i+1].y}		
	end
	--close the triangle strip
	ltriStrip[#ltriStrip+1] = {x=outline[#outline].x,y=outline[#outline].y}
	ltriStrip[#ltriStrip+1]= {x=midPoint.x, y=midPoint.y}
	ltriStrip[#ltriStrip+1]= {x=outline[1].x,y=outline[1].y}		
end

function HabaneroButton:getTriStripMaxDimensions()
	minx,miny,maxx,maxy = math.huge,math.huge,-math.huge,-math.huge
	
	for i=1,table.getn(self.triStrip) do
		local point= self.triStrip[i]	
		
		minx = math.min(minx,point.x)
		miny = math.min(miny,point.y)
		maxx = math.max(maxx,point.x)
		maxy = math.max(maxy,point.y)
	end
	
	return maxx - minx, maxy - miny
end

function scaleTriStrip(self, factorWidth, factorHeigth)
	for i=1,table.getn(self.triStrip) do
		local point= self.triStrip[i]		
		point.x= point.x*factorWidth
		point.y= point.y * factorHeigth
		self.triStrip[i] = point		
	end
end

function generateEarlyOutBox(self)
	for i=1,table.getn(self.triStrip) do
		local point= self.triStrip[i]		
		self.xMin = math.min(self.xMin ,point.x)
		self.xMax = math.max(self.xMax ,point.x)
		self.yMin = math.min(self.yMin ,point.y)
		self.yMax = math.max(self.yMax ,point.y)
		self.midPointX= self.midPointX + point.x
		self.midPointY= self.midPointY + point.y
	end		
	self.midPointX= self.midPointX/ #self.triStrip
	self.midPointY= self.midPointY/ #self.triStrip
	
	xWidth = math.abs( self.xMax )+ math.abs(self.xMin )
	yHeigth = math.abs(self.yMax )+ math.abs(self.yMin )	
	
	self.defaultWidth = xWidth
	self.defaultHeight =yHeigth
	
end


function HabaneroButton:Init(bRelativePixelSize)
	--Handle outline
	if bRelativePixelSize then boolRelativePixelSize = bRelativePixelSize end
	
	if self.outline then
		self.triStrip = convertOutlineToTriStrip(self.outline)		
	end
	
	self.xMin ,self.xMax =0,1
	self.yMin ,self.yMax =0,1	
	
	totalPixelsX,totalPixelsY, rows, columns = getParentTotalSizePixel(self) 
	
	if boolRelativePixelSize == true then	
		
		buttonTotalX, buttonTotalY = self:getTriStripMaxDimensions(self.triStrip)
		--Calculate the factors to scale the pixelvalues of the habanero
		buttonFactorX, buttonFactorY = ((totalPixelsX/columns)/buttonTotalX), ((totalPixelsY/rows)/buttonTotalY)
		scaleTriStrip(self, buttonFactorX, buttonFactorY)
		
		buttonTotalX, buttonTotalY = self:getTriStripMaxDimensions(self.triStrip)
		
	end
	
	if  self.boolBorder and self.boolBorder == true then
	
		self.borderline = Borderline:New{
							borderType = self.borderType,
							button = self,
							borderColor = self.borderColor
						}
						
					
		self.borderline:Init()
	end
	
	--computate the early out box
	generateEarlyOutBox(self)
	self:SetSelectable(false)
	self:setCurrentColorByState()
end
--//=============================================================================
--//=============================================================================
function CrossProduct(v1, v2)
	return {x=v1.x*v2.x, y= v1.y *v2.y}
end

function DotProduct(v1,v2)
	return v1.x*v2.x + v1.y *v2.y
end

function SameSide(pPoint,pPointA, pPointB, pPointC)
	bMinusA={}	
	bMinusA.x=pPointC.x-pPointB.x
	bMinusA.y=pPointC.y-pPointB.y
	
	p1MinusA={}
	p1MinusA.x=pPoint.x-pPointB.x
	p1MinusA.y=pPoint.y-pPointB.y
	p2MinusA={}	
	p2MinusA.x=pPointA.x-pPointB.x
	p2MinusA.y=pPointA.y-pPointB.y
	
	cp1 = CrossProduct(bMinusA, p1MinusA)
	cp2 = CrossProduct(bMinusA, p2MinusA)
	if DotProduct(cp1, cp2) >= 0 then 
		return true
	else 
		return false 
	end
end
-->Rather unelegant tests for every triangle wether the point is inside
function PointInTriangle(pPoint, pPointA,pPointB,pPointC)
	
	if 	SameSide(pPoint,pPointA, pPointB,pPointC) ==true and
	SameSide(pPoint,pPointB, pPointA,pPointC) ==true and
	SameSide(pPoint,pPointC, pPointA,pPointB) ==true 
	then 
		return true
	else 
		return false
	end
end


-->Rather unelegant tests for every triangle wether the point is inside for all points
function HabaneroButton:BruteForceTriStripTest(x,y)
	
	point= {x=x, y= y}
	
	for i=3, #self.triStrip, 1 do
		
		if PointInTriangle(	point,
		self.triStrip[i],
		self.triStrip[i-1],
		self.triStrip[i-2] ) == true then 
			
			return self 
		end
	end 
	
	return false
end


--//==============Eventhandling for Button=======================================


function HabaneroButton:HitTest(x,y)	
	return self:BruteForceTriStripTest(x,y)	
end

function HabaneroButton:MouseDown(...)
	self.state.pressed = true
	inherited.MouseDown(self, ...)
	self:Invalidate()
	return self
end

function HabaneroButton:MouseOver(...)	
	
	self.boolInFocus = true
	self:setCurrentColorByState()
	self:Invalidate()
end

function HabaneroButton:MouseOut(...)
	self.boolInFocus = false
	self:setCurrentColorByState()
	self:Invalidate()
end

function HabaneroButton:MouseUp(...)
	if (self.state.pressed) then
		self.state.pressed = false
		inherited.MouseUp(self, ...)
		self:Invalidate()	
		return self
	end
end

--//=============================================================================

