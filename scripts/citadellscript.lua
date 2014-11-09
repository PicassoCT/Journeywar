 include "suddenDeath.lua"
 
 boolPressedButtonTwice=false
 
elCid=piece "elCid"
spawnPoint =piece "spawnPoint"
shield=piece"shield"
 blade = piece "blade"
 cidronesem = piece"cidronesem"
 fireflake = piece"fireflake"
 debris1=piece"debris1"
 debris2=piece"debris2"
 debris3=piece"debris3"
 debris4=piece"debris4"
 debris5=piece"debris5"
sparks={}
for i=1,27,1 do
sparks[i]={}
spark= "sparkOmotion"..i
sparks[i]=piece (spark)
end

shields={}
for i=1,12,1 do
shields[i]={}
shielda= "shield"..i
shields[i]=piece (shielda)
end

rocks={}
for i=1,71,1 do
rocks[i]={}
stone= "stone"..i
rocks[i]=piece (stone)
end

local nrOfReinforcements=5
boolShowFullStorm=false
local sparkcloudemit=piece "sparkcloudemit"
local cinanoemit1=piece"cinanoemit1"
local cinanoemit2=piece"cinanoemit2"
local cinanoemit3=piece"cinanoemit3"
--dustemitter cinanoemit1
local cidustemi1=piece"cidustemi1"
local cidustemit=piece"cidustemit"
local cidustemi0=piece"cidustemi0"
--the firecloud
local cifireclou= piece"cifireclou"
local ciFirCloud1=piece"ciFirCloud1"
local ciFirCloud2=piece"ciFirCloud2"
local ciFirCloud3=piece"ciFirCloud3"
local ciFirCloud4=piece"ciFirCloud4"


 cifireclo0=piece"cifireclo0"
 cifireclo1=piece"cifireclo1"
 cififlakef=piece"cififlakef"
--dronemitters
local ciscanemi0=piece"ciscanemi0"
local ciscanemi1=piece"ciscanemi1"
local ciscanemit=piece"ciscanemit"
--darkengery reactor emiter
local cishadersp=piece"cishadersp"
--turret + two turret emiter
local citurret=piece"citurret"
local citurrete0=piece"citurrete0"
local citurretem=piece"citurretem"
--turret + two turret emiter --
local citurret04=piece"citurret04"
local citurrete5=piece"citurrete5"
local citurrete6=piece"citurrete6"
--turret + two turret emiter--
local citurret2=piece"citurret2"
local citurrete1=piece"citurrete1"
local citurrete2=piece"citurrete2"
--turret + two turret emiter
local citurret3=piece"citurret3"
local citurrete3=piece"citurrete3"
local citurrete4=piece"citurrete4"
--superportal+magnetic sucker
--local cifireclo2=piece"cifireclo2"

local cisuperpor=piece"cisuperpor"
local cicylind= piece"cicylind"
local ciportalvortemit=piece"ciportalvortemit"
local ciPorCloud1=piece"ciPorCloud1"
local ciPorCloud2=piece"ciPorCloud2"
local ciPorCloud3=piece"ciPorCloud3"
local ciPorCloud4=piece"ciPorCloud4"

darkcloudemit={}
for i=5,12,1 do
x=i-4
darkcloudemit[x]={}
cloud= "ciPorCloud"..i
darkcloudemit[x]=piece (cloud)
end

function SpinArrest(piecename)
StopSpin(piecename,x_axis)
StopSpin(piecename,y_axis)
StopSpin(piecename,z_axis)

end

--citadellbody
local citadelcor=piece"citadelcor"
local citadel =piece"citadel"

shater =piece"shaterfx"
local SIG_WARP=2
local SIG_DUST=4
local SIG_PSTORM=8
boolFireCloud=false
boolBloodyVirginMary=true

--arrive every 1:30 secs -> to forwards that hollywood action curve, in which every 3 min something is blown up- 
function reInforCements()
Sleep(65000)
teamID=Spring.GetUnitTeam(unitID)
Spring.PlaySoundFile("sounds/citadell/citadellJourney.wav")  
Sleep(180000)
dropPx,dropPy,dropZ=Spring.GetUnitPosition(unitID)
for i=1,nrOfReinforcements,1 do

for thee=1,600,1 do
Sleep(100)
end
Spring.PlaySoundFile("sounds/citadell/reinforcements.wav")  

local spCreateUnit=Spring.CreateUnit
	for a=1,270,1 do
		if a > 220 then
		EmitSfx(cishadersp,1026)
		else
		EmitSfx(cishadersp,1030)
		end
	Sleep(100)
	end
				if i==1 then

			spCreateUnit("contruck",dropPx,dropPy,dropZ+125, 0, teamID)  
			spCreateUnit("bg",dropPx+20,dropPy,dropZ+90+i, 0, teamID)  
			spCreateUnit("bg",dropPx-20,dropPy,dropZ+75+i, 0, teamID)  
			spCreateUnit("bg",dropPx+20,dropPy,dropZ+55+i, 0, teamID)  

			spCreateUnit("contruck",dropPx,dropPy,dropZ+250+i, 0, teamID)  
			spCreateUnit("bg",dropPx+20,dropPy,dropZ+200+i, 0, teamID)  
			spCreateUnit("bg",dropPx-20,dropPy,dropZ+180+i, 0, teamID)  
			spCreateUnit("bg",dropPx+20,dropPy,dropZ+160+i, 0, teamID)

			spCreateUnit("contruck",dropPx,dropPy,dropZ+340+i, 0, teamID)  
			spCreateUnit("bg",dropPx+20,dropPy,dropZ+300+i, 0, teamID)  
			spCreateUnit("bg",dropPx-20,dropPy,dropZ+280+i, 0, teamID)  
			spCreateUnit("bg",dropPx+20,dropPy,dropZ+260+i, 0, teamID)


										else
										
									spCreateUnit("contrain",dropPx,dropPy,dropZ+340+i, 0, teamID)  
										

									spCreateUnit("conair",dropPx,dropPy,dropZ+250, 0+i, teamID)  
									spCreateUnit("bg",dropPx+20,dropPy,dropZ+200+i, 0, teamID)  
									spCreateUnit("bg",dropPx-20,dropPy,dropZ+180+i, 0, teamID)  
									spCreateUnit("bg",dropPx+20,dropPy,dropZ+160+i, 0, teamID)

									spCreateUnit("conair",dropPx,dropPy,dropZ+340+i, 0, teamID)  
									spCreateUnit("bg",dropPx+20,dropPy,dropZ+300+i, 0, teamID)  
									spCreateUnit("bg",dropPx-20,dropPy,dropZ+280+i, 0, teamID)  
									spCreateUnit("bg",dropPx+20,dropPy,dropZ+260+i, 0, teamID)

										end

end
if math.random(0,1)== 1 then
Sleep(6*60*10000)
Spring.PlaySoundFile("sounds/citadell/centpropagendspeech.ogg",0.9)
end

end


function FireCloud()
boolFireCloud=true
Spin(cicylind,y_axis,math.rad(120),15)
Spin(cisuperpor,y_axis,math.rad(88),11)	

down=100
unitX,unitY,unitZ= Spring.GetUnitPosition(unitID)
local spSpawnCEG=Spring.SpawnCEG
	while(boolFireCloud==true) do
			local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud1" )
				spSpawnCEG("citadellfire",CemitX+unitX,CemitY+unitY-down,CemitZ+unitZ,0,1,0,50,0)
				sleePhe=math.random(70,160)


				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud2" )
				spSpawnCEG("citadellfire",CemitX+unitX,CemitY+unitY-down,CemitZ+unitZ,0,1,0,50,0)
				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud3" )
				spSpawnCEG("citadellfire",CemitX+unitX,CemitY+unitY-down,CemitZ+unitZ,0,1,0,50,0)

				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud3" )
				spSpawnCEG("citadellfire",CemitX+unitX,CemitY+unitY-down,CemitZ+unitZ,0,1,0,50,0)
				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud4" )
				spSpawnCEG("citadellfire",CemitX+unitX,CemitY+unitY-down,CemitZ+unitZ,0,1,0,50,0)
	Sleep(120)
	end


end

function SpawnCloud()

SetSignalMask(SIG_PSTORM)


	 unitX,unitY,unitZ= Spring.GetUnitPosition(unitID)
local spSpawnCEG=Spring.SpawnCEG

			while(true) do
				
				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud1" )
				spSpawnCEG("citadellcloud",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
				sleePhe=math.random(70,160)


				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud2" )
				spSpawnCEG("citadellcloud",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud3" )
				spSpawnCEG("citadellcloud",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)

				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud3" )
				spSpawnCEG("citadellcloud",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
				local CemitX,CemitY,CemitZ=Spring.GetUnitPiecePosition(unitID,piece"ciPorCloud4" )
				spSpawnCEG("citadellcloud",CemitX+unitX,CemitY+unitY,CemitZ+unitZ,0,1,0,50,0)
				
				for xand=1,8,1 do
				
						if xand == 7 or xand == 5 then
						zuFall=math.random(-50,50)
						Move(darkcloudemit[xand], x_axis,zuFall, 0)
						end
						if xand == 8 or xand == 6 then
						Move(darkcloudemit[xand], z_axis,zuFall, 0)
						end
				zuFall=math.random(-20,30)
				Move(darkcloudemit[xand], z_axis,zuFall, 0)
				EmitSfx(darkcloudemit[xand], 1032)
						
				end
							local spSpawnCEG=Spring.SpawnCEG
								
					if boolShowFullStorm == true then
										for i=1,27,1 do
												local SemitX,SemitY,SemitZ=Spring.GetUnitPiecePosition(unitID,sparks[i])
												spSpawnCEG("portalstorm",SemitX+unitX,SemitY+unitY,SemitZ+unitZ,0,1,0,50,0)
												
												
												if i==1 then
													Street15X,Street15Y,Street15Z=Spring.GetUnitPiecePosition(unitID,sparks[15])	
												 
														for ti=1,8,1 do
																 StoneX,StoneY,StoneZ= Spring.GetUnitPiecePosition(unitID,rocks[ti])	
																
																	if StoneY < SemitY and StoneY > Street15Y then
																	Move(rocks[ti],x_axis,SemitX,19)
																	Move(rocks[ti],z_axis,SemitZ,16)
																	end
																
														end
												
												end
												
												
												if i==15 then 
														for ti=1,8,1 do
														 StoneX,StoneY,StoneZ= Spring.GetUnitPiecePosition(unitID,rocks[ti])	
														
																if StoneY < SemitY then
																Move(rocks[ti],x_axis,SemitX,19)
																Move(rocks[ti],z_axis,SemitZ,16)
																end
														
														end
												end
												
												if i== 27 then
																spSpawnCEG("portalground",SemitX+unitX,SemitY+unitY,SemitZ+unitZ,0,1,0,50,0)
												end
										end
						end

					x=math.random(1,7)
					String="sounds/vort/zap"..x
					String=String..".wav"		

					Spring.PlaySoundFile(String,0.3)
								
					Sleep(sleePhe)
			end


end

function CriticalHitDetector()
local hitPointsOfOld=Spring.GetUnitHealth(unitID)
hpPercentage=hitPointsOfOld/16
Sleep(800)
local hitPoints=Spring.GetUnitHealth(unitID)
counter=1
	while(true) do
				if (hitPoints < hitPointsOfOld-hpPercentage ) then
				Spring.PlaySoundFile("sounds/citadell/citadellAlarm.wav")  
				Sleep(5000)
				end
				
	hitPoints=Spring.GetUnitHealth(unitID) 
	Sleep(800)
	hitPointsOfOld=hitPoints
	end

end


function DustStomp()

local unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
SetSignalMask(SIG_DUST)
local spSpawnCEG =Spring.SpawnCEG
for i=1,12,1 do
val=math.random(-420,420)
Spin(shields[i],y_axis,math.rad(val),0)
end
Show(cishadersp)
Spin(shield,y_axis,math.rad(420),0)
	while(true) do

	spSpawnCEG("dirt",unitx,unity,unitz,0,1,0,50,0)
	Sleep(1200)
	end


end

function themRocks(startRock,Endrock,minRand,maxRand)
	for r=startRock,Endrock,1 do
	Show(rocks[r])
	Move(rocks[r],y_axis,0,0)
	speed=math.random(minRand,maxRand)
	liftOrShift=math.random(0,1)
	Move(rocks[r],y_axis,681,speed)
		if liftOrShift == 0 then
		Spin(rocks[r],x_axis,speed/10,0.42)
		Spin(rocks[r],y_axis,speed/30,0.22)
			else
			Spin(rocks[r],y_axis,speed/10,0.42)
			Spin(rocks[r],z_axis,speed/30,0.22)

			end
	end

end

function hideRocks(numberx,numbery)
for hid=numberx,numbery,1 do
Hide(rocks[hid])
end

end

function hideAndThrowRocks(numberx,numbery)

for hid=numberx,numbery,1 do
randNum=math.random(25,35)
Hide(rocks[hid]) 
SpinArrest(rocks[hid])
if hid % 5 == 0 then
Explode(rocks[hid],SFX.FIRE + SFX.NO_HEATCLOUD +SFX.FALL)
else
Explode(rocks[hid],SFX.NO_CEG_TRAIL + SFX.NO_HEATCLOUD +SFX.FALL)
end
Sleep(randNum)
end

end


local function WarpEntry()
	Move(blade,y_axis,300,0)
	for r=1,8,1 do
	Show(rocks[r])
	Move(rocks[r],y_axis,0,0)
	speed=math.random(120,185)
	liftOrShift=math.random(0,1)
	Move(rocks[r],y_axis,681,speed)
		if liftOrShift == 0 then
		Spin(rocks[r],x_axis,speed/10,0.42)
		Spin(rocks[r],y_axis,speed/30,0.22)
			else
			Spin(rocks[r],y_axis,speed/10,0.42)
			Spin(rocks[r],z_axis,speed/30,0.22)

			end
		Sleep(speed)
	end

SetSignalMask(SIG_WARP)
Spin(cicylind,y_axis,math.rad(120),15)
Spin(cisuperpor,y_axis,math.rad(88),11)	
Spin(sparks[1],y_axis,0.5,0.1)
Spin(sparks[15],y_axis,-0.8,0.2)
StartThread(SpawnCloud)

Spring.PlaySoundFile("sounds/citadell/portalstorm.wav",0.5)

themRocks(9,20,160,220)
 unitX, unitY, unitZ= Spring.GetUnitPosition(unitID)
local spSpawnCEG=Spring.SpawnCEG
-- gehe die Liste der sparkknoten ab, erhöhe um eins mit jedem Durchgang
	for out=1,26,1 do		
			
			--injedem Durchang gehe die bisher aufgedeckten Knoten ab, Zeige den CegEffect
			for i=1,out,1 do
			local SemitX,SemitY,SemitZ=Spring.GetUnitPiecePosition(unitID,sparks[i])
			spSpawnCEG("portalstorm",SemitX+unitX,SemitY+unitY,SemitZ+unitZ,0,1,0,50,0)
		
			end

		if out==6 then
		themRocks(20,40,140,180)
		hideRocks(9,17)
		end
		
				if out ==15 then
				themRocks(40,60,106,140)
				hideRocks(18,27)
				end
								if out == 23 then
								themRocks(60,71,84,106)
								hideRocks(28,34)
								end
								
									
			
	Sleep(115)
	end

boolShowFullStorm=true
Show(cisuperpor)
Sleep(200)

StartThread(hideAndThrowRocks,42,62)
hideRocks(35,42)	

--fixme
Move(citadelcor,y_axis,500,100)

themRocks(5,8,150,245)

WaitForMove(citadelcor,y_axis)
StartThread(hideAndThrowRocks,63,71)

themRocks(1,5,120,168)
Spring.PlaySoundFile("sounds/citadell/portal.wav",0.5)		
SemitX,SemitY,SemitZ=Spring.GetUnitPiecePosition(unitID,sparkcloudemit)
unitX,unitY,unitZ= Spring.GetUnitPosition(unitID)
	for i=1,10,1 do
	spSpawnCEG("sparkcloud",SemitX+unitX,SemitY+unitY,SemitZ+unitZ,0,1,0,50,0)
	Sleep(100)
	end
	
themRocks(2,5,120,165)	
Show(blade)
Move(blade,y_axis,0,150)
Sleep(1024)
Show(cicylind)

Sleep(150)



Show(citadelcor)
Move(citadelcor,y_axis,375,40)

themRocks(3,8,130,180)

WaitForMove(citadelcor,y_axis)
Move(citadelcor,y_axis,250,70)
WaitForMove(citadelcor,y_axis)

Move(citadelcor,y_axis,125,110)
WaitForMove(citadelcor,y_axis)
boolShowFullStorm=false
Hide(cicylind)
SpinArrest(cicylind)
Move(citadelcor,y_axis,0,270)
WaitForMove(citadelcor,y_axis)
for r=1,71,1 do
	Hide(rocks[r])
	SpinArrest(rocks[r])
end


Spring.PlaySoundFile("sounds/citadell/landing.wav")
unitx,unity,unitz=Spring.GetUnitBasePosition(unitID)
spSpawnCEG("factory_explosion",unitx,unity,unitz,0,1,0,50,0)
Sleep(40)
Show(citadel)
Hide(cisuperpor)
StopSpin(cisuperpor,y_axis)
                     
Show( citurret)                            
                          
Show( citurret04)                             
                           
Show( citurret2)                       
                
Show( citurret3)   
              
Signal(SIG_PSTORM)				
Hide(blade)
end
function spawnDecal()
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)

decalID=Spring.CreateUnit("ccittadeldecal",x,y,z,0,teamID)
end

function HideShield()
			boolShield=false
WaitForMove(shield,y_axis)
	for i=1,12,1 do
	Hide(shields[i])
	end
Hide(shield)
Move(shield,y_axis,0,0)
end


					function script.Activate()	
					boolShield=true
					StartThread(shieldDraw)					
					boolPressedButtonTwice=true
					if boolBloodyVirginMary==true then
				--	StartThread(spawnDecal)
					boolBloodyVirginMary=false
					--StartThread(reInforCements)
					end
				        Signal(SIG_DUST)
						if DustStomp then
						StartThread(DustStomp)    
						end
						return 1
					end

		function script.Deactivate()
		          Signal(SIG_DUST)
		
					for i=1,12,1 do
					Show(shields[i])
					end
				
					Show(shield)
					Move(shield,y_axis,-1200,2400)
					StartThread(HideShield)
				return 0
		end



function script.Create()
--StartThread(spawnCommander)
for i=1,12,1 do
Hide(shields[i])
end
Hide(shield)
for r=1,8,1 do
Hide(rocks[r])
end

StartThread(CriticalHitDetector)
StartThread(delayedSet)
Hide(blade)
Hide( cidronesem)
Hide( fireflake)
Hide( debris1)                           
Hide( debris2)                           
Hide( debris3)                           
Hide( debris4)                           
Hide( debris5)                           
Hide( cidustemi1)                      
Hide( cidustemit)                       
Hide( cidustemi0)                      
Hide( cifireclou)
Hide( cifireclo0)                         
Hide( cifireclo1)                         
Hide( cififlakef)                          
Hide( ciscanemi0)                     
Hide( ciscanemi1)                     
Hide( ciscanemit)                      
Hide( cishadersp)                      
Hide( citurret)                            
Hide( citurrete0)                             
Hide( citurretem)                            
Hide( citurret04)                             
Hide( citurrete5)                             
Hide( citurrete6)                             
Hide( citurret2)                       
Hide( citurrete1)                     
Hide( citurrete2)                     
Hide( citurret3)                       
Hide( citurrete3)                     
Hide( citurrete4)                     
                    

Hide( cisuperpor)                    
Hide( cicylind)
Hide( ciportalvortemit)              
Hide( citadelcor)                     
Hide( citadel )                         
Hide( shater )   
    
StartThread(WarpEntry)
                

StartThread(reInforCements)

end


function fireflakeBurst()
randit=0
rand=math.random(64,128)
		for i=0, rand, 1 do
		randit=randit+1
		Show(fireflake)
		Explode(fireflake,SFX.FALL+SFX.FIRE)
		Hide(fireflake)
		Show(fireflake)
		if randit%3==0 then
		Explode(fireflake,SFX.FIRE)
		Hide(fireflake)
		end
		timeRand=math.random(512,1024)
		Sleep(timeRand)
		end

end

function debrisBurst()
rand=math.random(12,24)
		for i=0, rand, 1 do

		Show(debris1)
		Show(debris2)
		Show(debris3)
		Show(debris4)
		Show(debris5)
		Explode(debris1, SFX.FIRE + SFX.FALL)
		Explode(debris2, SFX.FIRE + SFX.FALL)
		Explode(debris3, SFX.FIRE + SFX.FALL + SFX.SMOKE)
		Explode(debris4, SFX.FIRE + SFX.FALL)
		Explode(debris5, SFX.FIRE + SFX.FALL)
		Hide(debris1)
		Hide(debris2)
		Hide(debris3)
		Hide(debris4)
		Hide(debris5)
		timeRand=math.random(1024,2048)
		Sleep(timeRand)
		end

end


function script.Killed(recentDamage,maxHealth)
StartThread(FireCloud)

	StartThread(fireflakeBurst)
	StartThread(debrisBurst)
	Spin (cifireclou, y_axis, math.rad(-72))
	Spring.UnitScript.Show (cifireclou)

	Spin (cifireclo0, y_axis, math.rad(-35))
	Spring.UnitScript.Show (cifireclo0)
	Spin (cifireclo1, y_axis, math.rad(-12))
	Spring.UnitScript.Show(cifireclo1)

	allHellBreaksLoose()

	Spring.UnitScript.Show(shater)
	Explode (shater, SFX.SHATTER)
	Turn(citadelcor, z_axis, math.rad(15), math.rad(4))
	WaitForTurn(citadelcor,z_axis)
	Turn(citadelcor, z_axis, math.rad(30), math.rad(10))
	WaitForTurn(citadelcor,z_axis)
	Turn(citadelcor, z_axis, math.rad(45), math.rad(14))
	WaitForTurn(citadelcor,z_axis)
	Turn(citadelcor, z_axis, math.rad(90), math.rad(16))
	WaitForTurn(citadelcor,z_axis)
	Spring.UnitScript.Show(cidustemit) 
	Explode (cidustemit, SFX.SHATTER)
	Explode (citadel, SFX.SHATTER)
	Explode (citurret2, SFX.FIRE)
	Explode (citurret3, SFX.FIRE)
	Explode (citurret04, SFX.FIRE)
	Explode (citurret, SFX.FIRE)


boolFireCloud=false
-- --<RubbleScript>
	if recentDamage > 1 then
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	x=math.random(0,3)
	heapID=Spring.CreateUnit("gCScrapHeap",spx,spy,spz, x, teamID)
	Spring.SetUnitNeutral(heapID,true)
	--</RubbleScript>
	--<ciVillian>
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetGaiaTeamID()
	x=math.random(1,5)
	for i=1,x,1 do
	maRa=math.random(-1,1)
	heapID=Spring.CreateUnit("gCiVillian",spx+(150*maRa),spy,spz+(150*maRa),1, teamID)
		Spring.SetUnitMoveGoal (heapID, spx+1000,spy,spz+1000)  
	end

	--</ciVillian>
	else
	--This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
	spx,spy,spz=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetGaiaTeamID()
	x=math.random(0,3)
	heapID=Spring.CreateUnit("gCScrapHeapPeace",spx,spy,spz, x,teamID)
	--What does it take to make a man neutral? Is it whine? Woman?
	Spring.SetUnitNeutral(heapID,true) 
	end
	 --</RubbleScript>
return 0
end

--------BUILDING---------
function script.StopBuilding()
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)	
SetUnitValue(COB.INBUILDSTANCE, 1)


	
end
function delayedSet()
Sleep(1500)
Spring.SetUnitNanoPieces(unitID,{[1]=cinanoemit1,[2]= cinanoemit2,[3]=cinanoemit3})
end

function script.QueryNanoPiece()

return cinanoemit1
end



function script.AimFromWeapon1() 
	return ciscanemi0 
end

function script.QueryWeapon1() 
rand=math.random(0,2)
if rand==0 then
return cinanoemit1
end

if rand==1 then
return cinanoemit2
end
if rand==2 then
return cinanoemit3
end
end

function script.AimWeapon1( heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)

	return true
end

function script.FireWeapon1()	
	return true
end
--------------------------------------------------------------------------
--turret + two turret emiter
function script.AimFromWeapon2() 
	return citurret 
end

function script.QueryWeapon2() 
rand=math.random(0,1)
if rand==0 then
return citurrete0
end

if rand==1 then
return citurretem
end

end

function script.AimWeapon2( heading ,pitch)	
	
	Turn(citurret,y_axis, heading, 3)
    Turn(citurret,x_axis, -pitch, 3)
	WaitForTurn(citurret,y_axis)
	WaitForTurn(citurret,x_axis)
	return true
end

function script.FireWeapon2()	
	return true
end
--------------------------------------------------------------------------
--turret + two turret emiter


function script.AimFromWeapon3() 
	return citurret04 
end


function script.QueryWeapon3() 
rand=math.random(0,1)
if rand==0 then
return citurrete5
end

if rand==1 then
return citurrete6
end

end

function script.AimWeapon3( heading ,pitch)	
	
	Turn(citurret04,y_axis, heading, 3)
    Turn(citurret04,x_axis, -pitch, 3)
	WaitForTurn(citurret04,y_axis)
	WaitForTurn(citurret04,x_axis)
	return true
end

function script.FireWeapon3()	
	return true
end

--------------------------------------------------------------------------
--turret + two turret emiter
function script.AimFromWeapon4() 
	return citurret2 
end

function script.QueryWeapon4() 
rand=math.random(0,1)
if rand==0 then
return citurrete1
end

if rand==1 then
return citurrete2
end

end

function script.AimWeapon4( heading ,pitch)	
	
	Turn(citurret2,y_axis, heading, 3)
    Turn(citurret2,x_axis, -pitch, 3)
	WaitForTurn(citurret2,y_axis)
	WaitForTurn(citurret2,x_axis)
	return true
end

function script.FireWeapon4()	
	return true
end

function allHellBreaksLoose()
--Physics

--Explosion+ Shockwave

end


function script.AimFromWeapon5() 
	return citurret3 
end

function script.QueryWeapon5() 
rand=math.random(0,1)
if rand==0 then
return citurrete3
end

if rand==1 then
return citurrete4
end

end

function script.AimWeapon5( heading ,pitch)	
	
	Turn(citurret3,y_axis, heading, 3)
    Turn(citurret3,x_axis, -pitch, 3)
	WaitForTurn(citurret3,y_axis)
	WaitForTurn(citurret3,x_axis)
	return true
end

function script.FireWeapon5()	
	return true
end

--here be shielding

SHIELDRADIUS=420
cx,cy,cz=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)

boolShield=true
function shieldDraw()
local teamid=Spring.GetUnitTeam(unitID)
--Clear Buildings from Shieldzone - 
T=Spring.GetUnitsInCylinder(cx,cz,SHIELDRADIUS+22)
N=Spring.GetUnitsInCylinder(cx,cz,SHIELDRADIUS-22)
if T and N then 
T=SubSetFromSet(KeyValueTableConverter(T),KeyValueTableConverter(N))
end
--Makes one wish there was a slice into animations
DestroyTable(T)
--add Decals were shield hits the ground..
if not Spring.GetProjectileDirection then return end

	while boolShield do
	--get All Projectiles inside()
	P=GetAllProjInside(SHIELDRADIUS-90)
	--get All Projectiles outside()
	O=GetAllProjInside(SHIELDRADIUS+40)
	if P and O then
	T=SubSetFromSet(O,P)
	ProjectilesReflect(T)
	end
	
	--if you dont have the energy no shield
	if Spring.UseTeamResource(teamid,"energy",42) == false then
		boolShield=false
	
		Spring. GiveOrderToUnit(unitID, CMD.ONOFF, { 0 }, { })
	
	return 
	end
	
	--Repulse Units from outside
	T=Spring.GetUnitsInCylinder(cx,cz,SHIELDRADIUS+60)
	N=Spring.GetUnitsInCylinder(cx,cz,SHIELDRADIUS-22)
	T=SubSetFromSet(T,N)
		factor=190
		if T then
			for i=1, #T do
				if T[i] then
				tx,ty,tz=Spring.GetUnitPosition(T[i])
				tx,ty,tz=tx-cy,ty-cy,tz-cz
				norm=math.sqrt(tx*tx+ ty*ty + tz*tz)
				
				Spring.AddUnitDamage(T[i],12, 1400, unitID,  -1, factor*(tx/norm),factor*( ty/norm),factor*( tz/norm))
				end
			end		
		Sleep(100)
		--Spring.CreateUnit("gdecshields",cx+math.random(-25,25),cy+math.random(-25,25),cz+math.random(-25,25), 0, teamID)  
		end
	end
end

function DestroyTable(T)
if T then 
	for i=1,#T, 1 do
	Spring.DestroyUnit(T[i],true, false, unitID)
	end
end
end

function SubSetFromSet(O,P)
	for i=1,#P,1 do
		if O[P[i]] then
		O[P[i]]=nil
		end
	end
return O
end

function KeyValueTableConverter(T)
K={}
	if T then
		for j=1,#T do
		K[T[j]]=T[j]
		end
	end
return K
end

function GetAllProjInside(Radius)
T=Spring.GetProjectilesInRectangle(cx-Radius,cz-Radius,cx+Radius, cz+Radius)
return KeyValueTableConverter(T)
end

function ProjectilesReflect(T)
local spGetProjectilePosition=Spring.GetProjectilePosition
if not spGetProjectilePosition then return end

local spSetProjectileDirection=Spring.SetProjectileDirection

local vec={dx=0,dy=0,dz=0}

		
	for i=1,#T, 1 do 
	if T[i] then
	px,py,pz=spGetProjectilePosition(T[i])
	vec.dx,vec.dy,vec.dz=Spring.GetProjectileDirection(T[i])
	norm=math.sqrt(vec.dx*vec.dx+vec.dy*vec.dy+vec.dz*vec.dz)
	vec.dx,vec.dy,vec.dz=vec.dx/norm,vec.dy/norm,vec.dz/norm
	--shieldvector
	sdx,sdy,sdz=cx-px,cy-py,cz-pz
	norm=math.sqrt(sdx*sdx+sdy*sdy+sdz*sdz)
	sdx,sdy,sdz=sdx/norm,sdy/norm,sdz/norm
	
	inside=math.sqrt((cx-px)^2+(cy-py)^2+(cz-pz)^2)< SHIELDRADIUS
		if inside then inside=1 else inside=-1 end
	divX, divY, divZ = -1*(vec.dx-sdx),-1*(vec.dy-sdy),-1*(vec.dz-sdz)
		
		sdx,sdy,sdz=inside*sdx+divX*inside,inside*sdy+divY*inside,inside*sdz+divZ*inside	
		spSetProjectileDirection(T[i],sdx,sdy,sdz)
		
	end
	end
end
