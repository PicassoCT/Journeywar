
include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 


UnitsImune={}
--added due to massive complaints on how unfair this is
UnitsImune[UnitDefNames["ccomender"].id]=	true
--UnitsImune[UnitDefNames["jabyss"].id]=	true
UnitsImune[UnitDefNames["citadell"].id]=		true
UnitsImune[UnitDefNames["beanstalk"].id]=	true
UnitsImune[UnitDefNames["jglowworms"].id]=	true
UnitsImune[UnitDefNames["jswamp"].id]=	true
UnitsImune[UnitDefNames["conair"].id]=	true
UnitsImune[UnitDefNames["jstealthdrone"].id]=	true
UnitsImune[UnitDefNames["chunterchopper"].id]=	true
UnitsImune[UnitDefNames["crazordrone"].id]=	true
UnitsImune[UnitDefNames["cgunship"].id]=	true
UnitsImune[UnitDefNames["operatrans"].id]=	true
UnitsImune[UnitDefNames["jsempresequoia"].id]=	true
UnitsImune[UnitDefNames["jbutterfly"].id]=	true
UnitsImune[UnitDefNames["jeliah"].id]=	true
UnitsImune[UnitDefNames["jfiredancebomb"].id]=	true
UnitsImune[UnitDefNames["jviciouscycler"].id]=	true
UnitsImune[UnitDefNames["jstealthdrone"].id]=	true

 

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



function swamp()

local spGetUnitPiecePosDir= Spring.GetUnitPiecePosDir
local spGetGroundHeight= Spring.GetGroundHeight
local spGetUnitPosition= Spring.GetUnitPosition

		for i=1,#swampTable,1 do
			Move(swampTable[i],y_axis,-500,0)
			Show(swampTable[i])	
		end
		x,y,z=spGetUnitPosition(unitID)
	
			for i=1,#swampTable,1 do
			px,py,pz=spGetUnitPiecePosDir(unitID,swampTable[i])
			gh=spGetGroundHeight(px,pz)
			distance=math.abs(py)-gh
			diffLoc=0
			if gh < y then diffLoc=gh-y else diffloc= y-gh end
			Move(swampTable[i],y_axis,diffLoc, 12)	
			end		


end


				-- Spring.MoveCtrl.Enable(victimid,true)
				-- x,y,z=Spring.GetUnitPiecePosDir(unitID,Singularity)
				-- local spMovCtrlSetPos=Spring.MoveCtrl.SetPosition
					-- while factor > 0.03 do
					-- ux,uy,uz=Spring.GetUnitPosition(victimid)
					-- factor = GetDistanceToHole(victimid,x,y,z)/globalRange 
					-- tx,ty,tz=(ux*factor + x*(1-factor)),(uy*factor + y*(1-factor)),(uz*factor + z*(1-factor))
					-- spMovCtrlSetPos(victimid,tx,ty,tz)
					-- Sleep(5)
					-- end

TrappedTable={}

function TargetOS()
local spValidUnitID=Spring.ValidUnitID
local spGetUnitsInCylinder=Spring.GetUnitsInCylinder
local spMoveCtrlEnable=Spring.MoveCtrl.Enable
local spGetUnitPosition=Spring.GetUnitPosition
local spMovCtrlSetPos=Spring.MoveCtrl.SetPosition
local spGetUnitPosition=Spring.GetUnitPosition
local spGetUnitDefID=Spring.GetUnitDefID
local spIsUnitDead=Spring.GetUnitIsDead
local spGetUnitExperience=Spring.GetUnitExperience
local swampRange=172
x,y,z=spGetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)

local mumID
local mumExp=0.0
Spring.SetUnitBlocking(unitID,false)
	UnitTable={}
	UnitTable=spGetUnitsInCylinder(x,z,120)
	for i=1,#UnitTable,1 do
	defid=spGetUnitDefID(UnitTable[i])
		if defid == UnitDefNames["jglowworms"].id then		
		mumID=UnitTable[i]
		i=#UnitTable+1
		break
		end
	end
	
local spPlaySoundFile=Spring.PlaySoundFile
	
	while(true) do
	Sleep(250)
	x,y,z=spGetUnitPosition(unitID)
	--Identifying new Units
	UnitTable={}
	UnitTable=spGetUnitsInCylinder(x,z,swampRange)
	table.remove(UnitTable,unitID)
		if UnitTable and table.getn(UnitTable)> 0 then
			for i=1, #UnitTable,1 do
			did=spGetUnitDefID(UnitTable[i])
				if did and not TrappedTable[UnitTable[i]] and not UnitsImune[did] then 
				ux,uy,uz=spGetUnitPosition(UnitTable[i])
				TrappedTable[UnitTable[i]]={ux=ux,uy=uy,uz=uz}	
				spMoveCtrlEnable(UnitTable[i],true)
				end
			end
		end
	boolImDrowning=false
	for k,v in pairs(TrappedTable) do
	if math.random(0,1)==1 then v.uy=v.uy-1 end
	if v.uy > y then v.uy=y end
	
	spMovCtrlSetPos(k, v.ux,v.uy,v.uz)
		if v.uy < y -15 and v.uy > y-20 then
		boolImDrowning=true
		Spring.SetUnitNeutral(k,true)
		Spring.SetUnitNoSelect(k,true)
		end
	end
	
	if math.random(1,22)== 8 and boolImDrowning==true then
	loude=math.random(0.5,1)
	spPlaySoundFile("sounds/jswamp/swamsinking.ogg",loude)  
	end
	

	--lets check on mumy
	if mumID then
		if spIsUnitDead(mumID)==false then
		mumExp=spGetUnitExperience(mumID)
			else
			nr=table.getn(TrappedTable)
				if  nr > 1 then
				dice=math.ceil(math.random(1,nr))
					GG.UnitsToSpawn:PushCreateUnit("jglowworms",x,y,z,0,teamID)	
					Sleep(10)
					UnitTable={}
					UnitTable=spGetUnitsInCylinder(x,z,120)
					for i=1,#UnitTable,1 do
					defid=spGetUnitDefID(UnitTable[i])
						if defid == UnitDefNames["jglowworms"].id then						
						mumID=UnitTable[i]
						i=#UnitTable+1
						break
						end
					end
					Spring.DestroyUnit(TrappedTable[dice],true,true)
					TrappedTable[dice]=nil
				end	
			end
	end
	
	end
end


function script.Create()
Spring.SetUnitNoSelect(unitID,true)
StartThread(TargetOS)
StartThread(swamp)
	
	Hide(weaponemit)
	
	for i=1,#glowTable,1 do	
	Hide(glowTable[i])
	end
	
	
	for i=1, #RotaryClubTable,1 do
	val=math.random(0,360)
	Turn(RotaryClubTable[i],y_axis,math.rad(val),0)
	end
	

end


function script.Killed(recentDamage,_)


return 0
end



