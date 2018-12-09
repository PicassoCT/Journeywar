Borderline = Object:Inherit{
	classname= "Borderline",
	borderType = "static",
	borderColor = {0,1,0,0.5},
	borderDistance = 0,
	borderDiameter = 5,
	button = "nil",
	--Points in Order, Clockwise in local Coordinates - last coordinate is a Copy of the first
	--triStrip should not be self-intersecting or incomplete
	triStrip ={},
}

local this = Borderline
local inherited = this.inherited




function Borderline:DrawSpiral(startPointA, startPointB, CenterPoint, Degree, reduceFactor, Resolution)
	local strip = {}
	totalReducePerStep= (1-reduceFactor)/Resolution
	degPerRes = Degree/Resolution
	
	Rotate = function (x, z, Rad)
				if not Rad then return end
				sinus = math.sin(Rad)
				cosinus = math.cos(Rad)
				
				return x * cosinus + z * -sinus, x * sinus + z * cosinus
			end
	
	
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
	return strip
end

function addScaledPointPair(PointT, distance, diameter)
	orgdist =math.sqrt(PointT.x^2+ PointT.y^2) 
	factorBorder = distance/orgdist +1
	factorBorder_Diameter = factorBorder + diameter/orgdist
	return {x=PointT.x * factorBorder, y=PointT.y * factorBorder}, { x=PointT.x * factorBorder_Diameter, y= PointT.y * factorBorder_Diameter };
end

function Borderline:generateStaticBorder()
Spring.Echo("Initialization Borderline 2")
	assert(self.button ~= "nil")
	for i=1,#self.button.triStrip do
	Spring.Echo("Initialization Borderline 3")
		index= #self.triStrip
		self.triStrip[index+1],self.triStrip[index+2]= addScaledPointPair(self.button.triStrip[i], self.borderDistance, self.borderDiameter)
	end
	self.triStrip[#self.triStrip+1] = self.triStrip[1]
	self.triStrip[#self.triStrip+1] = self.triStrip[2] 
	
	Spring.Echo("Initialization Borderline 4")
end

function Borderline:generateOrganicBorder()

	
	-- slightly transparent white tree


		-- get Points on Borderline
	-- get CenterPoint
	-- Add Edge Point
		-- Add Circle point After 1/math.random( of the border line)
		-- generate TriStrip
		-- Ad Outside Line in 1 2 3 5 7 5 3 2 1 Pattern
		
		-- thread
		-- On Mouse Closeness, cause Bloom - leaves, flowers, bulbs
		-- slowly wither on distance, back to basic form - or small spiral


end

function Borderline:Init()	
	if self.borderType == "static" then
		Spring.Echo("Initialization Borderline 1")
		 self:generateStaticBorder()
	else
		self:generateOrganicBorder()
	end
end

function Borderline:Update(frame)

end


function Borderline:HitTest(x,y)	
	return self:BruteForceTriStripTest(x,y)	
end

