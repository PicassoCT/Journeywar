include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


piecesTable={}
center = piece"center"

piecesTable[#piecesTable+1]= center
jinfcraddle = piece"jinfcraddle"

piecesTable[#piecesTable+1]= jinfcraddle
Circle081 = piece"Circle081"

piecesTable[#piecesTable+1]= Circle081
Object009 = piece"Object009"

piecesTable[#piecesTable+1]= Object009
Object004 = piece"Object004"

piecesTable[#piecesTable+1]= Object004
Object001 = piece"Object001"

piecesTable[#piecesTable+1]= Object001
Circle082 = piece"Circle082"

piecesTable[#piecesTable+1]= Circle082
Object010 = piece"Object010"

piecesTable[#piecesTable+1]= Object010
Object011 = piece"Object011"

piecesTable[#piecesTable+1]= Object011
Object012 = piece"Object012"

piecesTable[#piecesTable+1]= Object012
Line007 = piece"Line007"

piecesTable[#piecesTable+1]= Line007
Line013 = piece"Line013"

piecesTable[#piecesTable+1]= Line013
solar03 = piece"solar03"

piecesTable[#piecesTable+1]= solar03
solar04 = piece"solar04"

piecesTable[#piecesTable+1]= solar04
solar01 = piece"solar01"

piecesTable[#piecesTable+1]= solar01
solar02 = piece"solar02"

piecesTable[#piecesTable+1]= solar02
Line039 = piece"Line039"

piecesTable[#piecesTable+1]= Line039
solar05 = piece"solar05"

piecesTable[#piecesTable+1]= solar05
solar06 = piece"solar06"

piecesTable[#piecesTable+1]= solar06
solar07 = piece"solar07"

piecesTable[#piecesTable+1]= solar07
solar08 = piece"solar08"

piecesTable[#piecesTable+1]= solar08
Egg = piece"Egg"

piecesTable[#piecesTable+1]= Egg
Jet1 = piece"Jet1"

piecesTable[#piecesTable+1]= Jet1
Jet2 = piece"Jet2"

piecesTable[#piecesTable+1]= Jet2
Line040 = piece"Line040"

piecesTable[#piecesTable+1]= Line040
Line041 = piece"Line041"

piecesTable[#piecesTable+1]= Line041
solar09 = piece"solar09"

piecesTable[#piecesTable+1]= solar09
solar010 = piece"solar010"

piecesTable[#piecesTable+1]= solar010
solar011 = piece"solar011"

piecesTable[#piecesTable+1]= solar011
solar012 = piece"solar012"

piecesTable[#piecesTable+1]= solar012
Line042 = piece"Line042"

piecesTable[#piecesTable+1]= Line042
solar013 = piece"solar013"

piecesTable[#piecesTable+1]= solar013
solar014 = piece"solar014"

piecesTable[#piecesTable+1]= solar014
solar015 = piece"solar015"

piecesTable[#piecesTable+1]= solar015
solar016 = piece"solar016"

piecesTable[#piecesTable+1]= solar016
navel = piece"navel"

piecesTable[#piecesTable+1]= navel

buildspot=Egg
function script.Create()
StartThread(keepAtSeaLevel)
end

function script.Killed(recentDamage,_)

suddenDeathjMedCorpse(recentDamage)
return 1
end


function keepAtSeaLevel()
	while true do

	x,y,z=Spring.GetUnitPiecePosDir(unitID,center)
	Move(center,y_axis,y*-1 +52,0.5)
	Sleep(5000)

	end
end

function createConcon(buildspot)
--Animation

x,y,z=Spring.GetUnitPiecePosDir(unitID,buildspot)
id=Spring.CreateUnit("jspacebornembryo",x,y,z,1, teamid)
Spring.MoveCtrl.Enable(id,true)
Spring.MoveCtrl.SetPosition(id,x,y,z)
return id
end

function buildLoop()
local buildIdOfOld=0
local concoonID=0

while true do
buildID=Spring.GetUnitIsBuilding(unitID)
if buildID then
Spring.SetUnitVisible(buildID,false)
--unit is building
	if buildID ~= buildIdOfOld then --new Unit
	Spring.SetUnitVisible(buildIdOfOld,true)
	buildIdOfOld=buildID
		if Spring.ValidUnitID(concoonID) then Spring.DestroyUnit(concoonID,true,false)  end
		concoonID=createConcon(buildspot)
		end
	--get buildprogress and set it as hp
	
		if Spring.ValidUnitID(buildID)==true then
		health,   maxHealth,   paralyzeDamage,   captureProgress,   buildProgress=Spring.GetUnitHealth(buildID)
		hp=math.max(1,math.ceil(buildProgress*100))
		Spring.SetUnitHealth(buildID,hp)
		end
		
		
	elseif buildIdOfOld and Spring.ValidUnitID(buildIdOfOld)==true then
	Spring.SetUnitVisible(buildIdOfOld,true)
	if Spring.ValidUnitID(concoonID) then Spring.DestroyUnit(concoonID,true,false)  end
	end
	Sleep(500)
end

end


function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end

function script.QueryBuildInfo() 
  return buildspot 
end

function script.QueryNanoPiece()
     return buildspot
end

