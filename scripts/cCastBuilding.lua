include "suddenDeath.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


center=piece"center"

function randDeg()
return math.random(-360,360)
end

hitPoints=Spring.GetUnitHealth(unitID)
px,py,pz=Spring.GetUnitPosition(unitID)
step=0
teamID=Spring.GetUnitTeam(unitID)

	function script.HitByWeapon ( x, z, weaponDefID, damage )
	step=step+damage
	
	if step > hitPoints/10 then
	step=0
	StartThread(onFire,29000,19000)
	x=math.random(1,3)
		for i=1,x,1 do
		maRa=math.random(-1,1)
		heapID=Spring.CreateUnit("gCiVillian",px+(150*maRa),py,pz+(150*maRa),1, teamID)
		end
	end
	
	
	
			return damage
			



	end

emitfire=piece"emitfire"
firemove=piece"firemove"

function onFire(times,endtimes)

x=math.random(-360,360)
Turn(firemove,y_axis,math.random(x),0)
			 for i=1,times,1 do
				if i < endtimes then
				EmitSfx(emitfire, 1025)
				EmitSfx(emitfire, 1028)			
				EmitSfx(emitfire, 1026)
				EmitSfx(emitfire, 1027)
				else
				EmitSfx(emitfire, 1027)
				end				
			Sleep(200)
			end

end
farcaster={}
emitors={}

farcaster[#farcaster+1]=piece"farcast1"
farcaster[#farcaster+1]=piece"farcast2"
farcaster[#farcaster+1]=piece"farcast3"
farcast1=piece"farcast1"
emitors[#emitors+1]=piece"emit1"
emitors[#emitors+1]=piece"emit2"
emitors[#emitors+1]=piece"emit3"

center=piece"center"


function gateEmit()
	while true do
		if Dec~= 3 then
		EmitSfx(emitors[Dec],1029)
			else
			EmitSfx(emitors[Dec],1030)
			end
	Sleep(40)
	end
end

Dec=1
function script.Create()
	for i=1,3,1 do
	Hide(farcaster[i]) 
	Hide(emitors[i])
	end

i=math.random(1,4)
Turn(center,y_axis,math.rad(i*90),0)
boolShowOne=false
for i=1,3,1 do
	if math.random(0,1)==1 and boolShowOne==false then 
	Show(farcaster[i]) 
	Dec=i
	boolShowOne=true
	 end
end

if boolShowOne==false then Show(farcast1) end
	
StartThread(gateEmit)	
end


function script.Killed(recentDamage,_)


suddenDeath(unitID,recentDamage)
return 0
end




function script.StartMoving()

end

function script.StopMoving()
		
		
end

