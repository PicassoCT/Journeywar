--[[   
   vectorial3.lua ver 0.2 - A library for 3D vectors.
   Copyright (C) 2015 Leo Tindall
   ---
    All operators work as expected except modulo (%) which is vector distance and concat (..) which is linear distance.
   ---
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
]]
Vector = {}
Vector.__index = Vector

   function Vector.new (ix, iy, iz) 
	   if ix and type(ix)== "number" then
			return setmetatable({x = ix , 
								 y = iy ,
								 z = iz }, Vector)
		end

		return setmetatable({x =  0, 
							 y =  0,
							 z =  0}, Vector)
	end
	

	--Comparisons

	function Vector.__eq (lhs, rhs)
		--Equal To operator for Vector3Ds
		return (self.x == rhs.x) and (self.y == rhs.y) and (self.z == rhs.z)
	end
	
	function Vector.__lt (lhs, rhs)
		--Less Than operator for Vector3Ds
		return sqrt((self.x^2) + (self.y^2) + (self.z^2)) < sqrt((rhs.x^2) + (rhs.y^2) + (self.z^2)) --We do this to compute the linear value of the vector so that, for example, (a % b) < (c % d) will not be broken.
	end
	
	function Vector.__le (lhs, rhs)
		--Less Than Or Equal To operator for Vector3Ds
		return sqrt((self.x^2) + (self.y^2) + (self.z^2)) <= sqrt((rhs.x^2) + (rhs.y^2) + (self.z^2)) --We do this to compute the linear value of the vector so that, for example, (a % b) < (c % d) will not be broken.
	end
	
	--Operations

	
	function Vector.__unm (rhs)
		--Unary Minus (negation) operator for Vector3Ds
		out = Vector:new()
		out.x =(-rhs.x) --Operate on the X property
		out.y =(-rhs.y) --Operate on the Y property
		out.y =(-rhs.z) --Operate on the Z property
		return Vector:new(-rhs.x,
							 -rhs.y,
							 -rhs.z
							)
	end
	
	function Vector.__add (lhs, rhs)
		--assert(rhs)
		--assert(lhs)
		--Addition operator for Vector3Ds
		out = Vector:new()--Copy the operand for the output (else the output won't have metamethods)
		if type(rhs)=="number" then
		out.x =(lhs.x + rhs) --Operate on the X property
		out.y =(lhs.y + rhs) --Operate on the Y property
		out.z =(lhs.z + rhs) --Operate on the Z property
	else
		out.x =(lhs.x + rhs.x) --Operate on the X property
		out.y =(lhs.y + rhs.y) --Operate on the Y property
		out.z =(lhs.z + rhs.z) --Operate on the Z property
	end
	
	return out
	end

	function Vector.__sub (lhs, rhs)
		--assert(rhs)
		--assert(lhs)
		--Subtraction operator for Vector3Ds
		out = Vector:new()
		if type(rhs)=="number" then		
			out.x =(lhs.x - rhs) --Operate on the X property
			out.y =(lhs.y - rhs) --Operate on the Y property
			out.z =(lhs.z - rhs) --Operate on the Z property
		else
			out.x =(lhs.x - rhs.x) --Operate on the X property
			out.y =(lhs.y - rhs.y) --Operate on the Y property
			out.z =(lhs.z - rhs.z) --Operate on the Z property
		end
			return out
	end

	function Vector.__mul (lhs, rhs)
		----assert(rhs)
		----assert(lhs)
	
		if type(lhs)=="number" then

			return Vector:new(rhs.x * lhs,
							  rhs.y * lhs,
							  rhs.z * lhs
							 )
		end
	
		if type(rhs)=="number" then

			return Vector:new(lhs.x * rhs,
							  lhs.y * rhs,
							  lhs.z * rhs
							 )
		end
		
			--Multiplication operator for Vector3Ds
				return Vector:new(lhs.x * rhs.x,
								  lhs.y * rhs.y,
								  lhs.z * rhs.z)
		
		
	end

	function Vector.__div (lhs, rhs)
		out = Vector:new()

	if type(rhs)=="number" then
		--Division operator for Vector3Ds
		out.x =(lhs.x / rhs) --Operate on the X property
		out.y =(lhs.y / rhs) --Operate on the Y property
		out.z =(lhs.z / rhs) --Operate on the Z property
	else
		--Division operator for Vector3Ds
		out.x =(lhs.x / rhs.x) --Operate on the X property
		out.y =(lhs.y / rhs.y) --Operate on the Y property
		out.z =(lhs.z / rhs.z) --Operate on the Z property
	end
		return out
	end
	
	function Vector.__mod (lhs, rhs)
		--Vector distance operator for Vector3Ds. Denoted by modulo (%)
		out = Vector:new()
		out.x =(math.abs(rhs.x - lhs.x)) --Operate on the X property
		out.y =(math.abs(rhs.y - lhs.y)) --Operate on the Y property
		out.z =(math.abs(rhs.z - lhs.z)) --Operate on the Z property
		return out	
	end

	function Vector.__concat (lhs, rhs)
		--Linear distance operator for Vector3Ds. Denoted by concat (..)
		out = 0		--This is a linear operation, so no deepcopy. 
		out = math.sqrt(((rhs.x - lhs.x)^2) + (((rhs.y - lhs.y)^2) + ((rhs.z - lhs.z)^2))) --Distance formula
		return out
	end

	function Vector.__tostring (s)
		--tostring handler for Vector3D
		out = ""	--This is a string operation, so no deepcopy.
		out = "[(X:"
		out = out .. s.x 
		out = out .. "),(Y:" 
		out = out .. s.y 
		out = out .. "),(Z:" 
		out = out .. s.z 
		out = out .. ")]"
		return out
	end

	--Vector Specific Math

	function Vector:getAngle() --Return the 3D angle (heading, carom) of the vector IN RADIANS!.
		hdg = math.atan2(self.y, self.x)
		crm = math.atan2(self.z, 0)
		return hdg, crm
	end
	
	function Vector:length() --Return the length of the vector (i.e. the distance from (0,0), see README.md for examples of using this)
		return math.sqrt (self.x *self.x +self.y*self.y + self.z*self.z)
	end
	
	function Vector:cross ( rhs)
		--Vector cross product 
		out = Vector:new()
		out.x =(self.y*rhs.z - self.z*rhs.y) --Operate on the X property
		out.y =(self.z*rhs.y - self.x*rhs.z) --Operate on the Y property
		out.z =(self.x*rhs.y - self.y*rhs.x) --Operate on the Z property
		return out	
	end
	
	function Vector:normalized()
		return self/ self.length()
	end
	
	
setmetatable(Vector, { __call = function(_, ...) return Vector.new(...) end })	

AngleAxis={}
AngleAxis.__index = AngleAxis

   function AngleAxis.new (Angle, Axis) 

			return setmetatable({angle = Angle , 
								 axis = Axis }, AngleAxis)
		
	end
	
setmetatable(AngleAxis, { __call = function(_, ...) return AngleAxis.new(...) end })	
