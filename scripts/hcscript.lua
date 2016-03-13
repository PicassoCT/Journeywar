local hc =piece "hc"
local hcaim=piece"hcaim"
local leg1=piece"hcleg1"
local leg2=piece"hcleg2"
local leg3=piece"hcleg3"
local leg4=piece"hcleg4"
local deployTime=36000
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_DIGIN=4
local SIG_DIGOUT=8
local checkRange=140
boolFireOnce=true
--walk
bgcorpseId=FeatureDefNames["bgcorpse"].id
iSeeId=FeatureDefNames["cinfantrycorpse"].id
jcorpse=FeatureDefNames["jbiocorpse"].id
jCorpusDelicti=FeatureDefNames["jskincorpse"].id
unitTable={}
unitTable[UnitDefNames["gjmedbiogwaste"].id] = UnitDefNames["gzombiehorse"].id

corpseTable={}
table.insert(corpseTable,jCorpusDelicti)
table.insert(corpseTable,jcorpse)
table.insert(corpseTable,bgcorpseId)
table.insert(corpseTable,iSeeId)

teamID=Spring.GetGaiaTeamID()


boolAllreadyResurrected=false

function checkFeaturesInCircle()
features={}
while(true) do
upx,upy,upz=Spring.GetUnitPosition(unitID)
features=Spring.GetFeaturesInCylinder( upx, upz, checkRange )
units=Spring.GetUnitsInCylinder( upx, upz, checkRange )
	if features	then
			for i=1,table.getn(features),1 do
			     foundFeatureID=Spring.GetFeatureDefID(features[i])
				 -- if the table of corpses contains stuff the headcrab can eat.. it will
				 --Spring.Echo("CheckThem")
					if corpseTable[1]==foundFeatureID or corpseTable[2]==foundFeatureID or  corpseTable[3]==foundFeatureID or  corpseTable[4]==foundFeatureID  and boolAllreadyResurrected==false then
					boolAllreadyResurrected=true
					boolFireOnce=false
					fpx,fpy,fpz=Spring.GetFeaturePosition(features[i])
					Spring.SetUnitMoveGoal (unitID, fpx,fpy,fpz)
					Sleep(2000)
					EmitSfx(hc,1024)
					EmitSfx(hc,1024)
					Spring.SetUnitPosition(unitID,fpx,fpy,fpz)
					EmitSfx(hc,1024)
					Spring.DestroyFeature(features[i])
					Spring.CreateUnit("zombie",fpx,fpy,fpz, 0, teamID)  
					Spring.SpawnCEG("dirt",fpx,fpy,fpz,0,1,0,50,0)
					Spring.SpawnCEG("bloodspray",fpx,fpy,fpz,0,1,0,50,0)
					Spring.DestroyUnit (unitID,false,true)
					break
					end					
			end
			
			
			
	end
	if units then
		for i=1,table.getn(units),1 do
			     foundUnitDefID=Spring.GetUnitDefID(units[i])
				 -- if the table of corpses contains stuff the headcrab can eat.. it will
				 --Spring.Echo("CheckThem")
					if  unitTable[foundUnitDefID] then
					boolAllreadyResurrected=true
					boolFireOnce=false
					fpx,fpy,fpz=Spring.GetUnitPosition(units[i])
					Spring.SetUnitMoveGoal (unitID, fpx,fpy,fpz)
					Sleep(2000)
					EmitSfx(hc,1024)
					EmitSfx(hc,1024)
					Spring.SetUnitPosition(unitID,fpx,fpy,fpz)
					EmitSfx(hc,1024)
					Spring.DestroyFeature(units[i])
					Spring.CreateUnit( unitTable[foundUnitDefID] ,fpx,fpy,fpz, 0, teamID)  
					Spring.SpawnCEG("dirt",fpx,fpy,fpz,0,1,0,50,0)
					Spring.SpawnCEG("bloodspray",fpx,fpy,fpz,0,1,0,50,0)
					Spring.DestroyUnit (unitID,false,true)
					break
					end					
			end
			
	end
Sleep(4000)
end

end

function jumpattack()
Spring.SetUnitNoDraw(unitID,true)-- i know the api.. its all in my head... brb, have to see doctor freeman

		--KillTheUnit
		Spring.DestroyUnit (unitID,false,true) --leave no wreck, except in the coments, showing were you copied and pasted out of knorkes kitchen 
		
		end
		



function legsDown()
Turn(leg1,z_axis,math.rad(0),7)
Turn(leg1,y_axis,math.rad(0),7)
Turn(leg1,x_axis,math.rad(0),7)

Turn(leg2,z_axis,math.rad(0),7)
Turn(leg2,y_axis,math.rad(0),7)
Turn(leg2,x_axis,math.rad(0),7)

Turn(leg3,z_axis,math.rad(0),7)
Turn(leg3,y_axis,math.rad(0),7)
Turn(leg3,x_axis,math.rad(0),7)

Turn(leg4,z_axis,math.rad(0),7)
Turn(leg4,y_axis,math.rad(0),7)
Turn(leg4,x_axis,math.rad(0),7)

end


function checkstance()
 --howtodoStealth on/off
end

function diggIn()
SetSignalMask(SIG_DIGIN)
Sleep(3000)
Spring.PlaySoundFile("sounds/headcrab/hc3.wav")
Move(hc,y_axis,-5,0.3)
WaitForMove(hc,y_axis)
--diggin (for stealth)
end
function diggOut()
SetSignalMask(SIG_DIGOUT)

Spring.PlaySoundFile("sounds/headcrab/hc3.wav")
Move(hc,y_axis,0,0.8)
WaitForMove(hc,y_axis)
--digg out
end

function walk()
SetSignalMask(SIG_WALK)
while true do

Turn(leg1,z_axis,math.rad(30),7)
Turn(leg1,y_axis,math.rad(30),7)
Turn(leg4,y_axis,math.rad(42),7)
Turn(leg2,y_axis,math.rad(52),7)
Turn(leg3,y_axis,math.rad(52),7)
Sleep(340)



Turn(leg2,y_axis,math.rad(30),7)
Turn(leg2,z_axis,math.rad(-30),7)
Turn(leg3,y_axis,math.rad(42),7)
Turn(leg1,y_axis,math.rad(52),7)
Turn(leg4,y_axis,math.rad(52),7)
Turn(leg3,z_axis,math.rad(32),7)
Sleep(340)

end
end

function script.StartMoving()
Signal(SIG_DIGIN)
Signal(SIG_DIGOUT)
StartThread(diggOut)
Signal(SIG_WALK)
StartThread(walk)													
																								
end

function script.StopMoving()
Signal(SIG_DIGOUT)
Signal(SIG_DIGIN)
StartThread(diggIn)
Signal(SIG_WALK)
StartThread(legsDown)
end
--------------------------------------------------------------------------


function script.Killed()
	
Signal(SIG_WALK)
 
  Move(hc,y_axis,7,12)
  Move(hc,z_axis,7,12)
  Turn(hc,x_axis,math.rad(20),15)
  Turn(hc,y_axis,math.rad(7),15)
  WaitForMove(hc,y_axis)
  WaitForMove(hc,z_axis)
  Sleep(50)
  Turn(hc,x_axis,math.rad(-56),35)
  Move(hc,y_axis,1,12)
  Move(hc,z_axis,0,24)
  Turn(hc,x_axis,math.rad(-180),35)
  Sleep(23)
  itRandom=math.random(1,9)
  speed=math.random(8,25)
  for i=0, itRandom, 1 do
						  if speed > 3 then
						  speed=speed-math.random(0,2)
						  end
    rockUrBodyY=math.random(-12,12)
    rockUrBodyX=math.random(-207,-174)
    rockUrBodyZ=math.random(-17,17)
	 Turn(hc,x_axis,math.rad(rockUrBodyX),35)
	 Turn(hc,y_axis,math.rad(rockUrBodyY),35)
	 Turn(hc,z_axis,math.rad(0),35)
						  
  trashrad=math.random(31,59)
  Turn(leg1,x_axis,math.rad(trashrad),speed)
  trashrad=math.random(7,31)
  Turn(leg1,y_axis,math.rad(trashrad),speed)
  Turn(leg1,z_axis,math.rad(-59),speed)
  
  trashrad=math.random(106,130)
  Turn(leg2,x_axis,math.rad(trashrad),(speed+3))
  trashrad=math.random(-160,-110)
  Turn(leg2,y_axis,math.rad(trashrad),(speed+4))
  Turn(leg2,z_axis,math.rad(-143),speed)
  
   trashrad=math.random(-39,6)
  Turn(leg4,x_axis,math.rad(trashrad),speed)
  trashrad=math.random(24,57)
  Turn(leg4,y_axis,math.rad(trashrad),speed)
  Turn(leg4,z_axis,math.rad(70),speed)
  
  trashrad=math.random(-58,-29)
  Turn(leg3,x_axis,math.rad(trashrad),speed)
  trashrad=math.random(-50,0)
  Turn(leg3,y_axis,math.rad(trashrad),speed)
    trashrad=math.random(-120,-90)
  Turn(leg3,z_axis,math.rad(trashrad),(speed+5))
  
  Sleep(280)
  
    Turn(leg1,x_axis,math.rad(0),3)

  Turn(leg1,y_axis,math.rad(0),3)
  Turn(leg1,z_axis,math.rad(0),3)

  Turn(leg2,x_axis,math.rad(0),3)

  Turn(leg2,y_axis,math.rad(0),3)
  Turn(leg2,z_axis,math.rad(0),3)
  

  Turn(leg4,x_axis,math.rad(0),3)

  Turn(leg4,y_axis,math.rad(0),3)
  Turn(leg4,z_axis,math.rad(0),3)
  

  Turn(leg3,x_axis,math.rad(0),3)

  Turn(leg3,y_axis,math.rad(0),3)
 
  Turn(leg3,z_axis,math.rad(0),3)
   Turn(hc,x_axis,math.rad(-180),35)
   rockUrBodyY=rockUrBodyY+10
   Turn(hc,y_axis,math.rad(rockUrBodyY),35)
   Turn(hc,z_axis,math.rad(rockUrBodyZ),35)
  
  Sleep(230)
  
  end
  
  Sleep(580)
   Turn(leg1,y_axis,math.rad(0),0.5)
  Turn(leg1,z_axis,math.rad(0),0.5)

  Turn(leg2,x_axis,math.rad(0),0.5)

  Turn(leg2,y_axis,math.rad(0),0.5)
  Turn(leg2,z_axis,math.rad(0),0.5)
  

  Turn(leg4,x_axis,math.rad(0),0.5)

  Turn(leg4,y_axis,math.rad(0),0.5)
  Turn(leg4,z_axis,math.rad(0),0.5)
  

  Turn(leg3,x_axis,math.rad(0),0.5)

  Turn(leg3,y_axis,math.rad(0),0.5)
 
  Turn(leg3,z_axis,math.rad(0),0.5)
  
  Sleep(2048)

return 0
end

function timeTicker()
Sleep(deployTime)
Spring.DestroyUnit (unitID,false,true)

end

function script.Create()
StartThread(checkFeaturesInCircle)
StartThread(timeTicker)
Spring.PlaySoundFile("sounds/headcrab/hc4.wav")

  --unfold
  
  --diefolded
  
end

-----------------------------------------WEAPON ONE ----------------------------
function script.AimFromWeapon1() 
    	return hcaim
end

function script.QueryWeapon1() 
	return hcaim
end



boolFireOnce=true
function script.AimWeapon1( heading, pitch )

	    if boolFireOnce==true then
		
		Spring.PlaySoundFile("sounds/headcrab/hc.wav")
		Turn(hc,y_axis,heading,3.141)
		WaitForTurn(hc,y_axis)
	
		
		return true
					else
					return false
					end
		
end



function script.FireWeapon1()
		boolFireOnce=false
		StartThread(jumpattack)
		EmitSfx(hc, 1024)

dec=math.random(0,1)
if dec==1 then
Spring.PlaySoundFile("sounds/headcrab/hc2.wav")
else
Spring.PlaySoundFile("sounds/headcrab/hc6.wav")
end
end
