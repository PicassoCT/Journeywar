Borderline = Object:Inherit{
	classname= "Borderline",
	borderType = "static",
	borderColor = {0,1,0,0.5},
	borderDistance = 1,
	borderDiameter = 7 ,
	button = "nil",
	--Points in Order, Clockwise in local Coordinates - last coordinate is a Copy of the first
	--triStrip should not be self-intersecting or incomplete
	triStrip ={},
}

local this = Borderline
local inherited = this.inherited

function distance(x, y, z, xa, ya, za)
	if type(x)== "table" then
		return distance(x.x, x.y, x.z, y.x, y.y, y.z)
	end
	
	if xa ~= nil and ya ~= nil and za ~= nil then
		return math.sqrt((x - xa) ^ 2 + (y - ya) ^ 2 + (z - za) ^ 2)
	elseif x ~= nil and y ~= nil and z ~= nil then
		return math.sqrt(x * x + y * y + z * z)
	else
		return math.sqrt((x - y) ^ 2)
	end
end

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



function addScaledPointPair(prevPoint, copyPoint, nextPoint, borderdistance, diameter, fixPoint)
	local PointT = copyPoint
	if PointT.x  == 0 then PointT.x = 1 end
	if PointT.z  == 0 then PointT.z = 1 end

	orgdist =math.sqrt(PointT.x^2+ PointT.y^2) 
	
	
	factorBorder = distance/orgdist + 1
	factorBorder_Diameter = factorBorder + diameter/orgdist
	return {x=PointT.x * factorBorder, y=PointT.y * factorBorder}, 
			{ x=PointT.x * factorBorder_Diameter, y= PointT.y * factorBorder_Diameter };
end

function convexhull(points)
    local p = #points

    local cross = function(p, q, r)
        return (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
    end

    table.sort(points, function(a, b)
        return a.x == b.x and a.y > b.y or a.x > b.x
    end)

    local lower = {}
    for i = 1, p do
        while (#lower >= 2 and cross(lower[#lower - 1], lower[#lower], points[i]) <= 0) do
            table.remove(lower, #lower)
        end

        table.insert(lower, points[i])
    end

    local upper = {}
    for i = p, 1, -1 do
        while (#upper >= 2 and cross(upper[#upper - 1], upper[#upper], points[i]) <= 0) do
            table.remove(upper, #upper)
        end

        table.insert(upper, points[i])
    end

    table.remove(upper, #upper)
    table.remove(lower, #lower)
    for _, point in ipairs(lower) do
        table.insert(upper, point)
    end

    return upper
end


function Borderline:generateStaticBorder()
	Spring.Echo("Initialization Borderline 2")
	assert(self.button ~= "nil")
	local orgTriStripCopy = self.button.triStrip
	local triStripCopy = convexhull(orgTriStripCopy)
	

	
	for i=1,#triStripCopy do
	Spring.Echo("Initialization Borderline 3")
		index= #self.triStrip
		self.triStrip[index+1],self.triStrip[index+2]= addScaledPointPair(triStripCopy[i], self.borderDistance, self.borderDiameter)
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

