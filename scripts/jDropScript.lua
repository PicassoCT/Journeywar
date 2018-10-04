include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_jw.lua" 
include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 
healFactor=50
center=piece"center"
MoveIt=piece"MoveIt"
Para=piece"Para"
fruit={}
for i=1,19 do
	name="fruit"..i
	fruit[i]=piece(name)
end

function script.Create()
	x,y,z=Spring.GetUnitPosition(unitID)
	gh=Spring.GetGroundHeight(x,z)
	
	Spring.MoveCtrl.Enable(unitID,true)
	if distance(gh,y) < 3 then
		y= gh+ math.random(700,1000)
	end
	Spring.MoveCtrl.SetPosition(unitID,x,y,z)
		
	for i=1,19 do
		Hide(fruit[i])
	end
	
	Spin(MoveIt,y_axis,math.rad(math.random(1,22)),0)

	StartThread(onTheMove,x,y,z)
	StartThread(swingLow)
	x=math.ceil(math.random(1,19))
	Show(fruit[x])
end

function onTheMove(x,y,z)
	
	Spring.SetUnitBlocking(unitID,false)
	Spring.SetUnitNeutral(unitID,true)
	SpeedPerSecond=4
	gh = Spring.GetGroundHeight(x,z)

	while y >  Spring.GetGroundHeight(x,z) do
		y=y-(SpeedPerSecond/10)
		Spring.MoveCtrl.SetPosition(unitID,x,y,z)
		Sleep(33)
	end
	Hide(Para)
	StartThread(healthyFruit,x,y,z)
	dice=math.ceil(math.random(10000,20000))
	Sleep(dice)
	Spring.DestroyUnit(unitID,true,true)
end

TransformTable = getDreamTreeTransformUnitTypeTable(UnitDefNames)
myTeamID=Spring.GetUnitTeam(unitID)

function healthyFruit(x,y, z)
	while true do
		process(getAllInSphere(x,z,25,unitID),
			function(id)
				if id and id ~= unitID then
				team=Spring.GetUnitTeam(id)
				if team == myTeamID then
					hp=Spring.GetUnitHealth(id)
					if hp then
						Spring.SetUnitHealth(id,hp+healFactor)
					end				
				elseif TransformTable[Spring.GetUnitDefID(id)] then
					transform(id)
				end
				Spring.DestroyUnit(unitID,true,true)

				end
			end
			)
		Sleep(400)
	end
end


function transform(id)
                typeToTransferInto = TransformTable[Spring.GetUnitDefID(id)]
				resultID = transformUnitInto(id, typeToTransferInto)
end

function swingLow()
	while true do
	xval=math.random(1,5)
	zval=math.random(1,5)
	deci= 1
	if math.random(0,1)==1 then deci=-1 end

	Turn(MoveIt,x_axis,math.rad(xval),0.1)
	Turn(MoveIt,z_axis,math.rad(zval*deci),0.1)
	if math.abs(xval) > math.abs(zval) then
	WaitForTurn(MoveIt,x_axis)
	else
	WaitForTurn(MoveIt,z_axis)
	end
	Sleep(100)
	Turn(MoveIt,x_axis,math.rad(xval*-1),0.1)
	Turn(MoveIt,z_axis,math.rad(zval*deci*-1),0.1)
	if math.abs(xval) > math.abs(zval) then
	WaitForTurn(MoveIt,x_axis)
	else
	WaitForTurn(MoveIt,z_axis)
	end
	Sleep(100)
	end
end



