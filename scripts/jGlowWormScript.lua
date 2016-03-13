
include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_anim.lua"

 include "lib_Build.lua" 




 

piecesTable={}
glowTable={}
center = piece"center"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center

swamp3DS = piece"swamp.3DS"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= swamp3DS
glowCenter = piece"glowCenter"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= glowCenter
startindex=#glowTable+1
Glow1 = piece"Glow1"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow1
Glow10 = piece"Glow10"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow10
Glow11 = piece"Glow11"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow11
Glow12 = piece"Glow12"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow12
Glow13 = piece"Glow13"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow13
Glow14 = piece"Glow14"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow14
Glow15 = piece"Glow15"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow15
Glow16 = piece"Glow16"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow16
Glow2 = piece"Glow2"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow2
Glow3 = piece"Glow3"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow3
Glow4 = piece"Glow4"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow4
Glow5 = piece"Glow5"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow5
Glow6 = piece"Glow6"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow6
Glow7 = piece"Glow7"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow7
Glow8 = piece"Glow8"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow8
Glow9 = piece"Glow9"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= Glow9
GlowC = piece"GlowC"
glowTable[#glowTable+1]={}

glowTable[#glowTable]= GlowC
GlowC2 = piece"GlowC2"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= GlowC2
onlySpindex=#glowTable
GlowHel1 = piece"GlowHel1"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= GlowHel1
GlowHel2 = piece"GlowHel2"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= GlowHel2
GlowHel3 = piece"GlowHel3"
glowTable[#glowTable+1]={}
glowTable[#glowTable]= GlowHel3

RotaryClubTable={}
Rot1 = piece"Rot1"
RotaryClubTable[#RotaryClubTable+1]={}
RotaryClubTable[#RotaryClubTable]= Rot1
Rot3 = piece"Rot3"
RotaryClubTable[#RotaryClubTable+1]={}
RotaryClubTable[#RotaryClubTable]= Rot3
Rot2 = piece"Rot2"
RotaryClubTable[#RotaryClubTable+1]={}
RotaryClubTable[#RotaryClubTable]= Rot2
Rot5 = piece"Rot5"
RotaryClubTable[#RotaryClubTable+1]={}
RotaryClubTable[#RotaryClubTable]= Rot5
Rot4 = piece"Rot4"
RotaryClubTable[#RotaryClubTable+1]={}
RotaryClubTable[#RotaryClubTable]= Rot4

weaponemit = piece"weaponemit"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= weaponemit
swampTable={}
Swamp1 = piece"Swamp1"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp1
Swamp2 = piece"Swamp2"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp2
Swamp3 = piece"Swamp3"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp3

Swamp4 = piece"Swamp4"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp4
Swamp5 = piece"Swamp5"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp5
Swamp6 = piece"Swamp6"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp6

Swamp7 = piece"Swamp7"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp7
swamp8 = piece"swamp8"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= swamp8

Swamp11 = piece"Swamp11"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp11
swamp10 = piece"swamp10"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= swamp10
swamp9 = piece"swamp9"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= swamp9

Swamp12 = piece"Swamp12"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp12
Swamp13 = piece"Swamp13"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp13
Swamp14 = piece"Swamp14"
swampTable[#swampTable+1]={}
swampTable[#swampTable]= Swamp14

lx,ly,lz=Spring.GetUnitPosition(unitID)
difx,difz=0,0
function DontMove()
nx,ny,nz=Spring.GetUnitPosition(unitID)
difx,difz=nx-lx,nz-lz
lx,ly,lz=nx,ny,nz
	if math.abs(nx-lx) > 5 or math.abs(lz-nz) > 5 then	
	return true
	else
	return false
	end
end
boolOnlyOnce=false
					function script.Activate()
				if boolOnlyOnce==false then
				boolOnlyOnce=true
				end
						return 1
					end

		function script.Deactivate()
			
				return 0
		end



function swamp()
local OnTheMove= DontMove

teamID=Spring.GetUnitTeam(unitID)
	while boolOnlyOnce ==false do
	OnTheMove()
	Sleep(500)
	end
		
	GG.UnitsToSpawn:PushCreateUnit("jswamp",lx,ly,lz,0,teamID)	
	
		while true do
		OnTheMove()
		Sleep(500)
		end

end



function Lightlow()
local spSpawnCEG=Spring.SpawnCEG

	while true do
	Sleep(50)
		if math.random(0,1)==1 then
	
		spSpawnCEG("jglowworm",lx+math.random(-10,10)+difx*0.75,ly+10,lz+math.random(-10,10)+difz*0.75,0,1,0,50,0)
		--spEmitSfx(weaponemit,1024)
		end
	end

end


function script.Create()

StartThread(Lightlow)

	for i=startindex,onlySpindex,1 do

	
	val=math.random(math.random(-270,-120),math.random(120,270))
		if math.random(0,1)==1 then
		Spin(glowTable[i],x_axis, math.rad(val),0.3)
			else
			Spin(glowTable[i],z_axis, math.rad(val),0.3)
			end
	

	end
	
	for i=startindex,#glowTable,1 do	
	val=math.random(math.random(-270,-180),math.random(180,270))
	Spin(glowTable[i],y_axis, math.rad(val),0.3)	
	end
	
	for i=1,#swampTable,1 do
	Hide(swampTable[i])	
	end
	
	for i=1, #RotaryClubTable,1 do
	val=math.random(0,360)
	Turn(RotaryClubTable[i],y_axis,math.rad(val),0)
	end
	

end


function script.Killed(recentDamage,_)


return 0
end

function script.AimFromWeapon1() 
	return weaponemit 
end

function script.QueryWeapon1() 
	return weaponemit 
end

function script.AimWeapon1( heading ,pitch)	

		  
	return true
end

local onlyOnce=true
function script.StopMoving()
	if onlyOnce==true then
	onlyOnce=false
	StartThread(swamp)
	end
end

function script.StartMoving()

end

function script.FireWeapon1()	

	return true
end


