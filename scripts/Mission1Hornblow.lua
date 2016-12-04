include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


center=piece"center"
rotationspot=piece"rotationspot"
Carrier3DS=piece"Carrier.3DS"
Turb1=piece"Turb1"
Main=piece"Main"

unitdef=Spring.GetUnitDefID(unitID)

function playRadomBattleSound(Nr,chanceIt)
local spPlaySoundFile=Spring.PlaySoundFile
FourString="sounds/gCrubbleHeap/city_battle"
SecondString=".wav"
y=1
if chanceIt==true then
y=math.random(0,1)
end

if y==1 then
	for i=1,Nr,1 do
	rand=math.random(1,19)
	resultString=FourString..rand
	resultString=resultString..SecondString
	PlaySoundByUnitDefID(unitdef, resultString,1.0, 3500, 1)


	end
end
	
end

function playBattleLoop()

	if maRa()==true then
	decDicer=math.random(0,1)
		if decDicer==1 then
		PlaySoundByUnitDefID(unitdef, "sounds/gCrubbleHeap/battle_loop1.wav",1.0, 30000, 1)
		else
		PlaySoundByUnitDefID(unitdef, "sounds/gCrubbleHeap/battle_loop2.wav",1.0, 30000, 1)
		end
	end
Sleep(30000)
end

function soundEmit()
for i=1,4,1 do
--firstMinute
if i==1 then
StartThread(playRadomBattleSound,12,false)
playBattleLoop()
StartThread(playRadomBattleSound,8,false)
playBattleLoop()

	elseif i==2 then
	--secondMinute
	StartThread(playRadomBattleSound,5,false)
	playBattleLoop()
	StartThread(playRadomBattleSound,12,true)
	playBattleLoop()
		else
	StartThread(playRadomBattleSound,9,true)
	Sleep(60000)
		end

end

end

function script.Create()
StartThread(Emit)
Spring.SetUnitNeutral(unitID,true)
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitAlwaysVisible(unitID,true)
Turn(center,x_axis,math.rad(23),0)
StartThread(dropFromTheSky)
x=math.random(-360,360)
Turn(rotationspot,y_axis,math.rad(x),0)
end

function dropFromTheSky()
Move(Carrier3DS,z_axis,200,0)

Turn(center,x_axis,math.rad(0),0.010)
Sleep(31000)
Spring.PlaySoundFile("sounds/Missions/hornblowImpact.wav") 
WaitForTurn(center,x_axis)
Move(Carrier3DS,z_axis,0,350)
EmitSfx(rotationspot,1026)
Sleep(100)
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
GG.UnitsToSpawn:PushCreateUnit("gcvehiccorpse",x,y,z, 0,teamID ) 
GG.UnitsToSpawn:PushCreateUnit("gcvehiccorpse",x+35,y,z+35, 0,teamID ) 
GG.UnitsToSpawn:PushCreateUnit("gcvehiccorpse",x+35,y,z-35, 0,teamID ) 
GG.UnitsToSpawn:PushCreateUnit("gcvehiccorpse",x-35,y,z-35, 0,teamID ) 
GG.UnitsToSpawn:PushCreateUnit("gcvehiccorpse",x-35,y,z+35, 0,teamID ) 
GG.UnitsToSpawn:PushCreateUnit("gmiss1decalfactory",x,y,z, 0,teamID ) 
--Spring.CreateUnit("gmiss1decalfactory",x,y,z, 0,teamID ) 

EmitSfx(rotationspot,1026)
for i=1, 500,1 do
	EmitSfx(rotationspot,1027)
	EmitSfx(rotationspot,1028)
	EmitSfx(rotationspot,1024)
	EmitSfx(rotationspot,1025)
	EmitSfx(Turb1,1025)
	EmitSfx(Carrier3DS,1025)
	Sleep(50)
	end


	

	for i=1,12,1 do
	time=math.ceil(math.random(1900,29000))
		Sleep(time)
		dx=math.ceil(math.random(-120,120))
		dz=math.ceil(math.random(-120,120))
		rot=math.floor(math.random(1,3))
	if i%2==0 then	
	Spring.CreateFeature( "bgcorpse", x+dx,y,z+dz, rot)		
	else
		dx=math.ceil(math.random(-120,120))
		dz=math.ceil(math.random(-120,120))
		rot=math.floor(math.random(1,3))
	Spring.CreateFeature( "cInfantryCorpse", x+dx,y,z+dz, rot)
	end
		if i%6== 0 then StartThread(soundEmit) end

	end
	GG.UnitsToSpawn:PushCreateUnit("ccomendernuke",x,y,z, 0,teamID ) 

	Sleep(2000)
	Explode(Main,SFX.SHATTER)
	Spring.DestroyUnit(unitID,false,true)
end

function script.Killed()
return 1
end

function Emit()
Sleep(42000)
emitor=piece"emitor"
	while true do
	EmitSfx(emitor,1029)
	Sleep(10)
	end

end