turnerpoint =piece "turnerpoint"
energyorb =piece "energyorb"
truster1=piece"truster1"
truster2=piece"truster2"
truster3=piece"truster3"
truster4=piece"truster4"
center=piece"center"
Ground={}
for i=1,6, 1 do
Ground[i]={}
name="grd"..i
Ground[i]=piece(name)
end

function dirtEmit()
	for i=1,12,1 do
	s=math.ceil(math.random(1,5))
	EmitSfx(Ground[s],1024)
	Sleep(10)
	EmitSfx(Ground[s],1024)
	Sleep(10)
	EmitSfx(Ground[s],1024)
	Sleep(350)
	end

end

function startSequoia()
Move(turnerpoint,y_axis,25,6.3)
Spin(energyorb,y_axis,math.rad(42),12)
Spin(energyorb,z_axis,math.rad(22),12)
Spin(energyorb,x_axis,math.rad(-22),12)
WaitForMove(turnerpoint,y_axis)
Move(turnerpoint,y_axis,50,7.3)
StartThread(dirtEmit)
WaitForMove(turnerpoint,y_axis)
EmitSfx(truster2,1025)
Move(turnerpoint,y_axis,75,19.3)

EmitSfx(truster4,1025)
WaitForMove(turnerpoint,y_axis)
Move(turnerpoint,y_axis,100,25.3)
	for i=1,6,1 do
	Explode(Ground[i],SFX.FALL +SFX.NO_HEATCLOUD)
	Hide(Ground[i])
	naptime=math.ceil(math.random(600,1800))
	Sleep(naptime)
	end

EmitSfx(truster1,1025)
Turn(turnerpoint,z_axis,math.rad(91),3)
EmitSfx(truster3,1025)
Sleep(10)
EmitSfx(truster2,1025)
EmitSfx(truster1,1025)
Sleep(10)
EmitSfx(truster4,1025)
WaitForTurn(turnerpoint,z_axis)
--now we replace it with a flyingSequoia
				local x,y,z=Spring.GetUnitPosition (unitID)
			   local teamID = Spring.GetUnitTeam (unitID)
				mexID= Spring.CreateUnit("jsempresequoia", x, y, z, 0, teamID) 
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(mexID,health)	
				Spring.DestroyUnit (unitID,false,true)

end
boolOnlyOnce=false
	function script.Activate()
	
		if boolOnlyOnce==false then
		boolOnlyOnce=true
			StartThread(startSequoia)
		end	

	return 1
	end

	function script.Deactivate()
	
		--SetUnitValue(COB.MAX_SPEED,340787)--sets the speed to 5,2 *65533	
	
			return 0
			end
			
	 

function script.Create()


end


function script.Killed(recentdamage,_)
Spring.PlaySoundFile("sounds/jEtree/tree.wav")
i=1
while (i < 90) do
EmitSfx(truster1,1025)

Turn(center,x_axis,math.rad(i),i/2)
WaitForTurn(center,y_axis)
EmitSfx(truster2,1025)
i=i+i
if i > 90 then i=90 end
end




return 1

end

