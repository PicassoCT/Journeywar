
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

Pieces={}


local ExcludeDefIDs={}
ExcludeDefIDs[UnitDefNames["jvaryfoo"].id]=true
ExcludeDefIDs[UnitDefNames["jvaryavatara"].id]=true
ExcludeDefIDs[UnitDefNames["ccomender"].id]=true
ExcludeDefIDs[UnitDefNames["jabyss"].id]=true
ExcludeDefIDs[UnitDefNames["citadell"].id]=true
ExcludeDefIDs[UnitDefNames["beanstalk"].id]=true

FoodNeededForTransform=90000

for i=1,8,1 do
name="Kugel0"..i
Pieces[i]=piece(name)
end

function swayInWind()
	while true do 
	Turn(center,x_axis,math.rad(-1),0.0005)
	sway=math.random(-7,7)
	Move(Pieces[1],y_axis,sway,0.03)
	for i=1,8,1 do
	
	sway=math.random(-2,2)
	Turn(Pieces[i],y_axis,math.rad(sway),0.0005)
	end
	Sleep(1200)
	Turn(center,x_axis,math.rad(1),0.0005)
	val=math.random(-1,1)
	Turn(center,z_axis,math.rad(val),0.0005)
	Sleep(1200)
	end
end
center=piece"center"

function script.Create()
Move(center,y_axis,-600,0)
Move(center,y_axis,0,100)
Spin(center,y_axis,math.rad(42),0)
WaitForMove(center,y_axis)
StopSpin(center,y_axis,0)
StartThread(swayInWind)
StartThread(FeedMe)

end

function FeedMe()
Sleep(15000)
x,y,z=Spring.GetUnitPosition(unitID)
	while FoodNeededForTransform > 0 do
	t={}
	t=Spring.GetUnitsInCylinder(x,z,120)
		if t then
		
		table.remove(t,unitID)
			if t and table.getn(t) > 0 then
		
				for i=1,table.getn(t),1 do
					if t[i] ~= unitID then
					
						defID=Spring.GetUnitDefID(t[i])
						if defID and not ExcludeDefIDs[defID] then
				
						hp=Spring.GetUnitHealth(t[i])
						FoodNeededForTransform=FoodNeededForTransform-hp
						Spring.DestroyUnit(t[i],false,true)
						end
					end
				end
			end
		end
	Sleep(300)
	end
	
if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
GG.UnitsToSpawn:PushCreateUnit("jinfinityscraddle",x,y,z,0,teamID)	
Spring.DestroyUnit(unitID,false,true)	
end

function script.Killed(recentDamage,_)


return 1
end





