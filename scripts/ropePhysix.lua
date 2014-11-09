    -- computate rotation matrice -- relative to zero, zero , zero  . |
                                                                                                                                 / \
     
     
    --update the sensor grid
                                                                                                                                     
    -- the real rotation around the y-axis affects the ideal modell thus, we transfer it
    -- add new appeared forces if the rotation changed: (centripetal force)
    --update idealised modell
     
    --rotation derivation of the original applied to a copyOf the idealised modell (except)
    --Constants
	
    g=9.81 --mapdependent
	function init()
	g=Game.gravity
	if g== nil then g=9.81 end
	--Spring.Echo("Gravity of the Situation:" g)
	end
	
	temp=
    fricTion=1.0
     
    function getMapDependtGravityConstant()
     
     
    end
     
    --/Constants
    --Class Vector3D--------------------------------------------------------------
    Vector3D = {}
    Vector3D.__index = Vector3D
     
    function Vector3D.create(xtVal, ztVal, ytVal)
    --Constructor
       local vec = {}             -- our new object
       setmetatable(vec,Vector3D)  -- make Account handle lookup
       vec.xVal = xtVal      -- initialize our object
       vec.zVal= ztVal
       vec.yVal=ytVal
       return vec
     --/Constructor
    end
     
    function Vector3D:Addition(otherVector)
    self.xVal=self.xVal+otherVector.xVal
    self.zVal=self.zVal+otherVector.zVal
    self.yVal=self.yVal+otherVector.yVal
    end
    function Vector3D:Substraction(otherVector)
     
    self.xVal=self.xVal - otherVector.xVal
    self.zVal=self.zVal - otherVector.zVal
    self.yVal=self.yVal - otherVector.yVal
    end
    function Vector3D:Division(otherVector)
    end
    function Vector3D:Multiplication(otherVector)
    end

	 
    --example function
    function Vector3D:setVal(typeName,val)
     
    if typeName== "x" or typeName == "X" then self.xtVal=val
            elseif typeName== "z" or typeName == "Z" then self.zVal=val
                    else self.yVal=val end
    end
     
    --/Class Vector3D--------------------------------------------------------------
    --Class Mass
    Mass = {}
    Mass.__index = Mass
     
    function Mass.create(massIndyFromLocation,posX,posZ,posY)
    --Constructor
       local otherM = {}             -- our new object
       setmetatable(otherM,Mass)  -- make Account handle lookup
       otherM.mass=massIndyFromLocation
       otherM.vel=Vector3D.create(0,0,0) --Velocity of the Object
       otherM.pos=Vector3D.create(posX,posZ,posY) --Position of the Object
       otherM.force=Vector3D.create(0,0,0)  --Force currently applied on the Object
       
       return otherM
     --/Constructor
    end
	
	function Mass:applyForce(Vec3DHandle)
	self.force:Addition(Vec3DHandle)
	end
	
	function Mass:simulate(durationTime)
	tempVec=self.force:Division(self.mass)
	tempVec= tempVec:Multiplication(durationTime)
	self.vel=self.vel:Addition(tempVec)
	tempVel=self.vel:Multiplication(durationTime)
	self.pos=self.pos:Addition(tempVel)
	
	end
	 
    function Mass:resetInit()
    self.force.setVal("x",0)
    self.force.setVal("y",0)
    self.force.setVal("z",0)
     
    end
     
     
     
    --/Class Mass
     
     
    --Class Simulation
    Simulation = {}
    Simulation.__index = Mass
     
    function Simulation.create(NumberOfMasses,floatMass)
    --Constructor
       local Sim = {}             -- our new object
       setmetatable(Sim,Simulation)  -- make Account handle lookup
       self.numOfMasses=NumberOfMasses+1
	   self.MassTable={}
		   for i=1, NumberOfMasses do
		   self.MassTable[i]={}
		   temp=Mass.create(floatMass,0,0,0)  
		   self.MassTable[i]=temp
		   end
		   
       return Sim
     --/Constructor
    end
	
	function Simulation:init()
		for i=1, self.numOfMasses do
		self.MassTable[i].resetInit()
		 end
	end
	
	function Simulation:solve(solveKey)
		--TODO
	
	end
	
	function Simulation:operate(duration)
	self.init()
	self.solve()
	self.simuLate(duration)
	end
	
	
	function Simulation:simuLate(duration)
	for i=1,self.numOfMasses do
	self.MassTable[i].simulate(duration)
	end
	
	end
	
	function Simulation:getMass(nr)
	if nr < 0 or nr >= self.numOfMasses then return nil 
	else return self.MassTable[nr] end
	end
     
    --/Class Simulation
