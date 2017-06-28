--[[   
	Mass
]]
Mass = {}
Mass.__index = Mass

function Mass:new(mass)
	metaTable = {
		pos = vector:new(0,0,0),
		vel = vector:new(0,0,0),
		force = vector:new(0,0,0)
		m= mass
        }
		
	return setmetatable(metaTable, Mass)
end

function Mass:applyForce(applyForce)
	force = force + applyForce
end

function Mass:init()
	force = vector:new(0,0,0)
end

function Mass:simulate(dt)
	vel+= (force/m)*dt
	pos += vel*dt 
end

--[[   	Simulation	]]
Simulation = {}
Simulation.__index = Simulation

function Simulation:new(numOfMasses, massWeightT)
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

--[[   	Forceapplication	]]
MassSpring = {}
MassSpring.__index = MassSpring

function ForceApplication.new(springConstant, vecConnectionPos)
	metaTable = {
            springConstant = springConstant,
			connectionPos = vecConnectionPos,
			masses[0].pos = connectionPos + vector:new(10.0,0.0,0.0),
			masses[0].vel =  vector:new(0.0, 0.0, 0.0)
        }
		
	metaTable = inherit(metaTable, Simulation: new(1, 1.0))

	return setmetatable(metaTable, ForceApplication)
end

function ForceApplication:spring()
    for i = 1, numOfMasses do
		springVector = masses[i].pos - connectionPos;			--find a vector from the position of the mass to the connectionPos
		masses[i].applyForce(-springVector * springConstant);	
	end
end


function ForceApplication:solve(forceList)
	for f=1,#forceList do
		for i=1, numOfMasses do
			springVector = masses[i].pos - connectionPos;			--find a vector from the position of the mass to the connectionPos
			masses[i].applyForce(forceList[i] * masses[i].m)
		end
	end
end

setmetatable(ForceApplication, { __call = function(_, ...) return ForceApplication.new(...) end })

--[[   	Mass Connected with Spring	]]
SpringSystem = {}
SpringSystem.__index = SpringSystem

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
	force = vector:new()
	
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
			metaTable.masses[i].pos = vector:new(lengthOfElementT[i], 0, 0)
			if i < numOfMasses then
			metaTable.springs[i] = SpringSystem:new(metaTable.masses[i],
			metaTable.masses[i+1],
			springConstant,
			lengthOfElementT[i],
			springFrictionConstant)
			end
		end
		

		
end

