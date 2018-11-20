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
	
	numberOfStates= 0,
	currentState = 0,

	
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

--//=============================================================================
function Rotate(x, z, Rad)
	if not Rad then return end
	sinus = math.sin(Rad)
	cosinus = math.cos(Rad)
	
	return x * cosinus + z * -sinus, x * sinus + z * cosinus
end


function HabaneroButton:Spiral(startPointA, startPointB, CenterPoint, Degree, reduceFactor, Resolution)
	local strip = {}
	totalReducePerStep= (1-reduceFactor)/Resolution
	degPerRes =Degree/Resolution
	
	for i=1,Resolution do
		--make a copy and 	--scale the new points
		local copyPointA,copyPointB = startPointA, startPointB
		copyPointA.x,copyPointA.y=(1-totalReducePerStep)* (copyPointA.x-CenterPoint.x),(1-totalReducePerStep)* (copyPointA.y-CenterPoint.y)
		copyPointB.x,copyPointB.y=(1-totalReducePerStep)* (copyPointB.x-CenterPoint.x),(1-totalReducePerStep)* (copyPointB.y-CenterPoint.y)
		-- rotate the Points 
		copyPointA.x,copyPointA.y= Rotate(copyPointA.x,copyPointA.y,math.rad(degPerRes))
		copyPointB.x,copyPointB.y= Rotate(copyPointB.x,copyPointB.y,math.rad(degPerRes))
		-- move back into position
		copyPointA.x,copyPointA.y=copyPointA.x +CenterPoint.x,copyPointA.y +CenterPoint.y
		---draw two triangles into the strip
		strip[#strip+1] = {x=startPointA.x ,y=startPointA.y}
		strip[#strip+1] = {x=startPointB.x ,y=startPointB.y}
		strip[#strip+1] = {x=copyPointA.x ,y=copyPointA.y}
		strip[#strip+1] = {x=copyPointA.x ,y=copyPointA.y}
	end
end
--//=============================================================================

function HabaneroButton:DrawControl()
	--// gets overriden by the skin/theme
end

--//=============================================================================
function getZeroScreen(self)
while self.parent do
self = self.parent
end
return self
end

--> gets the parents of the handed objects absolut size in pixel
function getParentSize(self)
	--debugging
	zeroScreen = getZeroScreen(self)

	--no parent
	if not self.parent then error("No parent existing for HabaneroButton "..self.caption) end
	
	--self is root
	if self == zeroScreen then
		return zeroScreen.width, zeroScreen.height	
	end
	if self.width and self.height then
		Spring.Echo("HabaneroButton:Selfsize"..self.name..":"..self.width.." / "..self.height	)
		typeX,typeY=type(self.width),type(self.height)
		
		--self width exists as pixel value
		if typeX == "number" and typeY == "number" then 
			return self.width, self.height 
		end
		
		--self width exists as percentage value
		if typeX == "string" and typeY == "string" then 
			dx,dy= getParentSize(self.parent)
			fx,fy= stringPercentToScale(self.width), stringPercentToScale(self.heigth)
			
			return dx*fx, dy*fy
		end
	end	
end

--> converts a string percentage value into a number
function stringPercentToScale(percent)
	return	math.min(100.0,math.max(0.0,tonumber(string.gsub(string.gsub(percent,"%%","")," ",""),10)))/100
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

function getParentPercentage(self, dimX, dimZ)
	return dimX/#self.parent.children, dimZ/#self.parent.children
end

function HabaneroButton:Init()
	--Handle outline

	if self.outline then
		self.triStrip = convertOutlineToTriStrip(self.outline)		
	end
	
	boolAbsoluteSize = (self.triStrip[1] and type(self.triStrip[1].x)== "number")
	
	self.xMin ,self.xMax =0,1
	self.yMin ,self.yMax =0,1	
	
	totalPixelsX,totalPixelsY= getParentSize(self.parent) 
	
	if boolAbsoluteSize == false then	
	Spring.Echo("HabaneroButton:AbsoluteSize:"..totalPixelsX.." / "..totalPixelsY)
		
		totalPixelsX,totalPixelsY=	getParentPercentage(self, totalPixelsX,totalPixelsY)
	Spring.Echo("HabaneroButton:Buttonsize:"..totalPixelsX.." / "..totalPixelsY)
	
		for i=1,table.getn(self.triStrip) do
			local point= self.triStrip[i]		
			point.x=stringPercentToScale(point.x)
			point.y=stringPercentToScale(point.y)
			-- limit	
			
			point.x = point.x *totalPixelsX
			point.y = point.y *totalPixelsY	
			self.triStrip[i] = point		
		end
	end
	
	--computate the early out box
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

function HabaneroButton:MouseOver(...)

	self.boolInFocus = true
end

function HabaneroButton:MouseOut(...)
	self.boolInFocus = false
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