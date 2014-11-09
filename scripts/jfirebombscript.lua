





--unitPieces
local Maxtime=60000
local Maxdistance=980
center=piece"emptyNessy"
x,y,z=Spring.GetUnitPosition(unitID)
function explodeAfterTimeAndDistance()
nx,ny,nz=Spring.GetUnitPosition(unitID)
	while (math.abs(x-nx)+ math.abs(y-ny) +math.abs(z-nz) < 25 ) do --bomb is stationary and thus 
	Sleep(250)
	nx,ny,nz=Spring.GetUnitPosition(unitID)
	end
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitNeutral(unitID,true)
Spring.SetUnitBlocking(unitID,true)
time=0

x,y,z=Spring.GetUnitPosition(unitID)
nx,ny,nz=Spring.GetUnitPosition(unitID)
distance=math.sqrt((nx-x)*(nx-x)+(nz-z)*(nz-z))
	while time < Maxtime and distance < Maxdistance do
	nx,ny,nz=Spring.GetUnitPosition(unitID)
	nx,nz=x-nx,z-nz
	distance=math.sqrt(nx*nx+nz*nz)
	time=time+100
	Sleep(100)
	EmitSfx(center,1024)
	end
	Spring.DestroyUnit(unitID,false,false)
end
function script.Activate()
				       --activates the secondary weapon 
					  
					
					
						return 1
end

		function script.Deactivate()
		  --deactivates the secondary weapon 

			
				return 0
		end



 

 

 

function script.StartMoving()

 
    
end





function script.StopMoving()

end





function script.Create()
StartThread(explodeAfterTimeAndDistance)

end

function script.Killed()

return 1
end



