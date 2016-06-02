--//=============================================================================

--- BeanButton module

--- BeanButton fields.
-- Inherits from Control.
-- @see control.Control
-- @table BeanButton
-- @string[opt="beanbutton"] caption caption to be displayed
BeanButton = Control:Inherit{
	classname= "beanbutton",
	caption = 'beanbutton', 
	--local Coordinates
	defaultWidth = 70,
	defaultHeight = 20,
	xCenter=0,
	yCenter=0,
	--Points in Order, Clockwise in local Coordinates - last coordinate is a Copy of the first
	--nGone should not be self-intersecting or incomplete
	nGone ={},
	triangleStrip =false
}

local this = BeanButton
local inherited = this.inherited

--//=============================================================================

--- Sets the caption of the beanbutton
-- @string caption new caption of the beanbutton
function BeanButton:SetCaption(caption)
	if (self.caption == caption) then return end
	self.caption = caption
	self:Invalidate()
end

--//=============================================================================

function BeanButton:DrawControl()
	--// gets overriden by the skin/theme
end

--//=============================================================================
function BeanButton:Init(btriangleStrip)
	xMin,xMax=0,0
	yMin,yMax=0,0
	
	this.triangleStrip = btriangleStrip or false
	
	--computate the preBox
	for i=1,table.getn(this.nGone) do
		local point= nGone[i]		
		if point.x < xMin then xMin= point.x end
		if point.x > xMax then xMax= point.x end
		if point.y < yMin then yMin= point.y end
		if point.y > yMax then yMax= point.y end
	end
	
	xMinRes= xMin+ math.abs(xMax)+ math.abs(xMin)
	xMaxRes= xMax+ math.abs(xMax)+ math.abs(xMin)
	xWidth = xMaxRes - xMinRes
	
	yMinRes= yMin+ math.abs(yMax)+ math.abs(yMin)
	yMaxRes= yMax+ math.abs(yMax)+ math.abs(yMin)
	yHeigth = yMaxRes - yMinRes
	
	

	defaultWidth = xWidth
	defaultHeight =yHeigth
	
	this.xCenter=xWidth/2
	this.yCenter=yHeigth/2
end
--//=============================================================================
--//=============================================================================
function CrossProduct(v1, v2)
	return {x=v1.x*v2.x, y= v1.y *v2.y}
end

function DotProduct(v1,v2)
	return v1.x*v2.x + v1.y *v2.y
end

function SameSide(p1,p2, a,b)
	bMinusA=b;		bMinusA.x=bMinusA.x-a.x;bMinusA.y=bMinusA.y-a.y;
	p1MinusA=p1;	p1MinusA.x=p1MinusA.x-a.x;p1MinusA.y=p1MinusA.y-a.y
	p2MinusA=p2;	p2MinusA.x=p2MinusA.x-a.x;p2MinusA.y=p2MinusA.y-a.y
	
	cp1 = CrossProduct(bMinusA, p1MinusA)
	cp2 = CrossProduct(bMinusA, p2MinusA)
	if DotProduct(cp1, cp2) >= 0 then 
		return true
	else 
		return false 
	end
end

function PointInTriangle(p, a,b,c)
	if SameSide(p,a, b,c) ==true and SameSide(p,b, a,c) ==true and SameSide(p,c, a,b) ==true 
	then 
		return true
	else 
		return false
	end
end

function BeanButton:BruteForceTriStripTest(x,y)
	
	point= {x=x, y= y}
	
	for i=3, #nGone, 1 do
		if PointInTriangle(point,nGone[i],nGone[i-1],nGone[i-2] ) == true then return self end
	end 
	return false
end


--//=============================================================================



function BeanButton:DeterminantCheck(x,y)
	

	local j= #self.nGone-1
	boolOddNodes=false
	
	
	for i=1, #self.nGone, 1 do
		local inGone_Y=self.nGone[i].y
		local jnGone_Y=self.nGone[j].y
		local inGone_X=self.nGone[i].x
		
		if (inGone_Y <y and jnGone_Y >=y or
		jnGone_Y <y and inGone_Y >=y) then
			
			if inGone_X+(y-inGone_Y)/(jnGone_Y - inGone_Y)*(self.nGone[j].x-inGone_X)<x then
				boolOddNodes = not boolOddNodes
			end
		end
		
		j=i
	end
	
	if boolOddNodes == true then
	Spring.Echo("BeanButton:DeterminantCheck:true")
		return self
	else 
	Spring.Echo("BeanButton:DeterminantCheck:false")
		return false
	end
	

	
end



--//=============================================================================


function BeanButton:HitTest(x,y)

	--x,y = self:LocalToClient(x,y)
	Spring.Echo("Point"..x.." < "..(self.defaultWidth) .." / "..y.." -> ".." < "..( self.defaultHeight)) 

	--rough test is this in shape
	localQuadUpLeft_X,localQuadUpLeft_Y = 0, 0
	localQuadDowRight_X,localQuadDowRight_Y =  self.defaultWidth, self.defaultHeight
	
	--check if we are in the aufgespanntem quad
	if x >= localQuadUpLeft_X and x <= localQuadDowRight_X and
	y >= localQuadUpLeft_Y and y <= localQuadDowRight_Y then
	
			return self:BruteForceTriStripTest(x,y)

	else
		return false
	end
end

function BeanButton:MouseDown(...)
	self.state.pressed = true
	inherited.MouseDown(self, ...)
	self:Invalidate()
	return self
end

function BeanButton:MouseUp(...)
	if (self.state.pressed) then
		self.state.pressed = false
		inherited.MouseUp(self, ...)
		self:Invalidate()
		return self
	end
end

--//=============================================================================