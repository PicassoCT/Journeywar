--//=============================================================================

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
	defaultHeight = 20,
	xMin= 0,
	xMax = 1,
	yMin = 0,
	yMax = 1,
	
	--Points in Order, Clockwise in local Coordinates - last coordinate is a Copy of the first
	--triStrip should not be self-intersecting or incomplete
	triStrip ={},	
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

--//=============================================================================

function HabaneroButton:DrawControl()
	--// gets overriden by the skin/theme
end

--//=============================================================================
function HabaneroButton:Init()
	xMinLoc,xMaxLoc=0,0
	yMinLoc,yMaxLoc=0,0
	
	
	
	--computate the preBox
	for i=1,table.getn(this.triStrip) do
		point= triStrip[i]		
		if point.x < xMinLoc then xMinLoc= point.x end
		if point.x > xMaxLoc then xMaxLoc= point.x end
		if point.y < yMinLoc then yMinLoc= point.y end
		if point.y > yMaxLoc then yMaxLoc= point.y end
	end	
	
	xWidth = math.abs(xMaxLoc)+ math.abs(xMinLoc)
	yHeigth = math.abs(yMaxLoc)+ math.abs(yMinLoc)	
	
	xMax=xMaxLoc
	xMin =xMinLoc
	yMax=yMaxLoc
	yMin =yMinLoc
	
	defaultWidth = xWidth
	defaultHeight =yHeigth
	
	
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


--//=============================================================================


function HabaneroButton:HitTest(x,y)
	
	return self:BruteForceTriStripTest(x,y)
	
end

function HabaneroButton:MouseDown(...)
	self.state.pressed = true
	inherited.MouseDown(self, ...)
	self:Invalidate()
	return self
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