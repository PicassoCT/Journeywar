include "lib_type.lua"
--[[   
	Mass
]]
Mass = {}
Mass.__index = Mass

function Mass:new(mass)
	metaTable = {
		pos = Vector:new(0,0,0),
		vel = Vector:new(0,0,0),
		force = Vector:new(0,0,0),
		m= mass
        }
		
	return setmetatable(metaTable, Mass)
end

function Mass:applyForce(applyForce)
	force = force + applyForce
end

function Mass:init()
	force = Vector:new(0,0,0)
end

function Mass:simulate(dt)
	vel= vel + (force/m)*dt
	pos = pos + vel*dt 
end

--[[   	Simulation	]]
Simulation = {}
Simulation.__index = Simulation

function Simulation:new(numOfMasses, massWeightT)
	assert(massWeightT)
	assert(numOfMasses)
	metaTable = {
			masses = {}          
        }
		
		for i=1, numOfMasses do
			metaTable.masses[i] = Mass:new(massWeightT[i])
		end

	return setmetatable(metaTable, Simulation)
end

function Simulation:init()
	for i=1, numOfMasses do
		metaTable.masses[i].init()
	end
end

function Simulation:simulate(dt)
	for i=1, numOfMasses do
		metaTable.masses[i].simulate(dt)
	end
end

function Simulation:operate(dt)
	init()
	solve()
	simulate(dt)
end

setmetatable(Simulation, { __call = function(_, ...) return Simulation.new(...) end })

--[[   	ApplyForce	]]
ApplyForce = {}
ApplyForce.__index = ApplyForce

function ApplyForce.new(springConstant, vecConnectionPos)
	metaTable = {
            springConstant = springConstant,
			connectionPos = vecConnectionPos,
			masses[0].pos = connectionPos + Vector:new(10.0,0.0,0.0),
			masses[0].vel =  Vector:new(0.0, 0.0, 0.0)
        }
		
	metaTable = inherit(metaTable, Simulation: new(1, 1.0))

	return setmetatable(metaTable, ApplyForce)
end

function ApplyForce:spring()
    for i = 1, numOfMasses do
		springVector = masses[i].pos - connectionPos;			--find a vector from the position of the mass to the connectionPos
		masses[i].applyForce(-springVector * springConstant);	
	end
end


function ApplyForce:solve(forceList)
	for f=1,#forceList do
		for i=1, numOfMasses do
			springVector = masses[i].pos - connectionPos;			--find a vector from the position of the mass to the connectionPos
			masses[i].applyForce(forceList[i] * masses[i].m)
		end
	end
end

setmetatable(ApplyForce, { __call = function(_, ...) return ApplyForce.new(...) end })

--[[   	Mass Connected with Spring	]]
SpringSystem = {}
SpringSystem.__index = SpringSystem

--> Create a new mass
function SpringSystem:new(Mass1, Mass2, springConstant, springLength, frictionConstant)
		return setmetatable({
			mass1 = Mass1, 
			mass2 = Mass2,
			springConstant = springConstant,
			springLength = springLength, 
			frictionConstant = 	frictionConstant		
		}, SpringSystem)
end

function SpringSystem:solve()
	springVector=  mass1.pos - mass2.pos
	r = springVector.length()
	force = Vector:new()
	
	if (r ~= 0) then
		force = force + (springVector / r) * (r - springLength) * (-springConstant)
	end
	
	force = force -(mass1.vel - mass2,vel) * frictionConstant;	
	mass1.applyForce(force)
	mass2.applyForce(-force)		
end

--[[  	Ropesimulation]]
RopeSimulation = {}
RopeSimulation.__index = RopeSimulation

function RopeSimulation:new(
		numOfMasses,								--1. the number of masses
		massWeightT,										--2. weight of each mass
		springConstant,							--3. how stiff the springs are
		lengthOfElementT,								--4. the length that a spring does not exert any force
		springFrictionConstant,					--5. inner friction constant of spring
		gravitation,							--6. gravitational acceleration
		airFrictionConstant,						--7. air friction constant
		groundRepulsionConstant,					--8. ground repulsion constant
		groundFrictionConstant,					--9. ground friction constant
		groundAbsorptionConstant,					--10. ground absorption constant
		groundHeight)
		
	metaTable = {
           gravitation = gravitation,
		   airFrictionConstant = airFrictionConstant,
		   groundFrictionConstant = groundFrictionConstant,
		   groundRepulsionConstant = groundRepulsionConstant,
		   groundAbsorptionConstant = groundAbsorptionConstant,
		   groundHeight = groundHeight
		   masses={}
		   springs={}
        }
		metaTable = inherit(metaTable, Simulation: new(numOfMasses, massWeightT))
		
		for i=1, numOfMasses do 
			metaTable.masses[i].pos = Vector:new(lengthOfElementT[i], 0, 0)
			if i < numOfMasses then
				metaTable.springs[i] = SpringSystem:new(metaTable.masses[i],
				metaTable.masses[i+1],
				springConstant,
				lengthOfElementT[i],
				springFrictionConstant)
			end
		end	
return setmetatable(metaTable, RopeSimulation)		
end

function RopeSimulation:solve()
	for i=1, #springs do
		springs[i].solve()
	end

	for a=1, numOfMasses do

			masses[a].applyForce(gravitation * masses[a].m);				--The gravitational force
			
			masses[a].applyForce((-1*masses[a].vel) * airFrictionConstant);	--The air friction

			if (masses[a].pos.y < groundHeight)	then	--Forces from the ground are applied if a mass collides with the ground
			
				 v = Vector:new(0,0,0)							--A temporary Vector3D

				v = masses[a].vel;						--get the velocity
				v.y = 0;								--omit the velocity component in y direction

				--The velocity in y direction is omited because we will apply a friction force to create 
				--a sliding effect. Sliding is parallel to the ground. Velocity in y direction will be used
				--in the absorption effect.
				masses[a].applyForce(-v * groundFrictionConstant);		--ground friction force is applied

				v = masses[a].vel;						--get the velocity
				v.x = 0;								--omit the x and z components of the velocity
				v.z = 0;								--we will use v in the absorption effect
				
				--above, we obtained a velocity which is vertical to the ground and it will be used in 
				--the absorption force

				if (v.y < 0)	then						--let's absorb energy only when a mass collides towards the ground
					masses[a].applyForce(-1*v * groundAbsorptionConstant);		--the absorption force is applied
				
				--The ground shall repel a mass like a spring. 
				--By "Vector3D(0, groundRepulsionConstant, 0)" we create a vector in the plane normal direction 
				--with a magnitude of groundRepulsionConstant.
				--By (groundHeight - masses[a]->pos.y) we repel a mass as much as it crashes into the ground.
				 force = Vector:new(0, groundRepulsionConstant, 0) * (groundHeight - masses[a].pos.y);

				masses[a].applyForce(force);			--The ground repulsion force is applied
				end
			end	
		end	
		
	
end

function RopeSimulation:Simulate(dt)
	simulate(dt)
	
	ropeConnectionPos = ropeConnectionPos + ropeConnectionVel * dt
	
	if (ropeConnectionPos.y < groundHeight) then
			ropeConnectionPos.y = groundHeight;
			ropeConnectionVel.y = 0;
	end

	masses[0].pos = ropeConnectionPos
	
	masses[0].vel = ropeConnectionVel;	
end

