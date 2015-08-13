 include "suddenDeath.lua"
 include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

 center=piece"center"
 piecesTable=makeKeyPiecesTable(unitID,piece)
 RELOAD_TIME=5500

 function script.HitByWeapon ( x, z, weaponDefID, damage ) 
 if boolDeployed==true then return math.floor(math.sqrt(damage))end

 return damage
end

gunTable={piecesTable["GunRoot"],piecesTable["GunRail"],piecesTable["GunSled"],piecesTable["TwinCannon"]}
center=piece"center"
boolStopped=false
boolDeployWanted=false

function deployedDetector()
	while true do
	--if deploy wanted and stop deploy
		if boolDeployWanted ==true and boolStopped==true then
			DeployAnimation()
		end

		if boolDeployWanted == false or boolStopped==false then
			UnDeployAnimation()
		-- if button pressed or moved undeploy
		end
	
		Sleep(500)
	end
end

function MoveAnimation()
	while true do
		if boolDeployWanted==true and boolStopped ==true  or boolDeployed==true then
			walkAnim()
		
		elseif math.random(0,1)==1 then
			idleAnim()
		else
			reseT(piecesTable)
		end 
	
		Sleep(100)
	end

end


function DeployAnimation (time)
syncTurnInTime(Leg61,-48,-84,108,time)
syncTurnInTime(Leg62,35,90,42,time)
syncTurnInTime(Leg63,-63,30,-8,time)

syncTurnInTime(Leg51,-55,111,-46,time)
syncTurnInTime(Leg52,26,-880,89,time)
syncTurnInTime(Leg53,56,19,-121,time)
Sleep(time)
unfoldPlate()

boolDeployed=true			
end

function unfoldPlate()
even=0
uneven=0
	for i=1,7 do
		if i%2 ==0 then
		even= even+12
		Turn(Plate[i],z_axis,math.rad(even),9)
		else
		uneven= uneven-12
		Turn(Plate[i],z_axis,math.rad(uneven),9)
		end
	end
even=0
uneven=0	
	
		for i=7,15 do
		if i%2 ==0 then
		even= even+12
		Turn(Plate[i],z_axis,math.rad(even),9)
		else
		uneven= uneven-12
		Turn(Plate[i],z_axis,math.rad(uneven),9)
		end
	end

end
function UnDeployAnimation()
for i=1,15 do
Turn(Plate[i],z_axis,math.rad(0),9)
end
WaitForTurn(Plate[15],z_axis)
boolDeployed=false
end

function 	unfoldWeapon()
	Turn(TwinCannon,x_axis,math.rad(0),12)
	WaitForTurn(TwinCannon,x_axis) 
	Move(GunSled,z_axis, 0,12)
	Turn(GunRoot,y_axis,math.rad(0),12)
	WaitForTun(GunRoot,y_axis)
	Turn(GunRail,y_axis,math.rad(0),12)
	WaitForTurn(GunRail,y_axis) 
	reseT(gunTable,7,true)

 end
 function fireAnimation() 
	 Turn(TwinCannon,x_axis,math.rad(-42),60)
	 for i=1,20,4 do
	  Move(GunSled,z_axis,-1*i,180/i)
	  WaitForMove(GunSled,z_axis)
	 end
	 Turn(TwinCannon,x_axis,math.rad(-42),30) 
	for i=21,40,4 do
	  Move(GunSled,z_axis,-1*i,180/i)
	  WaitForMove(GunSled,z_axis)
	 end

	 
 end
 
 function 	reloadAnim() 
	resetPiece(TwinCannon,12)
	Sleep(700)
	resetPiece(GunSled,12)
 end 

function 	foldAnim() 		
reseT(gunTable,7,true)
Turn(GunRoot,y_axis,math.rad(-12),12)
WaitForTun(GunRoot,y_axis)
Turn(GunRail,y_axis,math.rad(180),12)
WaitForTurn(GunRail,y_axis) 
Move(GunSled,z_axis,-40,12)
Turn(TwinCannon,x_axis,math.rad(44),12)
WaitForTurn(TwinCannon,x_axis) 

end

function pushForth(fwLeg1,fwLeg2, opBLeg1,opBLeg2,opBLeg3)



end

function MoveLegToFront(fwLeg1,fwLeg2, opBLeg1,opBLeg2,opBLeg3)
syncTurnInTime(Leg61,-48,-84,108,time)


end



centerTurnX=0
function 	walkAnim() 	
forwardTurn=(math.abs(centerTurnX) + math.random(3,10))/2
Turn(Body,x_axis,math.rad(forwardTurn),11)
centerTurnX=forwardTurn
MoveLegToFront(fwLeg1,fwLeg2, opBLeg1,opBLeg2,opBLeg3)
pushForth(fwLeg1,fwLeg2, opBLeg1,opBLeg2,opBLeg3)

Turn(Body,x_axis,math.rad(forwardTurn*-1),11)
centerTurnX=forwardTurn*-1
MoveLegToFront(fwLeg1,fwLeg2, opBLeg1,opBLeg2,opBLeg3)
pushForth(fwLeg1,fwLeg2, opBLeg1,opBLeg2,opBLeg3)

end


cos=0
function 	idleAnim () 
	cos=cos+0.01
	time=800+math.abs(math.cos(cos)*1000)
	
	Move(center,y_axis,-5,7)
	WaitForMove(center,y_axis)
	val=math.random(15,32)
	speed=(val/time)*1000
	offSet=math.random(-1,1)
	equiTurn(Leg11,Leg12,x_axis,val+offset,speed)
	offSet=math.random(-1,1)               
	equiTurn(Leg21,Leg22,x_axis,val+offset,speed)
	offSet=math.random(-1,1)               
	equiTurn(Leg31,Leg32,x_axis,val+offset,speed)
	offSet=math.random(-1,1)               
	equiTurn(Leg41,Leg42,x_axis,val+offset,speed)
	
	val=math.random(20,33)
	speed=(val/time)*1000
	equiTurn(Leg51,Leg52,y_axis,val+offset,speed)
	equiTurn(Leg61,Leg62,y_axis,-1*val+offset,speed)	
	val=math.random(20,33)
	equiTurn(Leg51,Leg52,x_axis,val+offset,speed)
	equiTurn(Leg61,Leg62,x_axis,val+offset,speed)
	Sleep(time)
	WaitForMove(center,y_axis)
	reseT(piecesTable,speed)
	Move(center,y_axis,0,7)
	WaitForMove(center,y_axis)
end 

function script.Create()
 generatepiecesTableAndArrayCode(unitID)
StartThread(deployedDetector)
StartThread(MoveAnimation)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end



function script.QueryWeapon1() 
	return center
end
boolDeployed=false
boolReloaded=true

local SIG_AIM=2
function script.AimWeapon1( Heading ,pitch)	
Signal(SIG_AIM)
SetSignalMask(SIG_AIM)
	--aiming animation: instantly turn the gun towards the enemy
	unfoldWeapon()
	Turn(GunSled,y_axis,-Heading,3.151)
	WaitForTun(Cannon,y_axis)
	return (boolDeployed and boolReloaded)

end

function Reload(Time)
	if boolDeployed==true then
		reloadAnim()
	else 
		foldAnim()
	end
	
Sleep(Time)
boolReloaded=true
end

function script.FireWeapon1()	
boolReloaded=false
fireAnimation()
StartThread(Reload,RELOAD_TIME)
	return true
end



function script.StartMoving()
boolStopped=false
end

local SIG_STOP = 4
function StopAndGo()
Signal(SIG_STOP)
SetSignalMask(SIG_STOP)
Sleep(500)
boolStopped=true
end

function script.StopMoving()
	StartThread(StopAndGo)	
end


					maxspeed=math.ceil(COB.MAX_SPEED *65533)
					function script.Activate()
				 
					SetUnitValue(COB.MAX_SPEED,maxspeed)--sets the speed to 5,2 *65533
						
					boolDeployWanted=true
					return 1
					end

		function script.Deactivate()
					boolDeployWanted=false
					SetUnitValue(COB.MAX_SPEED,1)

					--set the MovementSpeed to zero
		return 0
		end


function script.QueryBuildInfo() 
  return center 
end

function script.QueryNanoPiece()
     return center
end


local Animations = {};

    local map = Spring.GetUnitPieceMap(unitID)
    local offsets = constructSkeleton(unitID,center, {0,0,0})
	
	
	
function PlayAnimation(animname)

	if not Animations[animname] then Spring.Echo(animname) end

    local anim = Animations[animname];
	assert(anim, animname)
    for i = 1, #anim do
        local commands = anim[i].commands;
        for j = 1,#commands do
            local cmd = commands[j];
            animCmd[cmd.c](cmd.p,cmd.a,cmd.t,cmd.s);
        end
        if(i < #anim) then
            local t = anim[i+1]['time'] - anim[i]['time'];
            Sleep(t*33); -- sleep works on milliseconds
        end
    end
end

function constructSkeleton(unit, piece, offset)
    if (offset == nil) then
        offset = {0,0,0};
    end

    local bones = {};
    local info = Spring.GetUnitPieceInfo(unit,piece);

    for i=1,3 do
        info.offset[i] = offset[i]+info.offset[i];
    end 

    bones[piece] = info.offset;
    local map = Spring.GetUnitPieceMap(unit);
    local children = info.children;

    if (children) then
        for i, childName in pairs(children) do
            local childId = map[childName];
            local childBones = constructSkeleton(unit, childId, info.offset);
            for cid, cinfo in pairs(childBones) do
                bones[cid] = cinfo;
            end
        end
    end        
    return bones;
end

