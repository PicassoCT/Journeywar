include "createCorpse.lua"



aim1=piece"aim1"
center =piece"center"
imgoingdown=piece"imgoingdown"
bady =piece"hl2StyleCompare"
dirtemit1=piece"dirtemit1"
dirtemit2=piece"dirtemit2"


rotor=piece"ROTOR01"
rotors=piece"ROTOR01"


boolLongFly=false

--unitPieces





local boolOnlyOnce=true
local boolMoving=false
local SIG_ONTHEFLY=4
local SIG_BUILD=2
local SIG_LANDED=8
local SIG_HOVER=16
local SIG_FLY=32
local SIG_WAITING=64
SIG_RESET=128


local buildProgress=1
local boolShortStop=false
local boolLongStop=false





function script.Activate()
	--activates the secondary weapon 
	Turn(bady,x_axis,math.rad(-6),12)
	return 1
end

function script.Deactivate()
	--deactivates the secondary weapon 
	Turn(bady,x_axis,math.rad(0),12)
	--return 0
	return 0
end

boolYouOnlyDieOnce=false
function script.HitByWeapon ( x, z, weaponDefID, damage )
	hp=Spring.GetUnitHealth(unitID)
	if hp and hp-damage < 0 and boolYouOnlyDieOnce==false then
		boolYouOnlyDieOnce=true
		Explode( center,SFX.FALL+SFX.FIRE +SFX.SMOKE) 
		Explode( aim1,SFX.FALL+SFX.FIRE +SFX.SMOKE) 
		Spring.SetUnitCrashing(unitID,true)
		SetUnitValue(COB.CRASHING, 1)
		Spring.SetUnitNeutral(unitID,true)
		Spring.SetUnitNoSelect(unitID,true)
		return 0
	end
	return damage
end


function flySound()
	val=0.1
	sign=1
	
	while true do
		if boolLongFly==true then
			Spring.PlaySoundFile("sounds/cGunShip/gunship.wav",val)
			val=val+0.1*sign
			if val== 1 then sign=-1 end
			if val== 0.1 then sign=1 end
			Sleep(20000)
		end
		Sleep(1000)
		
	end
	
end



function boolSetter()
	SetSignalMask(SIG_FLY)
	Sleep(500)
	boolLongFly=true
	
end


function script.StartMoving()
	Signal(SIG_FLY)
	StartThread(boolSetter)
	
	
end

function script.StopMoving()
	boolLongFly=false
	Signal(SIG_FLY)
	
	
end


boolAir=true
function script.Create()
	--test
	StartThread(flySound)
	Spin(rotors,y_axis,math.rad(672),29.5)
	--/test
	
	
	--check boolAir
	Hide(aim1)
	
	
end

function emitSmoke()
	while(true) do
		EmitSfx(bady,1027)
		Sleep(15)
	end
end

function script.Killed()
	Spring.SetUnitCrashing(unitID, true)
	Spring.SetUnitNeutral(unitID,true)
	
	
	StartThread(emitSmoke)
	EmitSfx(bady,1028)
	Sleep(10)
	EmitSfx(bady,1028)
	
	
	
	Spin(imgoingdown,y_axis,math.rad(-250),0.01)
	EmitSfx(bady,1028)
	x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,bady)
	groundHeight=Spring.GetGroundHeight(x,z)
	-- totalHeight=math.abs(y-groundHeight)
	-- Move(imgoingdown,y_axis,-1*totalHeight,3.14)
	-- base=Spring.GetUnitPiecePosDir(unitID,center)
	-- while(y > Spring.GetGroundHeight(x,z))do
	-- x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID,bady)
	-- groundHeight=Spring.GetGroundHeight(x,z)
	-- totalHeight=math.abs(y-groundHeight)+base
	
	-- Move(imgoingdown,y_axis,-1*totalHeight,9.14)
	-- Sleep(450)
	-- end
	-- Sleep(250)
	EmitSfx(bady,1028)
	-- StopSpin(imgoingdown,y_axis,0)
	-- Turn(imgoingdown,y_axis,math.rad(0),0)
	-- Spring.SetUnitPosition(unitID,x,z)
	createCorpseCUnitGeneric()
	Sleep(250)
	return 0
end


function script.AimFromWeapon1() 	
	
	--	EmitSfx(frontAppendixTable[1],1025)	
	
	return bady
	
end

function script.QueryWeapon1() 
	return aim1
end



function script.AimWeapon1( heading, pitch )
	
	
	return true
end


function script.FireWeapon1()
	
	for i=1,11,1 do
		EmitSfx(aim1, 1025)
		Sleep(142)
	end
end