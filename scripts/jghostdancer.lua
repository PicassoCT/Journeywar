include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 



--All Praise goes to Knorke. Just look under Awesome in the Wiki.


--Those who enter: Beware, only mindfucks here, i swear!
-- i worked really hard to de-robotimize these - and i think i succeded. 


---Signals to be spread

---------------------IdleStance10-Fucntions-------
aimpivot=piece "aimpivot"
shadowemit=piece"shadowemit"
gdbhleg=piece"gdbhleg"
gdbhlegj=piece"gdbhlegj"
gdflegj=piece"gdflegj"
gdfrontleg=piece"gdfrontleg"
ghostdance=piece"ghostdance"
deathpivot=piece"deathpivot"
boolActivated=true
unitTable={}
unitTableNr=0
recoverTime=90000
SIG_WALK= 1
SIG_IDLE= 2
teamID=Spring.GetUnitTeam(unitID)
boolOnlyOnce=false
fullHealthOfAShadow=0
piecesTable= makePieceTable(unitID)

local JSHADOWCOST=100
function buildIt()
	for i=#unitTable,1,-1 do
		if Spring.GetUnitIsDead(unitTable[i])== false then
		else
			internalEnergy=internalEnergy+30
			table.remove(unitTable,i)
		end
	end
	
	if internalEnergy - JSHADOWCOST > 0 then
		internalEnergy=internalEnergy-JSHADOWCOST
		if #unitTable < 4 then
			x,y,z=Spring.GetUnitPosition(unitID)
			thisID=Spring.CreateUnit("jshadow",x,y,z,1,teamID)
			table.insert(unitTable,thisID)
		end
		return true
	end
	return false
end

function script.HitByWeapon ( x, z, weaponDefID, damage )
	if damage and damage > 20 then
		ed=Spring.GetUnitNearestEnemy(unitID)
		if ed then
			ex,ey,ez=Spring.GetUnitPosition(ed)
			if ex then
				ux,uy,uz=Spring.GetUnitPosition(unitID)
				vx,vz=ex-ux,ez-uz
				
				if buildIt()==true then
					Spring.SetUnitPosition(unitID,ex+vx,ey,ez+vz)
				else
					Spring.SetUnitPosition(unitID,ux-vx/2,uy,uz-vz/2)
				end
			end
		end
	end
	return damage
end

 internalEnergy=0

function spawnAndManageShadows()
	
	local MAX=240
	
	while(true) do
		exp=Spring.GetUnitExperience(unitID) 
		if not exp or exp < 1 then exp=1 end
		
		internalEnergyMax=MAX *exp
		internalEnergy=math.min(internalEnergyMax,internalEnergy+10 )
		
		Sleep(500)
	end
end


function script.Activate()
	boolActivated=true
	return 1
end

function script.Deactivate()
	boolActivated=false
	
	return 0
end


local function legs_down()

	Hide(gdbhlegj)
	Hide(gdflegj)
	Show(gdfrontleg)
	Show(gdbhleg)
	Move(ghostdance,y_axis,0,9.81)
	Turn(gdbhleg,x_axis,math.rad(0),12) 
	Turn(gdbhlegj,x_axis,math.rad(0),12) 
	Turn(gdflegj,x_axis,math.rad(0),12) 
	Turn(gdfrontleg,x_axis,math.rad(0),12) 
	Turn(ghostdance,x_axis,math.rad(0),12) 
	StartThread(idle)
end

HeadRump=piece"HeadRump"
Head = piece"Head"
Ass= piece"Ass"
boolIdle=true
tails={}
for i=0,5,1 do
name="Tail0"..i
tails[#tails+1]=piece(name)
end

function wiggle()
ydeg,xdeg=math.random(-25,25),math.random(-3,30)
turnT(tails,x_axis,xdeg,math.abs(xdeg)/5)
turnT(tails,y_axis,ydeg,math.abs(ydeg)/5)
WaitForTurns(tails)
ydeg,xdeg=ydeg*-1,math.random(-3,30)
turnT(tails,x_axis,xdeg,math.abs(xdeg)/5)
turnT(tails,y_axis,ydeg,math.abs(ydeg)/5)
WaitForTurns(tails)
Sleep(200)
end

waveTables={
[1]=-1,
[2]=1,
[3]=0,
[4]=1,
[5]=-1,
[6]=0
}
ears=piece"ears"
Ear1=piece"Ear1"
Ear2=piece"Ear2"
Rump=piece"Rump"
rotcenter=piece"rotcenter"

function swooshTail()
	degToGoX=math.random(-35,35)
	waveFoo=math.sin
	if maRa()==true then waveFoo=math.cos end
	degAloof=math.random(-10,10)
	PI=3.14159
	randfac=math.random(3,12)
		for i=2,#tails, 1 do
		offSetYet= degAloof * waveFoo(PI/randfac* i)
		Turn(tails[i],y_axis,math.rad(degToGoX+ offSetYet),math.abs((degToGoX+ offSetYet)/2))
		end
	glowTail()	
end


function standingGuard()
resetT(tails)
reset(ghostdance,30)
Turn(gdbhleg,z_axis,math.rad(0),63/1.5)
Turn(gdbhleg,x_axis,math.rad(0),63/1.5)
Turn(gdflegj,x_axis,math.rad(0),63/1.5)
Turn(gdflegj,z_axis,math.rad(0),63/1.5)
Turn(tails[1],x_axis,math.rad(75),70/1.5)
Turn(rotcenter,x_axis,math.rad(-70),70/1.5)
Turn(gdbhleg,x_axis,math.rad(63),63/1.5)
Turn(Head,x_axis,math.rad(42),42/1.5)
Turn(Rump,x_axis,math.rad(7),7/1.5)
Turn(Ass,x_axis,math.rad(-8),8/1.5)
Show(gdflegj)
Hide(gdfrontleg)
	while boolIdle == true do
	--swooshing tail
	swooshTail()
	
	if maRa() == true then
	val1,val2=math.random(-10,10),math.random(-10,10)
	Turn(Ear1,x_axis,math.rad(val1),25)
	Turn(Ear2,x_axis,math.rad(val2),25)
	if math.random(1,15) == 3 then
	for k=1,5 do
	WTurn(Head,x_axis,math.rad(32 - k*2*(-1^k)),42/1.5)
	Sleep(300)
	end
	WTurn(Head,x_axis,math.rad(42),42/1.5)
	end
	end
	WaitForTurns(tails)
	Sleep(200)
	if math.random(1,64)==42  then 
	Sleep(5000) 
	Hide(gdflegj)
	Show(gdfrontleg)
	; break; end
	end

end


function standingWave()
resetT(tails,2.5)
xdeg=math.random(-3,30)
ripple=math.random(-10,10)
tailstart=1
Turn(ears,x_axis,math.rad(0),7)
	while tailstart < #tails do
			for i=1,tailstart,1 do
			randOffset= math.random(-5,5)
			reset(tails[i],3)
			Turn(tails[i],x_axis, math.rad(randOffset),2)
			end
		turnT(tails,x_axis,xdeg,math.abs(xdeg)/5)
			for i=tailstart,#tails, 1 do
			randOffset= math.random(-5,5)
			Turn(tails[i],y_axis, math.rad(ripple*waveTables[i+1-tailstart] + randOffset),2)
			end
		WaitForTurns(tails)
		Sleep(300)
		tailstart =tailstart+1
	end

	while boolIdle==true and math.random(1,128) == 64 do
	Sleep(500)
	end

end

function pranceStance()
	resetT(piecesTable,42)
	Move(ghostdance,y_axis,-2.5,2.55)
	Turn(HeadRump,x_axis,math.rad(RumpOffset),math.abs(-18-RumpOffset)/10)
	Turn(Head,x_axis,math.rad(-17),1.7)
	Turn(gdfrontleg,x_axis,math.rad(-18-RumpOffset),math.abs(-18-RumpOffset)/10)
	Turn(Ass,y_axis,math.rad(13),1.3)
	WTurn(gdbhleg,x_axis,math.rad(-24),1.8)
	WaitForMove(ghostdance,y_axis)
	while boolIdle== true do
	time=math.ceil(math.random(500,1200))
	Sleep(time)
	swooshTail()
	end
end

function resetLegs()
Hide(gdflegj)
Hide(gdbhlegj)
Show(gdfrontleg)
Show(gdbhleg)
end

function idle()
boolIdle=true
RumpOffset=12
	resetT(tails)
	resetT(piecesTable,22)

	while( boolIdle==true)  do
		if maRa()==true then wiggle()end
		if maRa()==true then standingWave()end
		if maRa()==true then standingGuard()end
		if maRa() == true then pranceStance() end
	resetT(piecesTable,12)
	Sleep(3000)
	resetLegs()
	
	end
	Turn(HeadRump,y_axis,math.rad(0),math.abs(-18-RumpOffset)/10)
	Turn(Head,y_axis,math.rad(0),1.7)
	Move(ghostdance,y_axis,0,0.5)
	WTurn(gdfrontleg,y_axis,math.rad(0),1.8)
	WTurn(gdbhleg,y_axis,math.rad(-18),1.8)
	resetT(piecesTable,42)
end




function script.Create()
	Hide(gdbhlegj)
	Hide(gdflegj)
	Show(gdfrontleg)
	resetT(piecesTable)
	StartThread(spawnAndManageShadows)
	
end

function script.Killed(recentDamage,maxHealth)
		if not GG.GhostDancerOrgCopy then GG.GhostDancerOrgCopy={} end
		if not GG.GhostDancerCopyOrg then GG.GhostDancerCopyOrg={} end
	-- if at death you are the original -- make the copy the original
	if GG.GhostDancerOrgCopy[unitID] and not GG.GhostDancerCopyOrg[unitID] then
		GG.GhostDancerCopyOrg[GG.GhostDancerOrgCopy[unitID]]= nil 
	GG.GhostDancerOrgCopy[unitID]=nil
	end

if GG.GhostDancerCopyOrg[unitID] then
	GG.GhostDancerCopyOrg[unitID] =nil
end
-- if at death you are a copy -- shit out of luck

end
function smokeEmit()

		EmitSfx(shadowemit,1024)

end

function glowTail()
if maRa() == true then
	EmitSfx(shadowemit,1025)
end
end

function threadedLegs(prevtime,time)
	Sleep(prevtime)
	Show(gdbhlegj)
	Show(gdflegj)
	Hide(gdfrontleg)
	Hide(gdbhleg)
	Sleep(time)
	Hide(gdbhlegj)
	Hide(gdflegj)
	Show(gdfrontleg)
	Show(gdbhleg)
end

function walk()
	SetSignalMask(SIG_WALK)
	boolIdle=false

	Turn(ears,x_axis,math.rad(-70),35)
	resetT(piecesTable,22)
	while (true) do
		if maRa()== true then
		smokeEmit()
		end
		--landing
		turnT(tails,y_axis,math.random(-5,5),5)
		turnT(tails,x_axis,math.random(5),5)
		Move(ghostdance,y_axis,0,25)
		Turn(ghostdance,x_axis,math.rad(11),12)
		Turn(gdflegj,x_axis,math.rad(8),0)--8
		Turn(gdfrontleg,x_axis,math.rad(155),0)
		Turn(gdflegj,x_axis,math.rad(222),90)--138
		Turn(gdfrontleg,x_axis,math.rad(-29),90)
		
		Turn(gdbhlegj,x_axis,math.rad(8),0)
		Turn(gdbhleg,x_axis,math.rad(155),0)
		Turn(gdbhlegj,x_axis,math.rad(222),90)--138
		Turn(gdbhleg,x_axis,math.rad(-29),90)
		StartThread(threadedLegs,120,120)
		--placeleghidefunction here
		WaitForMove(ghostdance,y_axis)
		--TouchDown
		Turn(ghostdance,x_axis,math.rad(-2),12)
		Move(ghostdance,y_axis,-2,25)
		Sleep(320)
		
		--anlauf
		Turn(ghostdance,x_axis,math.rad(-8),12)
		Turn(gdflegj,x_axis,math.rad(0),55)
		Turn(gdfrontleg,x_axis,math.rad(108),55)
		Turn(gdbhlegj,x_axis,math.rad(6),55)
		Turn(gdbhleg,x_axis,math.rad(118),55)
		turnT(tails,y_axis,math.random(-5,5),5)
		turnT(tails,x_axis,math.random(-5,5),5)
		--sprung
		glowTail()
		Move(ghostdance,y_axis,6,15)
		StartThread(threadedLegs,120,80)
		turnT(tails,y_axis,math.random(-5,5),5)
		turnT(tails,x_axis,math.random(-5,-2),5)
		WaitForMove(ghostdance,y_axis)
		glowTail()
		Sleep(220)
		glowTail()
		--zenit
		turnT(tails,y_axis,math.random(-5,5),5)
		turnT(tails,x_axis,math.random(-5,5),5)
		Turn(ghostdance,x_axis,math.rad(-2),12)
		glowTail()
	end
	
end





function script.StartMoving()
	Signal(SIG_IDLE)

	Signal(SIG_WALK)
	StartThread(walk)
end

function script.StopMoving()
	Signal(SIG_WALK)
	boolIdle=false
	Turn(ears,x_axis,math.rad(0),35)
	legs_down()
	
	
end

---AIMING & SHOOTING -
function script.AimFromWeapon1() 
	
	return aimpivot 
end

function script.QueryWeapon1() 
	return aimpivot
end

--must return true to allow the weapon to shot. return false denies the weapon from shooting
-- can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon1(heading,pitch)
boolIdle=false
	return true
end

-- called after the weapon has fired
function script.FireWeapon1()
	
	--Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav") 
	
	
end

function script.AimFromWeapon2() 
	
	return aimpivot 
end

function script.QueryWeapon2() 
	return aimpivot
end

--must return true to allow the weapon to shot. return false denies the weapon from shooting
-- can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon2(heading,pitch)
boolIdle=false
	return true
end

-- called after the weapon has fired
function script.FireWeapon2()
	
	--Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav") 
	
	
end