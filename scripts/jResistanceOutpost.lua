buildspot=piece"buildspot"
fistenpist=piece"fistenpist"
center=piece"center"
local range=190
SIG_FIST=1
fistenpist=piece"fistenpist"
object={}
for i=1,13, 1 do
object[i]={}
temp="Obj"..i
object[i]=piece(temp)
end

function distribDebris()
d=math.random(0,360)
Turn(center,y_axis,math.rad(d),0)
for i=1,table.getn(object),1 do
d=math.random(0,360)
Turn(object[i],y_axis,math.rad(d),0)
end

end


function isUnitAGangsta(BigAndBlack)
sirMayISeeYourIdPlease=nil
sirMayISeeYourIdPlease=Spring.GetUnitDefID(BigAndBlack)		

	if sirMayISeeYourIdPlease== nil then
	return false
		else
			if sirMayISeeYourIdPlease== UnitDefNames["cdistrictnone"].id or sirMayISeeYourIdPlease == UnitDefNames["scumslum"].id then
			return true
				else
				return false
				end
		end
end


function buildingWatcher()


unitsNearby={}
x,y,z=Spring.GetUnitPosition(unitID)
if x ~= nil then
unitsNearby= Spring.GetUnitsInCylinder(x,z,range)
table.remove(unitsNearby,unitID)
	if unitsNearby~=nil and table.getn(unitsNearby)~=0 then

		for i=1,table.getn(unitsNearby),1 do
		booltemp=isUnitAGangsta(unitsNearby[i])
			if booltemp== true then
			return unitsNearby[i]
			end
		end
	
	end
	


else
return nil
end

end


function fourReal()
Sleep(2000)
attachedID=buildingWatcher()
	if attachedID == nil then 
	 Spring.DestroyUnit (unitID,false,false) 
	else
		while (Spring.ValidUnitID(attachedID))== true do
		Sleep(250)
		
		end
	Spring.DestroyUnit (unitID,false,false) 
	end
end
	
function script.Create()
distribDebris()
StartThread(fourReal)
end


function script.QueryBuildInfo() 
	return buildspot	--the unit will be constructed at the position of this piece
end



Spring.SetUnitNanoPieces(unitID,{ fistenpist})



function script.Killed()

end



function script.Activate()
Show(fistenpist)
	SetUnitValue(COB.YARD_OPEN, 1)
	SetUnitValue(COB.INBUILDSTANCE, 1)
	SetUnitValue(COB.BUGGER_OFF, 1)

	return 1
end

function script.Deactivate()
Hide(fistenpist)
	Signal(SIG_BUILDSTUFF)
	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	SetUnitValue(COB.BUGGER_OFF, 0)

	return 0
end


--------BUILDING---------
function script.StopBuilding()
Signal(SIG_FIST)
end

function UpandDown()
SetSignalMask(SIG_FIST)
while(true) do
Move(fistenpist,y_axis,14,29)
WaitForMove(fistenpist,y_axis)
Move(fistenpist,y_axis,-6,9)
WaitForMove(fistenpist,y_axis)
end

end


function script.StartBuilding(heading, pitch)	
	Signal(SIG_FIST)
	StartThread(UpandDown)
end



