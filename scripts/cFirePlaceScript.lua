spiess=piece"spiess"
firePlace=piece"firePlace"
emit=piece"emit"

STORYMAX=4
	

function script.Killed()

return 0
end

function anybodyNearby()
teamid=Spring.GetUnitTeam(unitID)
T=Spring.GetUnitsInCylinder(x,z,300,teamid)
table.remove(T,unitID)
if T and #T > 2 then
local CompTable={[UnitDefNames["bg"].id]=true,
				 [UnitDefNames["bg2"].id]=true,
				 [UnitDefNames["css"].id]=true
				 }
count=0
	for i=1,#T do
	defID=Spring.GetUnitDefID(T[i])
		if CompTable[defID]==true then count=count+1 end
		if count > 2 then return true end
	end
end
return false

end

function storyTime()
	Sleep(12000)
	if false == true and math.random(1,12)==6 and anybodyNearby()==true then
	diceBeNice=math.ceil(math.random(1,STORYMAX))
	SoundName="sounds/cFirePlace/Story"..diceBeNice..".ogg"
	Spring.PlaySoundFile(SoundName,0.9)
	end

end

function onFire()
while(true) do
EmitSfx(emit,1024)
Sleep(60)
end
end

function dinnerIsReady()
RandNomNomNom=math.random(80000,120000)
Sleep(RandNomNomNom)
 Spring.DestroyUnit (unitID,false,true)

end

function script.Create()
Spin(spiess,x_axis,math.rad(17),5)
StartThread(onFire)
StartThread(dinnerIsReady)
StartThread(FireTales)
end

function FireTales()
if math.random(0,1)==1 then
time=math.ceil(math.random(42000,60000))
Sleep(time)


end
end
