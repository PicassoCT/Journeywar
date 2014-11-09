include "suddenDeath.lua"
--Define the wheel pieces

--Define the pieces of the weapon
amturret=piece "amturret"
SIG_FLARE=1
leftAm={}
for i=1,14,1 do
leftAm[i]={}
temp= "amemit1"..i
leftAm[i]=piece (temp)
end

rightAm={}
for i=0,13,1 do
rightAm[i+1]={}
temp= "amemit2"..i
rightAm[i+1]=piece (temp)
end


teamID=Spring.GetUnitTeam(unitID)

function script.Create()

end


function goTooKillThemAllPicaMon(piecename)

selectRange=26
piecePosX,piecePosY,piecePosZ,_,_,_=Spring.GetUnitPiecePosDir(unitID,  piecename) 

----Spring.Echo("PiecePosX:",piecePosX.."      | PiecePosZ:",piecePosZ)
--get Piece Position
proChoice={}
proChoice=Spring.GetUnitsInCylinder(piecePosX, piecePosZ,selectRange )--no idea why 2.9 but satan told me so

	if proChoice ~= nil then
							
											

											--Kill the Unit
			for i=1,table.getn(proChoice),1 do		
													if proChoice[i] ~= unitID then
													Spring.SetUnitNoDraw(proChoice[i],true)
													Spring.DestroyUnit(proChoice[i],true,true) --leave no wreck
												    end
			end

	end
end
					


boolReadyFire=true
function flareThread()
SetSignalMask(SIG_FLARE)
Spring.PlaySoundFile("sounds/campro/antimatter.wav")
Sleep(1000)
boolReadyFire=false
for i=1,14,1 do
	if i< 3 then
	EmitSfx(leftAm[i],1024)
	EmitSfx(rightAm[i],1024)

		else
		--EmitSfx(leftAm[i-1],1024)
		--EmitSfx(rightAm[i-1],1024)
		EmitSfx(leftAm[i],1024)
		EmitSfx(rightAm[i],1024)
		Sleep(50)
		--EmitSfx(leftAm[i],1024)
		--EmitSfx(rightAm[i],1024)
		end
	Sleep(120)
	end
	goTooKillThemAllPicaMon(leftAm[12])
	goTooKillThemAllPicaMon(rightAm[12])
	
Sleep(1900)
boolReadyFire=true
end



----aimining & fire weapon
function script.AimFromWeapon1() 
	return amturret 
end
function script.QueryWeapon1() 
	return amturret 
end

	function script.AimWeapon1( heading, pitch )
	Turn(amturret,y_axis,heading,2.1)
	WaitForTurn(amturret,y_axis)
	if boolReadyFire== true then
	return true
	else
	return false
	end

	end

function script.FireWeapon1()	
StartThread(flareThread)
	return true
end

function script.Killed(recentDamage, maxHealth)
	EmitSfx(amturret,1025)
	Explode(amturret,SFX.FIRE +SFX.FALL)
	Sleep(450)
	suddenDeathVM(recentDamage)
	----Spring.Echo ("He is dead, Jim!")
end
--Building



function script.StartMoving()
Signal(SIG_FLARE)
Turn(amturret, y_axis, math.rad(0), 4)											
																								
end

function script.StopMoving()

end

