
include "lib_jw.lua" 
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "createCorpse.lua"

local ztorso= piece "zTorso"
local zHead= piece "zHead"
local zRTent= piece "zRTent"
local zRArm= piece "zRArm"
local zLArm= piece "zLArm"
local zdaerme= piece "zdaerme"
local zLTent= piece "zLTent"
local zUL = piece "zUL"
local zLupLeg= piece "zLupLeg"
local zLLeg= piece "zLLeg"
local zRupLeg= piece "zRupLeg"
local zRLeg= piece "zRLeg"
boolRegenerate=false
local boolaLittleNap=false
local rotator = piece "rotator"
local boolFirstTime=true
local boolOneTime=true
local boolunDamagedVirgin=true
local boolNotDeadYet=true
local viewDistance=650

local SIG_WALK=2
local SIG_CRAWL=4
local SIG_IDLE=8
SIG_DEFAULT=16

local hitPoints =0
local StartPoints =0

local ID_DICE=0
local boolRarmed=1
local boolLarmed=1

local boolCrawler=false
--UTILS-----------------------------------------------


function vectorBetrag(xv,yv,x2,y2)
	-- determiniere höheren Wert
	xv=xv-x2
	yv=yv-y2
	
	xv=xv*xv
	yv=yv*yv
	local xyv=xv+yv
	local Betrag=math.sqrt(xyv)
	
	return math.floor(Betrag)
end
------------------------------------------------------
function moveTowardsNearestEnemy()
	lx,ly,lz=0,0,0
	ZOMBIEDEFID=UnitDefNames["zombie"].id
	local spGetUnitDefID=Spring.GetUnitDefID
	zombX,zombY,zombZ=Spring.GetUnitPosition(unitID)
	ozombX,ozombY,ozombZ=zombX,zombY,zombZ
	
	while(true) do
		
		px,py,pz=Spring.GetUnitPosition(unitID)
		enemyId=Spring.GetUnitNearestEnemy(unitID)
		allyID=Spring.GetUnitNearestAlly(unitID)
		
		if Spring.ValidUnitID(allyID)==true and spGetUnitDefID(allyID)== ZOMBIEDEFID then
			ozombX,ozombY,ozombZ=	zombX,zombY,zombZ
			zombX,zombY,zombZ=Spring.GetUnitPosition(allyID)
			if math.sqrt((ozombX-zombX)^2 +(ozombZ-zombZ)^2)> viewDistance then enemyId=allyID end -- follow your nearest Zombie if he is moving
		end
		if enemyId~=nil then
			ex,ey,ez=Spring.GetUnitPosition(enemyId)
			
			distance=math.sqrt((px-ex)*(px-ex)+(pz-ez)*(pz-ez))
			if ex~= nil and distance < viewDistance then
				lx,ly,lz=px-ex,py-ey,pz-ez
				Spring.SetUnitTarget(unitID,enemyId)
				Sleep(4000)
			else --guarantees movement into the last known direction of a enemy
				if px+lx > Game.mapSizeX or px+lx < 0 then lx=lx*-1 end--creates the pingpong behaviour
				if pz+lz > Game.mapSizeZ or pz+lz < 0 then lz=lz*-1 end--creates the pingpong behaviour
				
				Spring.SetUnitMoveGoal(unitID,px+lx,py+ly,pz+lz)
				Sleep(4000)
			end
		end
		Sleep(4000)
	end
end

function damageWatcher()
	--supervises the damageModell
	
	local halfHitpoints=StartPoints*0.5
	halfHitpoints=math.floor(halfHitpoints)
	local quarterHitpoints=StartPoints*0.25
	quarterHitpoints=math.floor(quarterHitpoints)
	local dreiviertelHitpoints=StartPoints*0.75
	dreiviertelHitpoints=math.floor(dreiviertelHitpoints)
	local spGetUnitHealth= Spring.GetUnitHealth
	local spPlaySoundFile=Spring.PlaySoundFile
	hitPointsOfOld=spGetUnitHealth(unitID)
	Sleep(250)
	zombieDefID= Spring.GetUnitDefID(unitID)
	while (boolNotDeadYet==true) do
		hitPoints=spGetUnitHealth(unitID)
		
		if hitPoints < dreiviertelHitpoints then
			if boolOneTime==true then
				EmitSfx(ztorso,1024)
				PlaySoundByUnitDefID(zombieDefID,"sounds/zombie/zombiemoan.wav",0.5, 3000, 1,0)
				
				boolOneTime=false
				loseYourself=math.floor(math.random(0,1))
				if loseYourself == 1 and ID_DICE ~= 9 then
					local dice=math.random(0,1)
					if dice == 1 then
						--right arm
						
						if ID_DICE == 5 or ID_DICE == 7 or ID_DICE == 4 or ID_DICE == 8 then
							Explode(zRTent, SFX.NO_HEATCLOUD + SFX.FALL)
							EmitSfx(zRTent,1024)
							Hide(zRTent)
							StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiedead2.wav",0.5, 3000, 1,0)
						end						
						if ID_DICE == 3 or ID_DICE ==6 or ID_DICE == 0 or ID_DICE == 1 then
							Explode(zRArm, SFX.NO_HEATCLOUD+ SFX.FALL)
							EmitSfx(zRArm,1024)
							Hide(zRArm)
							StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiedead2.wav",0.5, 3000, 1,0)
						end
					else 			 --left arm
						if ID_DICE == 3 or ID_DICE == 6 or ID_DICE == 4 or ID_DICE == 8 then
							Explode(zLTent, SFX.NO_HEATCLOUD + SFX.FALL)
							EmitSfx(zLTent,1024)
							Hide(zLTent)
						end						
						if ID_DICE == 5 or ID_DICE == 7 or ID_DICE == 0 or ID_DICE == 1 then
							Explode(zLArm, SFX.NO_HEATCLOUD + SFX.FALL)
							EmitSfx(zLArm,1024)
							Hide(zLArm)
							StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiedead2.wav",0.5, 3000, 1,0)
						end
						
					end
				end
				
			end
		end
		
		if hitPoints < halfHitpoints then
			
			if boolFirstTime == true then
				StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiemoan2.wav",0.5, 3000, 1,0)
				
				EmitSfx(ztorso,1024)
				boolFirstTime=false
				iAmRandom=math.floor(math.random(0,6))
				if iAmRandom == 3 then
					
					buildCrawler()
				end
				
				
			end
			
			
		end
		
		
		
		if hitPoints < quarterHitpoints then
			
			
			--check for nearby enemys
			xv,yv,zv=Spring.GetUnitPosition(unitID)
			nearEnemyID=Spring.GetUnitNearestEnemy(unitID,1000,false)
			if nearEnemyID ~= nil then
				xe,ye,ze=Spring.GetUnitPosition(nearEnemyID)
				local Distance= vectorBetrag(xv,yv,xe,ye)
				if Distance > 500 then
					layDownRegen()
					
				end
				
			end
		end
		if hitPoints < hitPointsOfOld*0.98 then
			EmitSfx(ztorso,1024)
		end
		
		hitPointsOfOld=hitPoints
		Sleep(1200)
	end
	
	
end

function resetPosition()
	if boolCrawler == false then
		
		Move(ztorso,y_axis,0,3)
		Turn(rotator,x_axis,math.rad(0),5)
		Turn(rotator,y_axis,math.rad(0),5)
		Turn(ztorso,x_axis,math.rad(0),5)
		Turn(ztorso,y_axis,math.rad(0),5)
		Turn(zLArm,x_axis,math.rad(0),3)
		Turn(zRArm,x_axis,math.rad(0),3)
		Turn(zRTent,x_axis,math.rad(0),3)
		Turn(zLTent,x_axis,math.rad(0),3)
		Turn(zLArm,y_axis,math.rad(0),3)
		Turn(zRArm,y_axis,math.rad(0),3)
		Turn(zRTent,y_axis,math.rad(0),3)
		Turn(zLTent,y_axis,math.rad(0),3)
		Turn(zLArm,z_axis,math.rad(0),3)
		Turn(zRArm,z_axis,math.rad(0),3)
		Turn(zRTent,z_axis,math.rad(0),3)
		Turn(zLTent,z_axis,math.rad(0),3)
		Turn(zLupLeg,x_axis,math.rad(0),4)
		Turn(zLLeg,x_axis,math.rad(0),4)
		Turn(zLLeg,y_axis,math.rad(0),4)
		Turn(zLLeg,z_axis,math.rad(0),4)
		Turn(zRupLeg,x_axis,math.rad(0),5)
		Turn(zRupLeg,y_axis,math.rad(0),5)
		Turn(zRupLeg,z_axis,math.rad(0),5)
		
		Turn(zRLeg,z_axis,math.rad(0),5)	
		Turn(zRLeg,x_axis,math.rad(0),5)
	end
	if boolCrawler == true then
		Turn(rotator,x_axis,math.rad(86),24)
		local x=math.random(-189,-169)
		Turn(zLArm,x_axis,math.rad(x),6)
		Turn(zRArm,x_axis,math.rad(x),5)
		Turn(zRTent,x_axis,math.rad(x),4)
		Turn(zLTent,x_axis,math.rad(x),6)
		x=0
		Turn(zLArm,y_axis,math.rad(x),6)
		Turn(zRArm,y_axis,math.rad(x),5)
		Turn(zRTent,y_axis,math.rad(x),4)
		Turn(zLTent,y_axis,math.rad(x),6)
		x=math.random(0,138)
		Turn(zRArm,z_axis,math.rad(x),5)
		Turn(zRTent,z_axis,math.rad(x),4)
		x=x*-1
		Turn(zLArm,z_axis,math.rad(x),6)
		Turn(zLTent,z_axis,math.rad(x),6)
		
		Turn(zHead,x_axis,math.rad(0),6)
		Turn(zHead,y_axis,math.rad(0),6)
		Turn(zHead,z_axis,math.rad(0),6)
		
	end
	
	
end

modULater=0
function script.HitByWeapon ( x, z, weaponDefID, damage )
	if damage > 10 then
		modULater=modULater%10+1
		if modULater > 5 and math.random(0,1)==1 then
			EmitSfx(ztorso,1024)
		end
	end
	
	return damage
end


function walk()
	
	if boolRegen==true then
		
		standUp()
		
	end
	resetPosition()
	Turn(zLArm,x_axis,math.rad(-57),4)
	Turn(zRArm,x_axis,math.rad(-63),5)
	Turn(zRTent,x_axis,math.rad(-68),6)
	Turn(zLTent,x_axis,math.rad(-58),7)
	SetSignalMask(SIG_WALK)
	while (true) do
		rotatorMutator=math.random(2,7)
		Turn(rotator,x_axis,math.rad(rotatorMutator),0.75)
		Turn(ztorso,x_axis,math.rad(-4),4)
		johnnyWalker=math.random(4,14)
		johnnyTalker=math.random(1,4)
		Turn(ztorso,y_axis,math.rad(johnnyWalker),johnnyTalker)
		
		Turn(zRupLeg,x_axis,math.rad(-17),3)
		Turn(zRupLeg,y_axis,math.rad(0),3)
		Turn(zRupLeg,z_axis,math.rad(0),3)
		
		Turn(zRLeg,z_axis,math.rad(0),3)	
		Turn(zRLeg,x_axis,math.rad(0),3)
		--left leg forward
		Turn(zLupLeg,x_axis,math.rad(0),3)
		Turn(zLLeg,x_axis,math.rad(0),2)
		Turn(zLLeg,y_axis,math.rad(0),2)
		Turn(zLLeg,z_axis,math.rad(0),2)
		--right leg backward
		
		-------------------------------------------------------------
		WaitForTurn(rotator,x_axis) 
		WaitForTurn(ztorso,x_axis) 
		WaitForTurn(ztorso,y_axis) 		
		WaitForTurn(zRupLeg,x_axis) 
		WaitForTurn(zRupLeg,y_axis) 
		WaitForTurn(zRupLeg,z_axis) 		
		WaitForTurn(zRLeg,z_axis) 	
		WaitForTurn(zRLeg,x_axis) 
		--left leg forward
		WaitForTurn(zLupLeg,x_axis) 
		WaitForTurn(zLLeg,x_axis) 
		WaitForTurn(zLLeg,y_axis) 
		WaitForTurn(zLLeg,z_axis) 
		rotatorMutator=math.random(0,5)
		Turn(rotator,x_axis,math.rad(rotatorMutator),1)
		
		Turn(ztorso,x_axis,math.rad(6),2)
		
		johnnyWalker=math.random(-14,-4)
		johnnyTalker=math.random(1,4)
		Turn(ztorso,y_axis,math.rad(johnnyWalker),johnnyTalker)
		Turn(ztorso,y_axis,math.rad(-10),3)
		
		Turn(zRupLeg,x_axis,math.rad(0),3)
		Turn(zRupLeg,y_axis,math.rad(11),3)
		Turn(zRupLeg,z_axis,math.rad(7),2)
		
		Turn(zRLeg,z_axis,math.rad(-17),3)	
		Turn(zRLeg,x_axis,math.rad(8),3)
		--left leg forward
		
		
		
		Turn(zLupLeg,x_axis,math.rad(-33),2)
		Turn(zLupLeg,y_axis,math.rad(0),2)
		Turn(zLupLeg,z_axis,math.rad(0),3)	
		
		Turn(zLLeg,x_axis,math.rad(21),2)
		Turn(zLLeg,y_axis,math.rad(0),2)
		Turn(zLLeg,z_axis,math.rad(0),3)
		--right leg backward
		Sleeper=math.random(250,450)
		Sleep(Sleeper)
		
		
		
	end
end

function standUp()
	boolaLittleNap=false
	Turn(rotator,x_axis,math.rad(45),9)
	WaitForTurn(rotator,x_axis)
	Turn(zLArm,x_axis,math.rad(-57),4)
	Turn(zRArm,x_axis,math.rad(-63),5)
	Turn(zRTent,x_axis,math.rad(-68),6)
	Turn(zLTent,x_axis,math.rad(-58),7)
	local a = -55
	local b = 81
	local c = 0
	local d = 21
	tarDa=math.random(0,1)
	if tarDa == 1 then
		Turn(zLupLeg,x_axis,math.rad(a),8)
		Turn(zLLeg,x_axis,math.rad(b),9)
		
		Turn(zRupLeg,x_axis,math.rad(c),8)
		Turn(zRLeg,x_axis,math.rad(d),9)
	end
	if tarDa == 0 then
		Turn(zLupLeg,x_axis,math.rad(c),8)
		Turn(zLLeg,x_axis,math.rad(d),9)
		
		Turn(zRupLeg,x_axis,math.rad(a),8)
		Turn(zRLeg,x_axis,math.rad(b),9)
	end
	
	WaitForTurn(zLArm,x_axis)
	WaitForTurn(zRArm,x_axis)
	WaitForTurn(zRTent,x_axis)
	WaitForTurn(zLTent,x_axis)
	
	WaitForTurn(zLupLeg,x_axis)
	WaitForTurn(zRLeg,x_axis)
	WaitForTurn(zRupLeg,x_axis)
	WaitForTurn(zLupLeg,x_axis)
	Turn(rotator,x_axis,math.rad(6),9)
	Turn(zLupLeg,x_axis,math.rad(0),8)
	Turn(zLLeg,x_axis,math.rad(0),9)
	
	Turn(zRupLeg,x_axis,math.rad(0),8)
	Turn(zRLeg,x_axis,math.rad(0),9)
	WaitForTurn(zLupLeg,x_axis)
	WaitForTurn(zRLeg,x_axis)
	WaitForTurn(zRupLeg,x_axis)
	WaitForTurn(zLupLeg,x_axis)
end

function layDownRegen()
	
	if boolRegenerate == true then
		
		if boolCrawler== false and boolRegen ==false then
			flipFlop=math.random(0,1)
			boolRegen=true
			if flipFlop == 1 then
				Turn(rotator,x_axis,math.rad(88),8)
				WaitForTurn(rotator,x_axis)
			end
			if flipFlop == 0 then
				Turn(rotator,x_axis,math.rad(-86),7)
				WaitForTurn(rotator,x_axis)
			end
		end
		
	end	
	
end

function idle()
	SetSignalMask(SIG_IDLE)
	while(true) do
		
		
		local OneInAThousand=math.random(0,12)
		if OneInAThousand== 2 then
			layDownRegen()
			boolaLittleNap=true
		elseif boolaLittleNap==false then
			gRad=math.random(-360,360)
			Turn(rotator,y_axis,math.rad(gRad),0.15)
			WaitForTurn(rotator,y_axis)
		end
		
		if boolCrawler ~=true and ID_DICE~= 9 and OneInAThousand==9 then
			--do the eliah
			Move(ztorso,y_axis,-6,3)
			Turn(ztorso,x_axis,math.rad(-13),6)
			Turn(zHead,x_axis,math.rad(-19),5)
			Turn(zRTent,x_axis,math.rad(-186),18)
			Turn(zRTent,z_axis,math.rad(33),3)
			Turn(zRArm,x_axis,math.rad(-186),18)
			Turn(zRArm,z_axis,math.rad(28),3)
			Turn(zLTent,x_axis,math.rad(-169),18)
			Turn(zLTent,z_axis,math.rad(-10),3)
			Turn(zLArm,x_axis,math.rad(-163),18)
			Turn(zLArm,z_axis,math.rad(-11),3)
			
			Turn(zLupLeg,x_axis,math.rad(-32),10)
			Turn(zLupLeg,y_axis,math.rad(-15),10)
			Turn(zLupLeg,z_axis,math.rad(21),10)
			Turn(zLLeg,x_axis,math.rad(106),11)
			
			Turn(zRupLeg,x_axis,math.rad(-32),10)
			Turn(zRupLeg,y_axis,math.rad(-10),10)
			Turn(zRupLeg,z_axis,math.rad(-5),3)
			Turn(zRLeg,x_axis,math.rad(122),12)
			
			Sleep(1800)
			
			
			local intIT=math.random(5,15)
			local flipFlop=-1
			local exUndHop=20
			for i=1, intIT, 1 do
				exUndHop=(exUndHop-i)*flipFlop
				
				Turn(zHead,y_axis,math.rad(exUndHop),i)
				WaitForTurn(zHead,y_axis)	
				flipFlop=flipFlop*-1
				Sleep(180)
			end
			
			
			Sleep(1200)
			resetPosition()
		end
		
		Sleep(4900)
	end
end

function crawl()
	SetSignalMask(SIG_CRAWL)
	Turn(rotator,x_axis,math.rad(71),12)
	Move(rotator,y_axis,1,2)
	Turn(zdaerme,x_axis,math.rad(12),4)
	Turn(zLupLeg,x_axis,math.rad(20),12)
	Turn(zRupLeg,x_axis,math.rad(20),12)
	Turn(zHead,x_axis,math.rad(-25),9)
	Sleep(120)
	while (true) do
		--left
		Turn(rotator,x_axis,math.rad(71),12)
		Turn(ztorso,x_axis,math.rad(0),9)
		Turn(ztorso,y_axis,math.rad(-8),9)
		Turn(ztorso,z_axis,math.rad(-11),9)
		
		Turn(zLArm,x_axis,math.rad(-140),12)
		Turn(zLArm,y_axis,math.rad(5),12)
		elementOfSuprise=math.floor(math.random(-14,12))
		Turn(zLArm,z_axis,math.rad(elementOfSuprise),12)
		
		Turn(zLTent,x_axis,math.rad(-140),12)
		Turn(zLTent,y_axis,math.rad(5),4)
		elementOfSuprise=math.floor(math.random(-14,12))
		Turn(zLTent,z_axis,math.rad(elementOfSuprise),4)
		
		Turn(zRArm,x_axis,math.rad(-30),12)
		Turn(zRArm,y_axis,math.rad(173),22)
		Turn(zRArm,z_axis,math.rad(-76),12)
		
		Turn(zRTent,x_axis,math.rad(-100),12)
		Turn(zRTent,y_axis,math.rad(35),22)
		Turn(zRTent,z_axis,math.rad(42),12)
		Turn(zdaerme,z_axis,math.rad(15),12)
		Sleeper=math.floor(math.random(190,350))
		Sleep(Sleeper)
		--right
		Turn(ztorso,x_axis,math.rad(0),9)
		Turn(ztorso,y_axis,math.rad(8),9)
		Turn(ztorso,z_axis,math.rad(11),9)
		
		Turn(zRArm,x_axis,math.rad(-140),12)
		Turn(zRArm,y_axis,math.rad(5),12)
		elementOfSuprise=math.random(-14,12)
		Turn(zRArm,z_axis,math.rad(elementOfSuprise),12)
		
		Turn(zRTent,x_axis,math.rad(-140),12)
		Turn(zRTent,y_axis,math.rad(5),12)
		elementOfSuprise=math.random(-14,12)
		Turn(zRTent,z_axis,math.rad(elementOfSuprise),12)
		
		Turn(zLArm,x_axis,math.rad(-30),12)
		Turn(zLArm,y_axis,math.rad(-173),22)
		Turn(zLArm,z_axis,math.rad(76),12)
		
		Turn(zLTent,x_axis,math.rad(0),12)
		Turn(zLTent,y_axis,math.rad(-20),22)
		Turn(zLTent,z_axis,math.rad(-56),12)
		Turn(zdaerme,z_axis,math.rad(-15),12)
		Sleeper=math.random(190,350)
		Sleep(Sleeper)
	end
end

function buildCrawler()
	EmitSfx(ztorso,1024)
	boolCrawler=true
	itBits=math.random(0,1)
	StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiedead2.wav",0.5, 2000, 1,0)
	
	--crawler
	if itBits == 1 then
		Turn(zLArm,x_axis,math.rad(-167),12)
		Turn(zRArm,x_axis,math.rad(-167),12)
		Turn(zLTent,x_axis,math.rad(-167),12)
		Turn(zRTent,x_axis,math.rad(-167),12)
		Turn(rotator,x_axis,math.rad(86),12)
		Move(rotator,y_axis,0.5,12)
		
		Explode(zUL,SFX.FALL)
		EmitSfx(ztorso,1024)
		Hide(zUL)
		Explode(zLupLeg,SFX.FALL)
		Hide(zLupLeg)
		Explode(zLLeg,SFX.FALL)
		Hide(zLLeg)
		Explode(zRupLeg,SFX.FALL)
		Hide(zRupLeg)
		Explode(zRLeg,SFX.FALL)
		Hide(zRLeg)
		EmitSfx(ztorso,1024)
		Move(ztorso,y_axis,-11,8)
		Turn(zHead,x_axis,math.rad(-43),8)
		Show(zdaerme)
		WaitForTurn(zHead,x_axis)
		WaitForMove(ztorso,y_axis)
	else
		Turn(zLArm,x_axis,math.rad(-167),12)
		Turn(zRArm,x_axis,math.rad(-167),12)
		Turn(zLTent,x_axis,math.rad(-167),12)
		Turn(zRTent,x_axis,math.rad(-167),12)
		Turn(rotator,x_axis,math.rad(88),12)
		Move(rotator,y_axis,1,12)
		
		itBits=math.random(0,2)
		
		Move(ztorso,y_axis,-11,8)
		Turn(zHead,x_axis,math.rad(-43),8)
		
		WaitForTurn(zHead,x_axis)
		WaitForMove(ztorso,y_axis)
		if itBits== 0 then
			Explode(zRLeg,SFX.FALL)
			Hide(zRLeg)
		end
		if itBits== 1 then
			Explode(zRLeg,SFX.FALL)
			Hide(zRLeg)
			Explode(zLLeg,SFX.FALL)
			Hide(zLLeg)
		end 
		if itBits== 2 then
			Explode(zLLeg,SFX.FALL)
			Hide(zLLeg)
		end
		
		--crawler without legs
		
	end
end

function buildZombie()
	ID_DICE=math.floor(math.random(0,9))
	Show(ztorso)
	Show(zHead)
	if ID_DICE == 0 or ID_DICE == 1 or ID_DICE == 2 then
		Show(zRArm)
		Show(zLArm)
		Show(zUL)
		Show(zLupLeg)
		Show(zLLeg)
		Show(zRupLeg)
		Show(zRLeg)
		--two hands
	end
	if ID_DICE == 3 or ID_DICE ==6 then
		Show(zRArm)
		Show(zLTent)	
		Show(zUL)
		Show(zLupLeg)
		Show(zLLeg)
		Show(zRupLeg)
		Show(zRLeg)
		--one hand one tentacle
	end
	if ID_DICE == 5 or ID_DICE == 7 then
		Show(zLArm)
		Show(zRTent)
		Show(zUL)
		Show(zLupLeg)
		Show(zLLeg)
		Show(zRupLeg)
		Show(zRLeg)
		-- one tentacle one hand
	end
	if ID_DICE == 4 or ID_DICE == 8 then
		Show(zLTent)	
		Show(zRTent)
		Show(zUL)
		Show(zLupLeg)
		Show(zLLeg)
		Show(zRupLeg)
		Show(zRLeg)
		--two tentacle
	end
	
	if ID_DICE ==9 then
		boolRarmed=0
		boolLarmed=0
		--armless
		Show(zUL)
		Show(zLupLeg)
		Show(zLLeg)
		Show(zRupLeg)
		Show(zRLeg)
	end
	
	
	
	
end

function script.Create()
	StartPoints=Spring.GetUnitHealth(unitID)
	Hide(ztorso) 
	Hide(zHead) 
	Hide(zRTent) 
	Hide(zRArm) 
	Hide(zLArm) 
	Hide(zdaerme) 
	Hide(zLTent) 
	Hide(zUL ) 
	Hide(zLupLeg) 
	Hide(zLLeg) 
	Hide(zRupLeg) 
	Hide(zRLeg)
	--layDownRegen() 
	buildZombie()
	hitPoints=StartPoints
	StartThread(moveTowardsNearestEnemy)
	
end


function script.StartMoving()
	if boolunDamagedVirgin == true then
		boolunDamagedVirgin=false
		StartThread(damageWatcher)
	end
	
	Signal(SIG_IDLE)
	Signal(SIG_DEFAULT)
	if boolCrawler==false then
		
		
		
		Signal(SIG_WALK)
		StartThread(walk)
		--normal Zombie
		--walk()
	else
		Signal(SIG_CRAWL)
		StartThread(crawl)
		--crawling zombie
		--crawl()
	end
end



function script.StopMoving()
	-- health check
	--lay down
	boolRegen=false
	Signal(SIG_WALK)
	Signal(SIG_CRAWL)
	if boolNotDeadYet == true then
		resetPosition()
		
		if boolCrawler == false then
			StartThread(idle)
		end	
	end	
	StartThread(defaultEnemyAttack,unitID,SIG_DEFAULT, 10000)	
end

function script.AimWeapon1(heading ,pitch)	
	Turn(ztorso,y_axis,heading,3)
	WaitForTurn(ztorso,y_axis)
	return true
end


function script.AimFromWeapon1() 
	return zHead 
end

function script.QueryWeapon1() 
	return zHead
end

function script.FireWeapon1()	
	if boolCrawler== false then
		StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombieattack.wav",0.5, 2000, 1,0)
		
		Turn(zLArm,x_axis,math.rad(-123),34)
		Turn(zLArm,y_axis,math.rad(0),22)
		Turn(zLArm,z_axis,math.rad(0),12)
		
		Turn(zLTent,x_axis,math.rad(-123),34)
		Turn(zLTent,y_axis,math.rad(0),22)
		Turn(zLTent,z_axis,math.rad(0),12)
		
		Turn(zRArm,x_axis,math.rad(-123),24)
		Turn(zRArm,y_axis,math.rad(0),22)
		Turn(zRArm,z_axis,math.rad(0),12)
		
		Turn(zRTent,x_axis,math.rad(-123),32)
		Turn(zRTent,y_axis,math.rad(0),22)
		Turn(zRTent,z_axis,math.rad(0),12)
		WaitForTurn(zLArm,x_axis)
		WaitForTurn(zLTent,x_axis)
		
		WaitForTurn(zRArm,x_axis)
		WaitForTurn(zRTent,x_axis)
		HITit=math.random(28,48)
		Turn(zLArm,x_axis,math.rad(-25),HITit)
		Turn(zLArm,y_axis,math.rad(0),22)
		Turn(zLArm,z_axis,math.rad(0),12)
		HITit=math.random(28,48)
		Turn(zLTent,x_axis,math.rad(-25),HITit)
		Turn(zLTent,y_axis,math.rad(0),22)
		Turn(zLTent,z_axis,math.rad(0),12)
		HITit=math.random(28,48)
		Turn(zRArm,x_axis,math.rad(-25),HITit)
		Turn(zRArm,y_axis,math.rad(0),22)
		Turn(zRArm,z_axis,math.rad(0),12)
		HITit=math.random(28,48)
		Turn(zRTent,x_axis,math.rad(-25),HITit)
		Turn(zRTent,y_axis,math.rad(0),22)
		Turn(zRTent,z_axis,math.rad(0),12)
		WaitForTurn(zLArm,x_axis)
		WaitForTurn(zLTent,x_axis)
		
		WaitForTurn(zRArm,x_axis)
		WaitForTurn(zRTent,x_axis)
		
		
		return true
		
		
	end
	
	if boolCrawler== true then
		var=math.random(0,1)
		if var== 1 then
			Turn(zLArm,x_axis,math.rad(-220),12)
			Turn(zLArm,y_axis,math.rad(0),22)
			Turn(zLArm,z_axis,math.rad(0),12)
			
			Turn(zLTent,x_axis,math.rad(-220),12)
			Turn(zLTent,y_axis,math.rad(0),22)
			Turn(zLTent,z_axis,math.rad(0),12)
			
			Turn(zRArm,x_axis,math.rad(-220),12)
			Turn(zRArm,y_axis,math.rad(0),22)
			Turn(zRArm,z_axis,math.rad(0),12)
			
			Turn(zRTent,x_axis,math.rad(-220),12)
			Turn(zRTent,y_axis,math.rad(0),22)
			Turn(zRTent,z_axis,math.rad(0),12)
			WaitForTurn(zLArm,x_axis)
			WaitForTurn(zLTent,x_axis)
			
			WaitForTurn(zRArm,x_axis)
			WaitForTurn(zRTent,x_axis)
			
			Turn(zLArm,x_axis,math.rad(-152),34)
			Turn(zLArm,y_axis,math.rad(0),22)
			Turn(zLArm,z_axis,math.rad(0),12)
			
			Turn(zLTent,x_axis,math.rad(-152),34)
			Turn(zLTent,y_axis,math.rad(0),22)
			Turn(zLTent,z_axis,math.rad(0),12)
			
			Turn(zRArm,x_axis,math.rad(-152),24)
			Turn(zRArm,y_axis,math.rad(0),22)
			Turn(zRArm,z_axis,math.rad(0),12)
			
			Turn(zRTent,x_axis,math.rad(-152),32)
			Turn(zRTent,y_axis,math.rad(0),22)
			Turn(zRTent,z_axis,math.rad(0),12)
			WaitForTurn(zLArm,x_axis)
			WaitForTurn(zLTent,x_axis)
			
			WaitForTurn(zRArm,x_axis)
			WaitForTurn(zRTent,x_axis)
			
			return true
		end
		
		if var== 0 then
			Turn(zRArm,x_axis,math.rad(-30),12)
			Turn(zRArm,y_axis,math.rad(173),22)
			Turn(zRArm,z_axis,math.rad(-76),12)
			
			Turn(zRTent,x_axis,math.rad(-100),12)
			Turn(zRTent,y_axis,math.rad(35),22)
			Turn(zRTent,z_axis,math.rad(42),12)
			
			
			Turn(zLArm,x_axis,math.rad(-30),12)
			Turn(zLArm,y_axis,math.rad(-173),22)
			Turn(zLArm,z_axis,math.rad(76),12)
			
			Turn(zLTent,x_axis,math.rad(0),12)
			Turn(zLTent,y_axis,math.rad(-20),22)
			Turn(zLTent,z_axis,math.rad(-56),12)
			
			Sleep(250)
			Turn(zLArm,x_axis,math.rad(-152),34)
			Turn(zLArm,y_axis,math.rad(0),22)
			Turn(zLArm,z_axis,math.rad(0),12)
			
			Turn(zLTent,x_axis,math.rad(-152),34)
			Turn(zLTent,y_axis,math.rad(0),22)
			Turn(zLTent,z_axis,math.rad(0),12)
			
			Turn(zRArm,x_axis,math.rad(-152),24)
			Turn(zRArm,y_axis,math.rad(0),22)
			Turn(zRArm,z_axis,math.rad(0),12)
			
			Turn(zRTent,x_axis,math.rad(-152),32)
			Turn(zRTent,y_axis,math.rad(0),22)
			Turn(zRTent,z_axis,math.rad(0),12)
			WaitForTurn(zLArm,x_axis)
			WaitForTurn(zLTent,x_axis)
			
			WaitForTurn(zRArm,x_axis)
			WaitForTurn(zRTent,x_axis)
			return true
		end
		
	end
	if ID_DICE == 9 then
		
		return false
	end
	
	
	
	return true
end



function script.Killed(recentDamage,maxHealth)
	
	boolNotDeadYet=false
	Signal(SIG_WALK)
	Signal(SIG_CRAWL)
	Signal(SIG_IDLE)
	rand=math.random(-25,25)
	Turn(rotator,y_axis,math.rad(rand),0.25)
	Sleep(450)
	dice=math.random(0,1)
	if dice == 1 then
		StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiedead2.wav",0.5, 2000, 1,0)
		
		Explode(zHead,SFX.FALL+SFX.NO_HEATCLOUD)
		
		Hide(zHead)
		nice=math.random(0,1)
		if nice == 1 then
			Move(rotator,y_axis,0,44)
			Move(rotator,x_axis,0,44)
			Move(rotator,z_axis,0,44)
			WaitForMove(rotator,z_axis)
			WaitForMove(rotator,x_axis)
			Turn(rotator,x_axis,math.rad(2),6)
			WaitForTurn(rotator,x_axis)
			Turn(rotator,x_axis,math.rad(45),26)
			WaitForTurn(rotator,x_axis)
			Turn(rotator,y_axis,math.rad(0),2.5)
			Turn(rotator,x_axis,math.rad(85),56)
			WaitForTurn(rotator,x_axis)
			Sleep(3600)
		end
		if nice == 0 then
			Move(rotator,y_axis,0,44)
			Move(rotator,x_axis,0,44)
			Move(rotator,z_axis,0,44)
			WaitForMove(rotator,z_axis)
			WaitForMove(rotator,x_axis)
			Turn(rotator,x_axis,math.rad(-20),6)
			
			
			WaitForTurn(rotator,x_axis)
			Turn(rotator,x_axis,math.rad(-45),26)
			WaitForTurn(rotator,x_axis)
			
			Turn(rotator,y_axis,math.rad(0),2.5)
			Turn(rotator,x_axis,math.rad(-85),56)
			WaitForTurn(rotator,x_axis)
			Sleep(3600)
		end
	end
	
	if dice == 0 then	
		StartThread(PlaySoundByUnitDefID,zombieDefID,"sounds/zombie/zombiedead2.wav",0.5, 2000, 1,0)
		
		Explode(ztorso,SFX.FALL+SFX.NO_HEATCLOUD)
		EmitSfx(ztorso,1024)
		Explode(zHead,SFX.FALL+SFX.NO_HEATCLOUD)
		EmitSfx(zHead,1024)
		Explode(zRTent, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zRArm, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zLArm, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zdaerme, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zLTent, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zUL , SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zLupLeg, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zLLeg, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zRupLeg, SFX.FALL+SFX.NO_HEATCLOUD)
		Explode(zRLeg, SFX.FALL+SFX.NO_HEATCLOUD)
	end
	
	
end


function script.Activate()
	boolRegenerate=true
	
	return 1
end

function script.Deactivate()
	boolRegenerate=false
	
	
	return 0
end